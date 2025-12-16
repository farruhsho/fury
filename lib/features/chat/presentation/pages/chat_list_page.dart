import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/services/connectivity_service.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../widgets/chat_list_item.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final ConnectivityService _connectivityService = ConnectivityService();
  late StreamSubscription<bool> _connectivitySubscription;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _isOnline = _connectivityService.isOnline;
    _connectivitySubscription = _connectivityService.connectivityStream.listen((isOnline) {
      if (mounted) {
        setState(() => _isOnline = isOnline);
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatBloc>()..add(const ChatEvent.loadChats()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chats',
            style: AppTypography.h3,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.push('/home/search-users');
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                context.push('/home/settings');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Offline indicator banner
            if (!_isOnline)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.orange.shade100,
                child: Row(
                  children: [
                    Icon(Icons.cloud_off, color: Colors.orange.shade800, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'You\'re offline. Showing cached chats.',
                      style: TextStyle(color: Colors.orange.shade900, fontSize: 13),
                    ),
                  ],
                ),
              ),
            // Chat list
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const LoadingWidget(),
                    error: (message) => ErrorDisplayWidget(
                      message: message,
                      onRetry: () {
                        context.read<ChatBloc>().add(const ChatEvent.loadChats());
                      },
                    ),
                    loaded: (chats) {
                      if (chats.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '👋',
                                style: TextStyle(fontSize: 64),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Hi!',
                                style: AppTypography.h2.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Start a conversation',
                                style: AppTypography.bodyLarge.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.push('/home/search-users');
                                },
                                icon: const Icon(Icons.search),
                                label: const Text('Search Users'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatListItem(chat: chats[index]);
                        },
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'chat_list_fab',
          onPressed: () {
            context.push('/home/search-users');
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}
