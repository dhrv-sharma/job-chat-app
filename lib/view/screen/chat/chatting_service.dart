import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// This function listens to chat messages in a chat room in real-time
  Stream<List<Message>> getMessages(String chatRoomId) {
    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Message.fromFirestore(doc);
      }).toList();
    });
  }

  /// This function sends a chat message to a specific chat room
  Future<void> sendMessage(String chatRoomId, String message) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not authenticated");
    }

    DocumentReference messageRef = _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'senderId': user.uid,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class Message {
  final String senderId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      senderId: data['senderId'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
