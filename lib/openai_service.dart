import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String _apiKey = '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';
  static const String _url = 'https://openrouter.ai/api/v1/chat/completions';

  static Future<String> getChatResponse(String userMessage) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'openai/gpt-4o-mini',
        'messages': [
          {'role': 'user', 'content': userMessage}
        ],
        'temperature': 0.8
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      print('Error de OpenAI: ${response.body}');
      return 'Lo siento, algo salió mal 😥';
    }
  }
}
