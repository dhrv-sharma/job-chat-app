import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chatting_service.dart';

class ChatPage extends StatelessWidget {
  final String chatRoomId;

  ChatPage({required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Room"),
      ),
      body: Column(
        children: [
          // Expanded widget to display the messages list
          Expanded(
            child: MessageList(chatRoomId: chatRoomId),
          ),
          // Send message field
          SendMessageWidget(chatRoomId: chatRoomId),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final String chatRoomId;
  final ChatService chatService = ChatService();

  MessageList({required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: chatService.getMessages(chatRoomId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No messages yet."));
        }

        final messages = snapshot.data!;

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isCurrentUser =
                message.senderId == chatService._auth.currentUser?.uid;

            return ChatBubble(
              message: message.message,
              isCurrentUser: isCurrentUser,
              timestamp: message.timestamp,
            );
          },
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp timestamp;

  ChatBubble({
    required this.message,
    required this.isCurrentUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    // Message bubble styling based on the sender
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isCurrentUser ? Colors.black : Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                _formatTimestamp(timestamp),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    final timeString = "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    return timeString;
  }
}

class SendMessageWidget extends StatefulWidget {
  final String chatRoomId;

  SendMessageWidget({required this.chatRoomId});

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController _controller = TextEditingController();
  final ChatService _chatService = ChatService();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _chatService.sendMessage(widget.chatRoomId, _controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Text field for input
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Send button
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
