import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Status upload screen - select recipients for status
class StatusUploadScreen extends StatefulWidget {
  final String? mediaPath;
  final bool isVideo;
  final String? caption;

  const StatusUploadScreen({
    super.key,
    this.mediaPath,
    this.isVideo = false,
    this.caption,
  });

  @override
  State<StatusUploadScreen> createState() => _StatusUploadScreenState();
}

class _StatusUploadScreenState extends State<StatusUploadScreen> {
  final _captionController = TextEditingController();
  final Set<String> _selectedContacts = {};
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;
  bool _selectAll = true;
  int _selectedLayout = 3; // Default layout

  @override
  void initState() {
    super.initState();
    _captionController.text = widget.caption ?? '';
    _loadContacts();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: currentUser.uid)
          .limit(50)
          .get();

      final contacts = usersSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['displayName'] ?? data['name'] ?? 'Unknown',
          'phone': data['phoneNumber'] ?? '',
          'avatarUrl': data['avatarUrl'] ?? data['photoUrl'],
        };
      }).toList();

      setState(() {
        _contacts = contacts;
        if (_selectAll) {
          _selectedContacts.addAll(contacts.map((c) => c['id'] as String));
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _toggleContact(String contactId) {
    setState(() {
      if (_selectedContacts.contains(contactId)) {
        _selectedContacts.remove(contactId);
        _selectAll = false;
      } else {
        _selectedContacts.add(contactId);
        if (_selectedContacts.length == _contacts.length) {
          _selectAll = true;
        }
      }
    });
  }

  Future<void> _uploadStatus() async {
    if (_selectedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите получателей')),
      );
      return;
    }

    // TODO: Upload status to Firebase
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Статус опубликован!')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _uploadStatus,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Готово', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Media preview
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: widget.mediaPath == null || widget.mediaPath!.isEmpty
                    ? const Center(
                        child: Icon(Icons.add_photo_alternate, color: Colors.grey, size: 64),
                      )
                    : widget.isVideo
                        ? const Center(child: Icon(Icons.play_circle, color: Colors.white, size: 64))
                        : Image.network(
                            widget.mediaPath!,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(Icons.image, color: Colors.grey, size: 64),
                            ),
                          ),
              ),
            ),

            // Recipient list
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        itemCount: _contacts.length,
                        itemBuilder: (context, index) {
                          final contact = _contacts[index];
                          final isSelected = _selectedContacts.contains(contact['id']);
                          return _buildContactTile(contact, isSelected);
                        },
                      ),
              ),
            ),

            // Bottom toolbar
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: AppColors.surfaceDark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Caption input row
                  Row(
                    children: [
                      const Icon(Icons.apps, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Text('GIF', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 12),
                      const Icon(Icons.sticky_note_2_outlined, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Icon(Icons.text_fields, color: Colors.grey),
                      const SizedBox(width: 12),
                      const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.mic, color: AppColors.primary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Layout options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      final cols = index + 1;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedLayout = cols),
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedLayout == cols 
                                  ? Colors.white 
                                  : Colors.grey.shade600,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _buildLayoutIcon(cols),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // FAB for send
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _uploadStatus,
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact, bool isSelected) {
    final name = contact['name'] as String;
    final phone = contact['phone'] as String;
    final avatarUrl = contact['avatarUrl'] as String?;

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
        child: avatarUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Text(
        name,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: phone.isNotEmpty
          ? Text(
              phone,
              style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
            )
          : null,
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textSecondaryLight,
            width: 2,
          ),
          color: isSelected ? AppColors.primary : Colors.transparent,
        ),
        child: isSelected
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
      onTap: () => _toggleContact(contact['id'] as String),
    );
  }

  Widget _buildLayoutIcon(int cols) {
    return GridView.count(
      crossAxisCount: cols.clamp(2, 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(cols.clamp(2, 4) * 2, (_) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }
}
