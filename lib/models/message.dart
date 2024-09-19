import 'package:cloud_firestore/cloud_firestore.dart';

class message {
  final String senderId;
  final String senderProfile;
  final String senderUsername;
  final String recieverUsername;

  final String recieverId;
  final String recieverProfile;
  final String msg;
  final Timestamp timestamp;

  message({
    required this.senderId,
    required this.senderProfile,
    required this.recieverId,
    required this.recieverProfile,
    required this.senderUsername,
    required this.recieverUsername,
    required this.msg,
    required this.timestamp,
  });

  // convert to map

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderProfile': senderProfile,
      'senderUsername': senderUsername,
      'recieverId': recieverId,
      'recieverProfile': recieverProfile,
      'recieverUsername': recieverUsername,
      'msg': msg,
      'timestamp': timestamp,
    };
  }

  factory message.fromFirestore(Map<String, dynamic> data) {
    return message(
      senderId: data['senderId'] as String,
      senderProfile: data['senderProfile'] as String,
      senderUsername: data['senderUsername'] as String,
      recieverId: data['recieverId'] as String,
      recieverProfile: data['recieverProfile'] as String,
      recieverUsername: data['recieverUsername'] as String,
      msg: data['msg'] as String,
      timestamp: data['timestamp'] as Timestamp,
    );
  }
}
