import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import 'call_details_page.dart';

class CallHistoryPage extends StatefulWidget {
  const CallHistoryPage({super.key});

  @override
  State<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> {
  final Set<String> _selectedCallIds = {};
  bool _isSelectionMode = false;

  void _toggleSelection(String callId) {
    setState(() {
      if (_selectedCallIds.contains(callId)) {
        _selectedCallIds.remove(callId);
      } else {
        _selectedCallIds.add(callId);
      }
      
      if (_selectedCallIds.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _startSelection(String callId) {
    setState(() {
      _isSelectionMode = true;
      _selectedCallIds.add(callId);
    });
  }

  Future<void> _deleteSelectedCalls() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Calls?'),
        content: Text('Delete ${_selectedCallIds.length} calls from your history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final batch = FirebaseFirestore.instance.batch();
      for (final callId in _selectedCallIds) {
        final docRef = FirebaseFirestore.instance.collection('calls').doc(callId);
        // Use set with merge to ensure field exists, or update if document exists.
        // ArrayUnion creates field if missing.
        batch.update(docRef, {
          'deletedBy': FieldValue.arrayUnion([currentUserId])
        });
      }
      
      await batch.commit();
      
      if (mounted) {
        setState(() {
          _selectedCallIds.clear();
          _isSelectionMode = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Calls deleted')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() {
                  _isSelectionMode = false;
                  _selectedCallIds.clear();
                }),
              )
            : null,
        title: _isSelectionMode
            ? Text('${_selectedCallIds.length} Selected')
            : const Text('Calls', style: AppTypography.h3),
        actions: [
          if (_isSelectionMode)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteSelectedCalls,
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search calls coming soon!')),
                );
              },
            ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final currentUserId = FirebaseAuth.instance.currentUser?.uid;
          
          if (currentUserId == null || currentUserId.isEmpty) {
            return const Center(child: Text('Please login to view calls'));
          }
          
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('calls')
                .orderBy('createdAt', descending: true)
                .limit(100)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final allCalls = snapshot.data?.docs ?? [];
              final calls = allCalls.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final participantIds = data['participantIds'] as List<dynamic>?;
                final deletedBy = data['deletedBy'] as List<dynamic>?;
                
                final isParticipant = participantIds?.contains(currentUserId) ?? false;
                final isDeleted = deletedBy?.contains(currentUserId) ?? false;
                
                return isParticipant && !isDeleted;
              }).toList();
              
              if (calls.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No Calls Yet',
                        style: AppTypography.h3.copyWith(color: Colors.grey[600]),
                      ),
                       const SizedBox(height: 8),
                      Text(
                        'Your call history will appear here',
                        style: AppTypography.bodyLarge.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                itemCount: calls.length,
                itemBuilder: (context, index) {
                  final callData = calls[index].data() as Map<String, dynamic>;
                  final callId = calls[index].id;
                  final isSelected = _selectedCallIds.contains(callId);
                  
                  // Get other participant info for navigation
                  final callerId = callData['callerId'] as String?;
                  final isOutgoing = callerId == currentUserId;
                  String otherName = 'Unknown';
                  String? otherAvatar;
                  String? otherId;
                  
                  if (isOutgoing) {
                    otherName = callData['recipientName'] as String? ?? 
                                callData['calleeName'] as String? ?? 'Unknown';
                    otherAvatar = callData['recipientAvatarUrl'] as String? ??
                                  callData['calleeAvatarUrl'] as String?;
                    otherId = callData['recipientId'] as String? ??
                              callData['calleeId'] as String?;
                  } else {
                    otherName = callData['callerName'] as String? ?? 'Unknown';
                    otherAvatar = callData['callerAvatarUrl'] as String?;
                    otherId = callData['callerId'] as String?;
                  }
                  
                  return _CallListItem(
                    callData: callData,
                    isSelected: isSelected,
                    isSelectionMode: _isSelectionMode,
                    onTap: () {
                      if (_isSelectionMode) {
                        _toggleSelection(callId);
                      } else {
                        // Navigate to call details page
                        if (otherId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CallDetailsPage(
                                recipientId: otherId!,
                                recipientName: otherName,
                                recipientAvatarUrl: otherAvatar,
                                chatId: callData['chatId'] as String?,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    onLongPress: () => _startSelection(callId),
                    onCall: () {
                      // Quick callback - navigate to call details
                      if (otherId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CallDetailsPage(
                              recipientId: otherId!,
                              recipientName: otherName,
                              recipientAvatarUrl: otherAvatar,
                              chatId: callData['chatId'] as String?,
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: !_isSelectionMode ? FloatingActionButton(
        heroTag: 'calls_fab',
        onPressed: () {
          context.push('/home/contacts');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_call, color: Colors.white),
      ) : null,
    );
  }
}

class _CallListItem extends StatelessWidget {
  final Map<String, dynamic> callData;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onCall;
  
  const _CallListItem({
    required this.callData,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onLongPress,
    required this.onCall,
  });
  
  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    
    final type = callData['type'] as String? ?? 'voice';
    final status = callData['status'] as String? ?? 'missed';
    final createdAt = callData['createdAt'];
    
    // Determine call direction
    final callerId = callData['callerId'] as String?;
    final isOutgoing = callerId == currentUserId;
    
    // Get OTHER participant info
    String otherName = 'Unknown';
    String? otherAvatar;
    
    if (isOutgoing) {
      otherName = callData['recipientName'] as String? ?? 
                  callData['calleeName'] as String? ?? 'Unknown';
      otherAvatar = callData['recipientAvatarUrl'] as String? ??
                    callData['calleeAvatarUrl'] as String?;
    } else {
      otherName = callData['callerName'] as String? ?? 'Unknown';
      otherAvatar = callData['callerAvatarUrl'] as String?;
    }
    
    DateTime? callTime;
    if (createdAt is Timestamp) {
      callTime = createdAt.toDate();
    }
    
    final isVideo = type.contains('video');
    final isMissed = status == 'missed';
    final isDeclined = status == 'declined';
    final isFailed = isMissed || isDeclined || status == 'failed';
    
    // Status color
    Color statusColor = isFailed ? Colors.red : Colors.green;
    
    // Icon based on direction and status
    IconData statusIcon;
    if (isOutgoing) {
      statusIcon = Icons.call_made;
    } else {
      statusIcon = isMissed ? Icons.call_missed : Icons.call_received;
    }

    return Container(
      color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: Stack(
          children: [
             CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              backgroundImage: otherAvatar != null ? NetworkImage(otherAvatar) : null,
              child: otherAvatar == null
                  ? Text(
                      (otherName.isNotEmpty ? otherName[0] : '?').toUpperCase(),
                      style: AppTypography.bodyLarge.copyWith(color: AppColors.primary),
                    )
                  : null,
            ),
            if (isSelected)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ),
          ],
        ),
        title: Text(
          otherName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Icon(statusIcon, size: 14, color: statusColor),
            const SizedBox(width: 4),
            Text(
              callTime != null ? DateFormat('MMM d, HH:mm').format(callTime) : '',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
        trailing: !isSelectionMode ? IconButton(
          icon: Icon(
            isVideo ? Icons.videocam_outlined : Icons.call_outlined,
            color: AppColors.primary,
          ),
          onPressed: onCall,
        ) : null,
      ),
    );
  }
}
