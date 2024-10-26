import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String userId;
  final String username;

  ChatScreen({required this.userId, required this.username});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  List<Map<String, String>> messages = []; // Store messages as a list of maps
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Connect to the socket
    socket = IO.io('https://tripolo-backend.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // Listen for incoming messages
    socket.on('receiveMessage', (data) {
      setState(() {
        // Add the received message to the list
        messages.add({
          'sender': data['senderName'],
          'message': data['message'],
        });
      });
    });
  }

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      socket.emit('sendMessage', {
        'userId': widget.userId,
        'message': _controller.text,
        'senderName': widget.username,
      });
      // Add the sent message to the list for local display
      setState(() {
        messages.add({
          'sender': widget.username,
          'message': _controller.text,
        });
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), 
        icon: Icon(Icons.arrow_back_ios_new_outlined, size: 18,)),
        title: Center(child: Text(widget.username, style: TextStyle(fontSize: 18))),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]['sender']!), // Display sender's name
                  subtitle: Text(messages[index]['message']!), // Display the message
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                      ),

                      ),
                  ),
                ),
                GestureDetector(
                  onTap: () => sendMessage(),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 1),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.send_outlined,color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
