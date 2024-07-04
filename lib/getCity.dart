import 'dart:convert';
import 'package:http/http.dart' as http;


Future<String> getCityName(double latitude, double longitude) async {
  final String apiUrl = 'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$latitude&longitude=$longitude&localityLanguage=id';
  print(apiUrl);
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    print(jsonMap['locality']);
    return jsonMap['locality'];
  } else {
    throw Exception('Failed to fetch city name');
  }
}