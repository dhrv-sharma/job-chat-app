import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobchat/models/agents.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/models/chatttedPeople.dart';
import 'package:jobchat/models/message.dart';

class chatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // to find the weather they have a talk or not before
  Future<chatPeople?> getBubble(ProfileRes prof) async {
    Set<String> uniqueIds = {};

    // Use a Completer to signal when the snapshots stream processing is complete
    Completer<void> completer = Completer<void>();

    // Subscribe to the snapshots stream
    StreamSubscription subscription = _firestore
        .collection("chat_bubble")
        .doc(prof.id)
        .collection("secondperson")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          uniqueIds.add(doc.data()["id"]);
        }
      }

      completer
          .complete(); // Signal completion after processing the first snapshot
    });

    // Wait for the stream processing to complete
    await completer.future;

    // Cancel the subscription to stop listening to further snapshots
    await subscription.cancel();

    // getting the list
    List<message> msgs = [];
    int index = 0;

    Completer<void> completer3 = Completer<void>();

    uniqueIds.forEach((element) async {
      List<String> ids = [prof.id, element];
      ids.sort();
      String chatRoomId = ids.join('_');
      Completer<void> completer2 = Completer<void>();

      StreamSubscription subscription2 = FirebaseFirestore.instance
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy("timestamp", descending: true)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var latest = message.fromFirestore(snapshot.docs.first.data());

          // Do something with the latest message
          // For example, print it
          print(latest.msg);
          msgs.add(latest);

          // Optionally, you can cancel the subscription after getting the latest message
          completer2.complete();
        }
      });

      await completer2.future;

      // Cancel the subscription to stop listening to further snapshots
      await subscription2.cancel();
      print("hello");
      if (index == uniqueIds.length - 1) {
        completer3.complete();
      }
      index++;
    });

    // Print the unique elements
    await completer3.future;

    print(msgs.length);
    chatPeople chatPerson = chatPeople(uniqueIds, msgs);
    return chatPerson;
  }

// applying job
  Future<bool> applyJob(ProfileRes prof, Agents agent) async {
    Timestamp timestamp = Timestamp.now();

    // aotuonomus message
    message sendMsgUser = message(
        senderId: prof.id,
        senderProfile: prof.profile,
        senderUsername: prof.username,
        recieverId: agent.uid,
        recieverProfile: agent.profile,
        recieverUsername: agent.username,
        msg: "Hey I Am Interested for this Job",
        timestamp: timestamp);

    // create a chat room
    List<String> ids = [sendMsgUser.senderId, sendMsgUser.recieverId];
    ids.sort();

    String chatRoomId = ids.join('_');

    // storing the data on the data base
    // autogenerated message from candidate - > auto generated messaage from agent - > saving detail for candidate that he had talk - > saving detail from candidate that he had talk
    try {
      // Add user's message
      await FirebaseFirestore.instance
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(sendMsgUser.toMap());

      // Add agent's message
      timestamp = Timestamp.now();
      DateTime dateTime = timestamp.toDate();

      // Add two seconds
      DateTime newDateTime = dateTime.add(const Duration(seconds: 2));

      // Convert back to Timestamp if needed
      timestamp = Timestamp.fromDate(newDateTime);
      message sendMsgAgent = message(
        senderId: agent.uid,
        senderProfile: agent.profile,
        senderUsername: agent.username,
        recieverId: prof.id,
        recieverProfile: prof.profile,
        recieverUsername: prof.username,
        msg: "Thank you For Applying We will catch you in minute",
        timestamp: timestamp,
      );

      await FirebaseFirestore.instance
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(sendMsgAgent.toMap());

      // Add references in chat_bubble collections
      await FirebaseFirestore.instance
          .collection("chat_bubble")
          .doc(prof.id)
          .collection("secondperson")
          .add({"id": agent.uid});

      await FirebaseFirestore.instance
          .collection("chat_bubble")
          .doc(agent.uid)
          .collection("secondperson")
          .add({"id": prof.id});
    } catch (e) {}

    return false;
  }

// send message
  Future<void> sendMessage(ProfileRes prof, Agents agent, String msg) async {
    final Timestamp timestamp = Timestamp.now();

    message sendMsg = message(
        senderId: prof.id,
        senderProfile: prof.profile,
        senderUsername: prof.username,
        recieverId: agent.uid,
        recieverProfile: agent.profile,
        recieverUsername: agent.username,
        msg: msg,
        timestamp: timestamp);

    // create a chat room
    List<String> ids = [sendMsg.senderId, sendMsg.recieverId];
    ids.sort();

    String chatRoomId = ids.join('_');

    // storing the data on the data base

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(sendMsg.toMap());
  }

// get message
  Stream<QuerySnapshot> getMessages(ProfileRes prof, Agents agent) {
    List<String> ids = [prof.uid, agent.uid];
    ids.sort();

    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}