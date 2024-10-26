import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagingService {
  final String baseUrl;

  MessagingService({required this.baseUrl});

  Future<void> sendMessage(String message, String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message, 'userId': userId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  Future<List<String>> getMessages(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/messages?userId=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> messages = jsonDecode(response.body);
      return messages.map((msg) => msg['message'] as String).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
