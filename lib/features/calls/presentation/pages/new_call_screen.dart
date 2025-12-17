import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// New Call screen - for initiating calls
class NewCallScreen extends StatefulWidget {
  const NewCallScreen({super.key});

  @override
  State<NewCallScreen> createState() => _NewCallScreenState();
}

class _NewCallScreenState extends State<NewCallScreen> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _frequentContacts = [];
  List<Map<String, dynamic>> _allContacts = [];
  bool _isLoading = true;
  bool _showTip = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Load contacts
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: user.uid)
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

      // Simulate frequent contacts (first 5)
      final frequent = contacts.take(5).toList();

      setState(() {
        _frequentContacts = frequent;
        _allContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _startAudioCall(String contactId) {
    context.push('/call/$contactId', extra: {'isVideo': false});
  }

  void _startVideoCall(String contactId) {
    context.push('/call/$contactId', extra: {'isVideo': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: AppColors.textPrimaryLight),
          decoration: const InputDecoration(
            hintText: 'Поиск по имени или номеру',
            hintStyle: TextStyle(color: AppColors.textSecondaryLight),
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() {}),
        ),
        actions: [
          IconButton(
            icon: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.paste, color: Colors.white, size: 16),
            ),
            onPressed: () {
              // Paste number
            },
          ),
          IconButton(
            icon: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.cached, color: Colors.white, size: 16),
            ),
            onPressed: () {
              // Switch camera/audio
            },
          ),
          PopupMenuButton<String>(
            icon: const Text('Aa', style: TextStyle(color: AppColors.textPrimaryLight)),
            color: AppColors.surfaceDark,
            onSelected: (value) {},
            itemBuilder: (context) => [],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Tip banner
                if (_showTip)
                  Container(
                    margin: const EdgeInsets.all(AppSpacing.md),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Новинка: попробуйте стикер с реакцией',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          color: AppColors.textSecondaryLight,
                          onPressed: () => setState(() => _showTip = false),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                        ),
                      ],
                    ),
                  ),

                // Quick actions
                _buildQuickAction(
                  icon: Icons.link,
                  iconColor: AppColors.primary,
                  title: 'Новая ссылка на звонок',
                  onTap: () => _showCallLinkDialog(context),
                ),
                _buildQuickAction(
                  icon: Icons.dialpad,
                  iconColor: AppColors.primary,
                  title: 'Позвонить на номер',
                  onTap: () => _showDialPad(context),
                ),
                _buildQuickAction(
                  icon: Icons.person_add,
                  iconColor: AppColors.primary,
                  title: 'Новый контакт',
                  trailing: const Icon(Icons.qr_code, color: AppColors.textSecondaryLight),
                  onTap: () => context.push('/add-contact'),
                ),
                _buildQuickAction(
                  icon: Icons.calendar_today,
                  iconColor: AppColors.primary,
                  title: 'Запланировать звонок',
                  onTap: () => _showScheduleCall(context),
                ),

                // Frequent contacts
                if (_frequentContacts.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm,
                    ),
                    child: Text(
                      'Часто общаетесь',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                  ..._frequentContacts.map((c) => _buildContactTile(c)),
                ],

                // All contacts
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm,
                  ),
                  child: Text(
                    'Все контакты',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ),
                ..._allContacts.map((c) => _buildContactTile(c)),
              ],
            ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required Color iconColor,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    final name = contact['name'] as String;
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primary),
            onPressed: () => _startAudioCall(contact['id']),
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.primary),
            onPressed: () => _startVideoCall(contact['id']),
          ),
        ],
      ),
    );
  }

  void _showCallLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Ссылка на звонок', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Создайте ссылку для приглашения людей в звонок',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'fury.app/call/abc123',
                      style: TextStyle(color: AppColors.textPrimaryLight),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: AppColors.primary),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ссылка скопирована')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Закрыть', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Share link
            },
            child: const Text('Поделиться', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showDialPad(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DialPadSheet(
        onCall: (number) {
          Navigator.pop(ctx);
          // Start call to number
        },
      ),
    );
  }

  void _showScheduleCall(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((time) {
          if (time != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Звонок запланирован на ${date.day}.${date.month} в ${time.hour}:${time.minute.toString().padLeft(2, '0')}'),
              ),
            );
          }
        });
      }
    });
  }
}

/// Dial pad sheet for calling numbers
class DialPadSheet extends StatefulWidget {
  final ValueChanged<String> onCall;

  const DialPadSheet({super.key, required this.onCall});

  @override
  State<DialPadSheet> createState() => _DialPadSheetState();
}

class _DialPadSheetState extends State<DialPadSheet> {
  String _number = '';

  void _addDigit(String digit) {
    setState(() => _number += digit);
  }

  void _removeDigit() {
    if (_number.isNotEmpty) {
      setState(() => _number = _number.substring(0, _number.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          
          // Number display
          Text(
            _number.isEmpty ? 'Введите номер' : _number,
            style: AppTypography.h2.copyWith(
              color: _number.isEmpty ? AppColors.textSecondaryLight : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 24),

          // Dial pad
          for (var row in [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9'], ['*', '0', '#']])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((digit) => _buildDialButton(digit)).toList(),
              ),
            ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Delete button
              IconButton(
                icon: const Icon(Icons.backspace, color: AppColors.textSecondaryLight),
                onPressed: _removeDigit,
              ),
              // Call button
              FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: _number.isNotEmpty ? () => widget.onCall(_number) : null,
                child: const Icon(Icons.call, color: Colors.white),
              ),
              // Video call button
              IconButton(
                icon: const Icon(Icons.videocam, color: AppColors.primary),
                onPressed: _number.isNotEmpty ? () => widget.onCall(_number) : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDialButton(String digit) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            digit,
            style: AppTypography.h2.copyWith(color: AppColors.textPrimaryLight),
          ),
        ),
      ),
    );
  }
}
