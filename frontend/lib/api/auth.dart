import 'package:dio/dio.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/models/token.dart';
import 'package:frontend/config.dart';

class Auth {
  final dio = Dio();

  Future<Token> getToken(String username, String password) async {
    try {
      final response = await dio.post("${AppConfig.apiUrl}/login",
          data: {
            "username": username,
            "password": password,
          },
          options: Options(validateStatus: (_) => true));

      return Token(token: response.data["token"]);
    } catch (error) {
      // Manejo de errores
      rethrow; // Puedes lanzar el error para manejarlo más arriba si es necesario
    }
  }

  Future<Profile> getProfile(String token) async {
    try {
      final response = await dio.get("${AppConfig.apiUrl}/profile",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      print(response.data);
      return Profile.fromJson(response.data);
    } catch (error) {
      // Manejo de errores
      print('Error al obtener el perfil: $error');
      rethrow; // Puedes lanzar el error para manejarlo más arriba si es necesario
    }
  }
}
