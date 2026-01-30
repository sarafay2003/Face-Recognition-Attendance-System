import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.18.130:8000";

  static Future<bool> registerFace(
      Uint8List imageBytes, String name) async {
    try {
      var request =
      http.MultipartRequest("POST", Uri.parse("$baseUrl/register"));

      request.fields["name"] = name;

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageBytes,
          filename: "face.jpg",
        ),
      );

      var response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> markAttendance(Uint8List imageBytes) async {
    try {
      var request =
      http.MultipartRequest("POST", Uri.parse("$baseUrl/attendance"));

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageBytes,
          filename: "attendance.jpg",
        ),
      );

      var response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
