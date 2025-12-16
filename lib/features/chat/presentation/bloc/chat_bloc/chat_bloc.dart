import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../domain/entities/chat_entity.dart';
import '../../../domain/usecases/create_chat_usecase.dart';
import '../../../domain/usecases/get_chats_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatsUseCase;
  final CreateChatUseCase createChatUseCase;

  ChatBloc({
    required this.getChatsUseCase,
    required this.createChatUseCase,
  }) : super(const ChatState.initial()) {
    on<_LoadChats>(_onLoadChats);
    on<_CreateChat>(_onCreateChat);
  }

  Future<void> _onLoadChats(_LoadChats event, Emitter<ChatState> emit) async {
    print('💬 [CHAT_BLOC] Loading chats...');
    emit(const ChatState.loading());
    
    await emit.forEach(
      getChatsUseCase(),
      onData: (result) => result.fold(
        (failure) {
          print('❌ [CHAT_BLOC] Error loading chats: ${ErrorHandler.getUserMessage(failure)}');
          return ChatState.error(ErrorHandler.getUserMessage(failure));
        },
        (chats) {
          print('✅ [CHAT_BLOC] Loaded ${chats.length} chats');
          return ChatState.loaded(chats);
        },
      ),
      onError: (error, stackTrace) {
        print('❌ [CHAT_BLOC] Stream error: $error');
        return ChatState.error(error.toString());
      },
    );
  }

  Future<void> _onCreateChat(_CreateChat event, Emitter<ChatState> emit) async {
    // We don't want to replace the list with loading state if we are just creating a chat
    // But we might want to show a loading indicator somewhere.
    // For now, let's keep the current state but maybe emit a side effect?
    // BLoC state is single stream.
    // We can emit loading then back to loaded?
    // Or we can rely on the stream to update the list.
    // But we need to navigate to the new chat.
    
    // Let's emit a specific state for creation success?
    // But that would replace the list.
    // This is a common BLoC dilemma.
    // Usually we use a separate BLoC for actions or handle it carefully.
    // Or we can have `ChatCreated` state which contains the list AND the new ID?
    // Or we just use `Listener` in UI to handle navigation.
    
    final result = await createChatUseCase(
      participantIds: event.participantIds,
      type: event.type,
      groupName: event.groupName,
    );

    result.fold(
      (failure) => emit(ChatState.error(ErrorHandler.getUserMessage(failure))),
      (chatId) => emit(ChatState.chatCreated(chatId)),
    );
    
    // After creating, we should probably go back to loaded state?
    // The stream subscription in _onLoadChats is still active?
    // No, emit.forEach handles the stream. If we emit another state, does it cancel the stream?
    // Yes, emit.forEach blocks until the stream is done or handler is cancelled.
    // If we emit from another handler, it might conflict.
    
    // Actually, `emit.forEach` is a subscription.
    // If we want to support other events while listening, we should be careful.
    // `emit.forEach` returns a Future that completes when the stream completes.
    // It doesn't block other event handlers from running, but if other handlers emit,
    // it might be fine.
    
    // However, if we emit `ChatCreated`, the UI will see that.
    // Then the stream might emit a new list of chats (because we created one).
    // Then `emit.forEach`'s `onData` will fire and emit `ChatState.loaded`.
    // So we might get `ChatCreated` then `Loaded`.
    // This seems acceptable.
  }
}
