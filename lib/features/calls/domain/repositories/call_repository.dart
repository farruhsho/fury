import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/call_entity.dart';

/// Repository interface for call operations
abstract class CallRepository {
  /// Initiate a new call
  Future<Either<Failure, CallEntity>> initiateCall({
    required String chatId,
    required String recipientId,
    required CallType type,
  });

  /// Answer an incoming call
  Future<Either<Failure, CallEntity>> answerCall({
    required String callId,
    required String answer,
  });

  /// Decline an incoming call
  Future<Either<Failure, void>> declineCall(String callId);

  /// End an active call
  Future<Either<Failure, void>> endCall({
    required String callId,
    CallEndReason reason,
  });

  /// Update call status
  Future<Either<Failure, void>> updateCallStatus({
    required String callId,
    required CallStatus status,
  });

  /// Send ICE candidate
  Future<Either<Failure, void>> sendIceCandidate({
    required String callId,
    required IceCandidateEntity candidate,
  });

  /// Listen to incoming calls
  Stream<CallEntity?> listenToIncomingCalls();

  /// Listen to call updates
  Stream<CallEntity?> listenToCallUpdates(String callId);

  /// Listen to ICE candidates
  Stream<List<IceCandidateEntity>> listenToIceCandidates(String callId);

  /// Get call history
  Future<Either<Failure, List<CallEntity>>> getCallHistory();

  /// Mark call as missed
  Future<Either<Failure, void>> markCallAsMissed(String callId);
}
