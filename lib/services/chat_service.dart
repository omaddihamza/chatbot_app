import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String _apiKey = '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'; // Remplace par ta clé
  static const String _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'HTTP-Referer': 'https://your-app.com', // facultatif
        },
        body: jsonEncode({
          "model": "openai/gpt-3.5-turbo", // tu peux changer par mistral/mistral-7b-instruct
          "messages": [
            {"role": "user", "content": message}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        return content.trim();
      } else {
        print('Erreur API : ${response.statusCode}');
        return 'Erreur IA (${response.statusCode})';
      }
    } catch (e) {
      print('Erreur de requête : $e');
      return 'Erreur de connexion.';
    }
  }
}
