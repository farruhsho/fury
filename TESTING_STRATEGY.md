# Fury Messenger - Testing Strategy

## Test Coverage Goals

| Category | Target Coverage |
|----------|-----------------|
| Unit Tests | 80%+ |
| Widget Tests | 70%+ |
| Integration Tests | Key flows |

---

## Unit Tests

### Core Services

```dart
// test/unit/encryption_service_test.dart
void main() {
  group('EncryptionService', () {
    late EncryptionService service;

    setUp(() {
      service = EncryptionService();
      service.init();
    });

    test('should generate identity key pair', () async {
      final keyPair = await service.generateIdentityKeyPair();
      expect(keyPair.publicKey, isNotEmpty);
      expect(keyPair.privateKey, isNotEmpty);
    });

    test('should encrypt and decrypt message', () async {
      final sessionKey = await service.generateSessionKey();
      const plaintext = 'Hello, World!';
      
      final encrypted = await service.encryptMessage(plaintext, sessionKey);
      final decrypted = await service.decryptMessage(encrypted, sessionKey);
      
      expect(decrypted, equals(plaintext));
    });

    test('should produce different ciphertext each time', () async {
      final sessionKey = await service.generateSessionKey();
      const plaintext = 'Test message';
      
      final encrypted1 = await service.encryptMessage(plaintext, sessionKey);
      final encrypted2 = await service.encryptMessage(plaintext, sessionKey);
      
      expect(encrypted1, isNot(equals(encrypted2)));
    });
  });
}
```

### Use Cases

```dart
// test/unit/send_message_usecase_test.dart
void main() {
  group('SendMessageUseCase', () {
    late SendMessageUseCase useCase;
    late MockMessageRepository mockRepository;

    setUp(() {
      mockRepository = MockMessageRepository();
      useCase = SendMessageUseCase(mockRepository);
    });

    test('should call repository.sendMessage', () async {
      when(mockRepository.sendMessage(any, any))
          .thenAnswer((_) async => const Right(null));

      await useCase(chatId: 'chat1', text: 'Hello');

      verify(mockRepository.sendMessage('chat1', any)).called(1);
    });

    test('should return Failure on error', () async {
      when(mockRepository.sendMessage(any, any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final result = await useCase(chatId: 'chat1', text: 'Hello');

      expect(result.isLeft(), isTrue);
    });
  });
}
```

### BLoCs

```dart
// test/unit/message_bloc_test.dart
void main() {
  group('MessageBloc', () {
    late MessageBloc bloc;
    late MockGetMessagesUseCase mockGetMessages;
    late MockSendMessageUseCase mockSendMessage;

    setUp(() {
      mockGetMessages = MockGetMessagesUseCase();
      mockSendMessage = MockSendMessageUseCase();
      bloc = MessageBloc(
        getMessagesUseCase: mockGetMessages,
        sendMessageUseCase: mockSendMessage,
        // ... other dependencies
      );
    });

    blocTest<MessageBloc, MessageState>(
      'emits [loading, loaded] when LoadMessages succeeds',
      build: () {
        when(mockGetMessages(any)).thenAnswer(
          (_) => Stream.value(Right([testMessage])),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(MessageEvent.loadMessages('chat1')),
      expect: () => [
        MessageState.loading(),
        MessageState.loaded([testMessage]),
      ],
    );
  });
}
```

---

## Widget Tests

### UI Components

```dart
// test/widget/message_bubble_test.dart
void main() {
  group('MessageBubble', () {
    testWidgets('displays message text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MessageBubble(
            message: testMessage,
            isMe: false,
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('shows read receipt for sent messages', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MessageBubble(
            message: testMessage.copyWith(status: MessageStatus.read),
            isMe: true,
          ),
        ),
      );

      expect(find.byIcon(Icons.done_all), findsOneWidget);
    });

    testWidgets('displays reaction bar when reactions exist', (tester) async {
      final messageWithReactions = testMessage.copyWith(
        reactions: {'❤️': ['user1', 'user2']},
      );
      
      await tester.pumpWidget(
        MaterialApp(
          home: MessageBubble(
            message: messageWithReactions,
            isMe: false,
          ),
        ),
      );

      expect(find.text('❤️ 2'), findsOneWidget);
    });
  });
}
```

### Pages

```dart
// test/widget/chat_page_test.dart
void main() {
  group('ChatPage', () {
    late MockMessageBloc mockBloc;

    setUp(() {
      mockBloc = MockMessageBloc();
    });

    testWidgets('shows loading indicator while loading', (tester) async {
      when(() => mockBloc.state).thenReturn(MessageState.loading());
      
      await tester.pumpWidget(
        BlocProvider<MessageBloc>.value(
          value: mockBloc,
          child: MaterialApp(home: ChatPage(chatId: 'chat1')),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays messages when loaded', (tester) async {
      when(() => mockBloc.state).thenReturn(
        MessageState.loaded([testMessage]),
      );
      
      await tester.pumpWidget(
        BlocProvider<MessageBloc>.value(
          value: mockBloc,
          child: MaterialApp(home: ChatPage(chatId: 'chat1')),
        ),
      );

      expect(find.byType(MessageBubble), findsOneWidget);
    });
  });
}
```

---

## Integration Tests

### Authentication Flow

```dart
// integration_test/auth_flow_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow', () {
    testWidgets('user can login and see chat list', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(find.byKey(Key('email_field')), 'test@test.com');
      await tester.enterText(find.byKey(Key('password_field')), 'password');
      
      // Tap login button
      await tester.tap(find.byKey(Key('login_button')));
      await tester.pumpAndSettle();

      // Verify navigation to chat list
      expect(find.byType(ChatListPage), findsOneWidget);
    });
  });
}
```

### Message Flow

```dart
// integration_test/message_flow_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Message Flow', () {
    testWidgets('user can send and receive messages', (tester) async {
      // Login first
      await loginAsTestUser(tester);

      // Open chat
      await tester.tap(find.text('Test Contact'));
      await tester.pumpAndSettle();

      // Send message
      await tester.enterText(find.byType(TextField), 'Hello!');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify message appears
      expect(find.text('Hello!'), findsOneWidget);
    });
  });
}
```

---

## Test Commands

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/encryption_service_test.dart

# Run integration tests
flutter test integration_test/

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

---

## Mocking Strategy

### Dependencies to Mock

| Dependency | Mock Approach |
|------------|---------------|
| Firebase Auth | `MockFirebaseAuth` |
| Firestore | `FakeFirebaseFirestore` |
| BLoCs | `MockBloc` from `bloc_test` |
| Use Cases | `MockX` via `mocktail` |
| Services | Manual mock implementations |

### Example Mock Setup

```dart
// test/mocks.dart
class MockMessageRepository extends Mock implements MessageRepository {}
class MockEncryptionService extends Mock implements EncryptionService {}
class MockMessageBloc extends MockBloc<MessageEvent, MessageState> 
    implements MessageBloc {}

// test/fixtures.dart
final testMessage = MessageEntity(
  id: 'msg1',
  chatId: 'chat1',
  senderId: 'user1',
  text: 'Hello World',
  createdAt: DateTime.now(),
  status: MessageStatus.sent,
);
```

---

## CI/CD Test Pipeline

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Analyze code
        run: flutter analyze
      
      - name: Run tests
        run: flutter test --coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info
```

---

*Last updated: December 2024*
