import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggined(String mobile) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final vendorUrl = Uri.parse("https://tripolo-backend.onrender.com/api/vendor/vendor-login?mobileNumber=$mobile");

  try {
    final response = await http.post(vendorUrl);
    
    if (response.statusCode == 404) {
      // Vendor login failed, try admin login
      final adminUrl = Uri.parse("https://tripolo-backend.onrender.com/api/admin/admin-login?mobileNumber=$mobile");
      final adminRes = await http.post(adminUrl);

      if (adminRes.statusCode == 404) {
        print("Login failed: User not found.");
        return false;
      }
      
      if (adminRes.statusCode == 200) {
        print("admin part is executing !! : ${adminRes.body.toString()}");
        final decoded = jsonDecode(adminRes.body);
        preferences.setBool("isAdmin", true);
        preferences.setString("otp", decoded['otp'].toString());
        print("Admin login successful. OTP: ${decoded['otp']}");
        
        return true;
      } else {
        print('Admin login failed: Unexpected status code ${adminRes.statusCode}');
        return false;
      }
    }

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final token = jsonData['token'];
      final otp = jsonData['otp'];

      if (token == null || otp == null) {
        print('Error: Token or OTP missing in vendor login response');
        return false;
      }

      preferences.setString("jwtToken", token);
      preferences.setString("otp", otp.toString());
      preferences.setBool("isVerified", false);
      print("Vendor login successful. Token: $token, OTP: $otp");

      return true;
    } else {
      print('Vendor login failed: Unexpected status code ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error during login process: $e');
    return false;
  }
}
