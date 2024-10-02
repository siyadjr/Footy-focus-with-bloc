import 'package:http/http.dart' as http;

class AuthRepository {
  Future<void> authenticate({
    required String username,
    required String password,
  }) async {
    Uri url = Uri.parse('https://fakestoreapi.com/auth/login');

    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    switch (response.statusCode) {
      case 200:
        return;
      case 400:
        throw Exception('Bad request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Failed to authenticate');
    }
  }
}