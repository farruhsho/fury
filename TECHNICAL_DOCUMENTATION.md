# Fury Messenger - Technical Documentation

## 📋 Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Project Structure](#project-structure)
3. [Core Technologies](#core-technologies)
4. [Feature Modules](#feature-modules)
5. [Security Implementation](#security-implementation)
6. [WebRTC Call System](#webrtc-call-system)
7. [State Management](#state-management)
8. [Data Flow](#data-flow)
9. [Testing Strategy](#testing-strategy)
10. [Deployment](#deployment)

---

## Architecture Overview

Fury Messenger follows **Clean Architecture** with three distinct layers:

```
┌─────────────────────────────────────────────┐
│              Presentation Layer             │
│    (Widgets, Pages, BLoC, UI Components)    │
├─────────────────────────────────────────────┤
│               Domain Layer                  │
│  (Entities, UseCases, Repository Interfaces)│
├─────────────────────────────────────────────┤
│                Data Layer                   │
│  (Repositories, Models, DataSources, APIs)  │
└─────────────────────────────────────────────┘
```

### Design Principles
- **Separation of Concerns**: Each layer has distinct responsibilities
- **Dependency Inversion**: Upper layers depend on abstractions
- **Single Responsibility**: Each class has one reason to change
- **DRY**: Shared code via core utilities and services

---

## Project Structure

```
lib/
├── app/                    # App configuration
│   ├── app.dart           # MaterialApp setup
│   ├── app_router.dart    # GoRouter navigation
│   └── theme/             # Theming (colors, typography, spacing)
│
├── core/                   # Shared utilities
│   ├── animations/        # Custom animations
│   ├── encryption/        # E2E encryption services
│   ├── errors/            # Error handling & failures
│   ├── providers/         # Locale, theme providers
│   ├── services/          # Media compression, queue, voice-to-text
│   └── widgets/           # Reusable UI components
│
├── features/               # Feature modules
│   ├── auth/              # Authentication
│   ├── calls/             # WebRTC voice/video calls
│   ├── chat/              # Messaging core
│   ├── ai/                # AI-powered features
│   └── profile/           # User profile & settings
│
├── injection_container.dart  # Dependency injection (GetIt)
└── main.dart                 # Entry point
```

---

## Core Technologies

| Technology | Purpose | Version |
|------------|---------|---------|
| Flutter | Cross-platform UI | 3.x |
| Dart | Programming language | 3.x |
| Firebase Auth | Authentication | Latest |
| Cloud Firestore | Real-time database | Latest |
| Firebase Storage | File storage | Latest |
| flutter_bloc | State management | ^8.0 |
| flutter_webrtc | Video/voice calls | ^0.9 |
| freezed | Immutable classes | ^2.0 |
| get_it | Dependency injection | ^7.0 |
| go_router | Navigation | ^12.0 |
| hive | Local storage | ^2.0 |

---

## Feature Modules

### Authentication (`features/auth/`)
- Email/password authentication
- Phone verification
- Session management
- Token refresh

### Chat (`features/chat/`)
- Real-time messaging via Firestore streams
- Message types: text, image, video, audio, document
- Reactions, replies, forwarding
- Disappearing messages
- Group chats & broadcast lists
- Message search & pinning

### Calls (`features/calls/`)
- WebRTC peer-to-peer connections
- Firestore-based signaling
- STUN/TURN server integration
- Call notifications

### AI Features (`features/ai/`)
- Smart reply suggestions
- Message translation
- Text summarization
- AI chatbot assistance

---

## Security Implementation

### End-to-End Encryption

```
┌──────────┐                    ┌──────────┐
│  User A  │                    │  User B  │
└────┬─────┘                    └────┬─────┘
     │                               │
     │  1. Generate Key Pair         │
     │  (Ed25519 Identity Key)       │
     │                               │
     │  2. Publish Public Key ──────▶│
     │     to Firestore              │
     │                               │
     │◀──────────────────────────────│ 3. Fetch Public Key
     │                               │
     │  4. Key Agreement             │
     │  (X25519 ECDH)                │
     │                               │
     │  5. Derive Session Key        │
     │  (HKDF-SHA256)                │
     │                               │
     │  6. Encrypt Message ─────────▶│
     │  (AES-256-GCM)                │
     │                               │
```

**Key Files:**
- `lib/core/encryption/encryption_service.dart`
- `lib/core/encryption/key_exchange_manager.dart`

### Security Features
- AES-256-GCM for message encryption
- X25519 for key exchange
- HKDF-SHA256 for key derivation
- Forward secrecy via session key rotation
- Secure local storage for private keys

---

## WebRTC Call System

### Signaling Flow

```
┌──────────┐    Firestore     ┌──────────┐
│  Caller  │◀────────────────▶│  Callee  │
└────┬─────┘                  └────┬─────┘
     │                             │
     │  1. Create Offer            │
     │  2. Store in Firestore ────▶│
     │                             │ 3. Receive Offer
     │                             │ 4. Create Answer
     │◀──────────────────────────── 5. Store Answer
     │                             │
     │  6. Exchange ICE Candidates │
     │◀───────────────────────────▶│
     │                             │
     │  7. Peer Connection Ready   │
     │═════════════════════════════│
```

**Key Files:**
- `lib/features/calls/data/datasources/webrtc_service.dart`
- `lib/features/calls/data/datasources/call_signaling_datasource.dart`
- `lib/features/calls/presentation/bloc/call_bloc.dart`

---

## State Management

### BLoC Pattern

```dart
// Events → BLoC → States

┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Events    │────▶│    BLoC     │────▶│   States    │
└─────────────┘     └─────────────┘     └─────────────┘
      ▲                   │                   │
      │                   │                   │
      │              Use Cases                │
      │                   │                   ▼
      └───────────────────│───────────────────┐
                          ▼                   │
                    Repository                │
                          │                   │
                    DataSources     UI Rebuilds
```

**Example:**
```dart
// Event
add(MessageEvent.sendMessage(chatId: id, text: text));

// BLoC handles
Future<void> _onSendMessage(event, emit) async {
  final result = await sendMessageUseCase(/*...*/);
  result.fold(
    (failure) => emit(MessageState.error(/*...*/)),
    (success) => {/* stream updates */},
  );
}
```

---

## Data Flow

### Message Sending Flow

```
1. User types message
        ↓
2. MessageInput widget
        ↓
3. MessageBloc.add(SendMessage)
        ↓
4. SendMessageUseCase
        ↓
5. MessageRepository.send()
        ↓
6. EncryptionService.encrypt()
        ↓
7. MessageQueueService (if offline)
        ↓
8. ChatRemoteDataSource (Firestore)
        ↓
9. Real-time stream updates UI
```

---

## Testing Strategy

### Unit Tests
- Use Cases logic
- Repository implementations
- Encryption algorithms
- BLoC state transitions

### Widget Tests
- UI components rendering
- User interactions
- State updates

### Integration Tests
- Full feature flows
- Authentication
- Message sending/receiving
- Call establishment

### Test Commands
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/unit/encryption_test.dart
```

---

## Deployment

### Build Commands
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ipa --release

# Web
flutter build web --release
```

### Environment Configuration
- `firebase_options.dart` - Firebase config
- Environment variables for API keys
- Separate configs for dev/staging/prod

### Release Checklist
- [ ] Update version in `pubspec.yaml`
- [ ] Run `flutter analyze`
- [ ] Run all tests
- [ ] Build release variants
- [ ] Test on physical devices
- [ ] Update changelog
- [ ] Create git tag

---

## API Reference

### Core Services

| Service | Purpose |
|---------|---------|
| `EncryptionService` | Message encryption/decryption |
| `KeyExchangeManager` | Key pair management |
| `MessageQueueService` | Offline message queue |
| `MediaCompressionService` | Image/video optimization |
| `VoiceToTextService` | Speech recognition |

### BLoCs

| BLoC | Purpose |
|------|---------|
| `AuthBloc` | Authentication state |
| `ChatBloc` | Chat list management |
| `MessageBloc` | Message operations |
| `CallBloc` | Call state management |

---

## Support

For technical questions, refer to:
- Flutter documentation: https://flutter.dev/docs
- Firebase documentation: https://firebase.google.com/docs
- WebRTC documentation: https://webrtc.org

---

*Last updated: December 2024*
