import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailOTP {
  EmailOTP();

  Future<String> sendOtp(email) async {
    Uri requestUrl = Uri.parse(
        'https://evolvingmillennials.com/mail-verification/mailer.php?email=$email');
    final response = await http.get(requestUrl);
    var responseJson = json.decode(response.body);
    return responseJson["id"];
  }

  Future<String> verifyOtp(id, userOtp) async {
    Uri requestUrl = Uri.parse(
        'https://evolvingmillennials.com/mail-verification/verify-otp.php?id=$id&otp=$userOtp');
    final response = await http.get(requestUrl);
    var responseJson = json.decode(response.body);
    return responseJson["status"];
  }
}
