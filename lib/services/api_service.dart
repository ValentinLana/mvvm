import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://dummyjson.com';

  Future<Response> post(String endpoint, Map<String, String> body) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl$endpoint'), body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Response(data: data, isSuccess: true);
      } else {
        return Response(
            data: null,
            isSuccess: false,
            errorMessage: 'Error en la solicitud.');
      }
    } catch (e) {
      return Response(
          data: null, isSuccess: false, errorMessage: 'Error en la solicitud.');
    }
  }

  Future<Response> get(String endpoint, Map<String, String> body) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Response(data: data, isSuccess: true);
      } else {
        return Response(
            data: null,
            isSuccess: false,
            errorMessage: 'Error en la solicitud.');
      }
    } catch (e) {
      return Response(
          data: null, isSuccess: false, errorMessage: 'Error en la solicitud.');
    }
  }
}

class Response {
  final dynamic data;
  final bool isSuccess;
  final String errorMessage;

  Response(
      {required this.data, required this.isSuccess, this.errorMessage = ''});
}
