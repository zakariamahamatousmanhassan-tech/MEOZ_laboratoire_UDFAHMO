import 'dart:convert';
import 'package:http/http.dart' as http;

/// Client du backend FastAPI (HTTPS + JWT).
class ApiService {
  /// À remplacer par l'adresse HTTPS de ton backend déployé.
  static String baseUrl = 'https://TON-BACKEND.exemple.com';

  /// Jeton JWT obtenu après authentification.
  static String token = '';

  static Future<Map<String, dynamic>> analyze(String endpoint, String imagePath) async {
    final req = http.MultipartRequest('POST', Uri.parse('$baseUrl/$endpoint/'));
    if (token.isNotEmpty) req.headers['Authorization'] = 'Bearer $token';
    req.files.add(await http.MultipartFile.fromPath('file', imagePath));
    final streamed = await req.send().timeout(const Duration(seconds: 60));
    final res = await http.Response.fromStream(streamed);
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}');
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
