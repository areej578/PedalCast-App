import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://enamel-overhung-swell.ngrok-free.dev';

  static Future<int> getPrediction({
    required double temp,
    required double atemp,
    required double hum,
    required double windspeed,
    required int hr,
    required int mnth,
    required int season,
    required int weathersit,
    required int weekday,
    required int holiday,
    required int workingday,
    required int yr,
  }) async {
    final uri = Uri.parse('$baseUrl/predict');

    final body = jsonEncode({
      'temp': temp,
      'atemp': atemp,
      'hum': hum,
      'windspeed': windspeed,
      'hr': hr,
      'mnth': mnth,
      'season': season,
      'weathersit': weathersit,
      'weekday': weekday,
      'holiday': holiday,
      'workingday': workingday,
      'yr': yr,
    });

    final response = await http
        .post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
          body: body,
        )
        .timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['predicted_demand'] as int;
    } else {
      throw Exception(
        'Prediction failed (status ${response.statusCode}): ${response.body}',
      );
    }
  }
}