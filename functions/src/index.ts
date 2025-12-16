import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

// ============================================
// 1. NEW MESSAGE PUSH NOTIFICATION
// ============================================

export const onNewMessage = functions.firestore
    .document('chats/{chatId}/messages/{messageId}')
    .onCreate(async (snap, context) => {
        const message = snap.data();
        const chatId = context.params.chatId;
        const messageId = context.params.messageId;

        try {
            // Get chat document to find participants
            const chatDoc = await db.collection('chats').doc(chatId).get();
            const chat = chatDoc.data();

            if (!chat) {
                console.log('Chat not found:', chatId);
                return;
            }

            // Get sender info
            const senderDoc = await db.collection('users').doc(message.senderId).get();
            const sender = senderDoc.data();
            const senderName = sender?.displayName || sender?.username || 'Someone';
            const senderAvatar = sender?.avatarUrl || '';

            // Determine message preview based on type
            let preview = message.text || '';
            let badge = '';

            switch (message.type) {
                case 'image':
                    preview = '📸 Photo';
                    badge = 'photo';
                    break;
                case 'video':
                    preview = '🎥 Video';
                    badge = 'video';
                    break;
                case 'audio':
                case 'voice':
                    preview = '🎧 Audio message';
                    badge = 'audio';
                    break;
                case 'document':
                    preview = '📄 Document';
                    badge = 'document';
                    break;
                case 'location':
                    preview = '📍 Location';
                    badge = 'location';
                    break;
                case 'contact':
                    preview = '👤 Contact';
                    badge = 'contact';
                    break;
                case 'sticker':
                    preview = '🏷️ Sticker';
                    badge = 'sticker';
                    break;
                default:
                    // Truncate long text
                    if (preview.length > 100) {
                        preview = preview.substring(0, 100) + '...';
                    }
            }

            // Get all participants except sender
            const recipientIds = (chat.participantIds || []).filter(
                (id: string) => id !== message.senderId
            );

            // Send notification to each recipient
            for (const recipientId of recipientIds) {
                const recipientDoc = await db.collection('users').doc(recipientId).get();
                const recipient = recipientDoc.data();

                if (!recipient?.fcmToken) {
                    console.log('No FCM token for user:', recipientId);
                    continue;
                }

                // Check if user has muted this chat
                if (recipient.mutedChats?.includes(chatId)) {
                    console.log('Chat muted by user:', recipientId);
                    continue;
                }

                try {
                    await messaging.send({
                        token: recipient.fcmToken,
                        notification: {
                            title: senderName,
                            body: preview,
                        },
                        data: {
                            type: 'message',
                            chatId: chatId,
                            messageId: messageId,
                            senderId: message.senderId,
                            senderName: senderName,
                            senderAvatar: senderAvatar,
                            messageType: message.type || 'text',
                            badge: badge,
                            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        android: {
                            priority: 'high',
                            notification: {
                                channelId: 'messages_channel',
                                icon: '@mipmap/ic_notification',
                                color: '#6C5CE7',
                                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                            },
                        },
                        apns: {
                            headers: {
                                'apns-priority': '10',
                            },
                            payload: {
                                aps: {
                                    badge: 1,
                                    sound: 'default',
                                    category: 'MESSAGE',
                                },
                            },
                        },
                    });

                    console.log('Notification sent to:', recipientId);
                } catch (sendError) {
                    console.error('Error sending notification to', recipientId, sendError);

                    // If token is invalid, remove it
                    if ((sendError as any).code === 'messaging/registration-token-not-registered') {
                        await db.collection('users').doc(recipientId).update({
                            fcmToken: admin.firestore.FieldValue.delete(),
                        });
                    }
                }
            }

            // Update message status to 'sent'
            await snap.ref.update({
                status: 'sent',
            });

        } catch (error) {
            console.error('Error in onNewMessage:', error);
        }
    });

// ============================================
// 2. INCOMING CALL PUSH NOTIFICATION
// ============================================

export const onIncomingCall = functions.firestore
    .document('calls/{callId}')
    .onCreate(async (snap, context) => {
        const call = snap.data();
        const callId = context.params.callId;

        try {
            // Get caller info
            const callerDoc = await db.collection('users').doc(call.callerId).get();
            const caller = callerDoc.data();
            const callerName = caller?.displayName || caller?.username || 'Unknown';
            const callerAvatar = caller?.avatarUrl || '';

            // Get all participants except caller
            const recipientIds = (call.participantIds || []).filter(
                (id: string) => id !== call.callerId
            );

            for (const recipientId of recipientIds) {
                const recipientDoc = await db.collection('users').doc(recipientId).get();
                const recipient = recipientDoc.data();

                if (!recipient?.fcmToken) {
                    console.log('No FCM token for user:', recipientId);
                    continue;
                }

                // Check if user is already in a call
                if (recipient.inCall) {
                    console.log('User is already in a call:', recipientId);
                    // Update call status to busy
                    await snap.ref.update({
                        status: 'busy',
                    });
                    continue;
                }

                try {
                    // Send high-priority data message for call
                    // We generate the notification locally on the client to support full-screen intents
                    await messaging.send({
                        token: recipient.fcmToken,
                        data: {
                            type: 'call',
                            callId: callId,
                            callerId: call.callerId,
                            callerName: callerName,
                            callerAvatar: callerAvatar,
                            isVideo: call.isVideo ? 'true' : 'false',
                            timestamp: Date.now().toString(),
                        },
                        android: {
                            priority: 'high',
                            ttl: 0, // Deliver immediately or drop
                        },
                        apns: {
                            headers: {
                                'apns-priority': '10',
                                'apns-push-type': 'voip',
                            },
                            payload: {
                                aps: {
                                    contentAvailable: true,
                                },
                            },
                        },
                    });

                    console.log('Call notification sent to:', recipientId);
                } catch (sendError) {
                    console.error('Error sending call notification:', sendError);
                }
            }
        } catch (error) {
            console.error('Error in onIncomingCall:', error);
        }
    });

// ============================================
// 3. MISSED CALL NOTIFICATION
// ============================================

export const onCallEnded = functions.firestore
    .document('calls/{callId}')
    .onUpdate(async (change, context) => {
        const before = change.before.data();
        const after = change.after.data();
        const callId = context.params.callId;

        // Check if call status changed to 'missed' or 'ended' without being answered
        if (before.status === 'ringing' &&
            (after.status === 'missed' || after.status === 'ended')) {

            // This was a missed call
            const callerDoc = await db.collection('users').doc(after.callerId).get();
            const caller = callerDoc.data();
            const callerName = caller?.displayName || 'Unknown';

            // Get recipients who missed the call
            const recipientIds = (after.participantIds || []).filter(
                (id: string) => id !== after.callerId
            );

            for (const recipientId of recipientIds) {
                const recipientDoc = await db.collection('users').doc(recipientId).get();
                const recipient = recipientDoc.data();

                if (!recipient?.fcmToken) continue;

                try {
                    await messaging.send({
                        token: recipient.fcmToken,
                        notification: {
                            title: 'Missed Call',
                            body: `You missed a ${after.isVideo ? 'video' : 'voice'} call from ${callerName}`,
                        },
                        data: {
                            type: 'missed_call',
                            callId: callId,
                            callerId: after.callerId,
                            callerName: callerName,
                            isVideo: after.isVideo ? 'true' : 'false',
                        },
                        android: {
                            priority: 'high',
                            notification: {
                                channelId: 'calls_channel',
                                icon: '@mipmap/ic_notification',
                                color: '#E74C3C',
                            },
                        },
                        apns: {
                            payload: {
                                aps: {
                                    badge: 1,
                                    sound: 'default',
                                },
                            },
                        },
                    });

                    console.log('Missed call notification sent to:', recipientId);
                } catch (sendError) {
                    console.error('Error sending missed call notification:', sendError);
                }
            }

            // Create missed call record in chat
            // Find or create private chat between caller and recipient
            for (const recipientId of recipientIds) {
                const chatQuery = await db.collection('chats')
                    .where('participantIds', 'array-contains', after.callerId)
                    .where('type', '==', 'private')
                    .get();

                let chatId: string | null = null;

                for (const doc of chatQuery.docs) {
                    if (doc.data().participantIds.includes(recipientId)) {
                        chatId = doc.id;
                        break;
                    }
                }

                if (chatId) {
                    // Add missed call message to chat
                    await db.collection('chats').doc(chatId).collection('messages').add({
                        type: 'system',
                        text: `Missed ${after.isVideo ? 'video' : 'voice'} call`,
                        senderId: after.callerId,
                        chatId: chatId,
                        status: 'sent',
                        createdAt: admin.firestore.FieldValue.serverTimestamp(),
                        callInfo: {
                            callId: callId,
                            type: after.isVideo ? 'video' : 'voice',
                            status: 'missed',
                        },
                    });
                }
            }
        }
    });

// ============================================
// 4. MESSAGE DELIVERY STATUS UPDATE
// ============================================

export const onMessageRead = functions.firestore
    .document('chats/{chatId}/messages/{messageId}')
    .onUpdate(async (change, context) => {
        const before = change.before.data();
        const after = change.after.data();

        // Check if readBy map changed
        const beforeReadBy = Object.keys(before.readBy || {});
        const afterReadBy = Object.keys(after.readBy || {});

        if (afterReadBy.length > beforeReadBy.length) {
            // Someone new read the message
            // Update status to 'read' if all participants have read it
            const chatDoc = await db.collection('chats').doc(context.params.chatId).get();
            const chat = chatDoc.data();

            if (chat) {
                const allParticipantsRead = chat.participantIds
                    .filter((id: string) => id !== after.senderId)
                    .every((id: string) => afterReadBy.includes(id));

                if (allParticipantsRead && after.status !== 'read') {
                    await change.after.ref.update({
                        status: 'read',
                    });
                }
            }
        }
    });

// ============================================
// 5. USER PRESENCE UPDATE
// ============================================

export const onUserStatusChange = functions.database
    .ref('/status/{userId}')
    .onUpdate(async (change, context) => {
        const status = change.after.val();
        const userId = context.params.userId;

        // Update Firestore with presence info
        await db.collection('users').doc(userId).update({
            isOnline: status.online,
            lastSeen: admin.firestore.FieldValue.serverTimestamp(),
        });
    });

// ============================================
// 6. CLEANUP OLD CALLS
// ============================================

export const cleanupOldCalls = functions.pubsub
    .schedule('every 1 hours')
    .onRun(async () => {
        const oneHourAgo = admin.firestore.Timestamp.fromDate(
            new Date(Date.now() - 60 * 60 * 1000)
        );

        // Find calls that are still 'ringing' for more than 1 minute
        const oldRingingCalls = await db.collection('calls')
            .where('status', '==', 'ringing')
            .where('createdAt', '<', oneHourAgo)
            .get();

        const batch = db.batch();

        oldRingingCalls.forEach((doc) => {
            batch.update(doc.ref, {
                status: 'missed',
                endedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
        });

        await batch.commit();
        console.log(`Cleaned up ${oldRingingCalls.size} old calls`);
    });

console.log('Firebase Cloud Functions initialized');
