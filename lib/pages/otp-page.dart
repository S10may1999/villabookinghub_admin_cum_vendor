import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villachalo_admin/components/loading-bar.dart';
import 'package:villachalo_admin/pages/home-page.dart';
import 'package:villachalo_admin/pages/vendor/pages/bottom-top-bar.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-home-page.dart';

class OTPPage extends StatefulWidget {
  String mobileNumber;
  OTPPage({super.key, required this.mobileNumber});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    _isLoading? ShowDialog.show(context, "Verifying.."):null;

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? otp = preferences.getString("otp");
      bool? isAdmin = preferences.getBool("isAdmin");
      print("isAdmin value : ${isAdmin.toString()}");
      print("Stored OTP: $otp, Entered OTP: ${otpController.text}");

      if (otp == otpController.text) {
        preferences.setBool("isVerified", true);
        preferences.remove("otp");

        if (isAdmin == true) {
          print("Navigating to Home.");
          setState(() {
            _isLoading=false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          print("Navigating to BottomTopBar.");
          setState(() {
            _isLoading=false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomTopBar()));
        }
      } else {
        setState(() {
          _isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid OTP!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred during verification.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter OTP",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "Enter the four digit OTP sent on",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "mobile number",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.mobileNumber,
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: otpController,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                    labelText: "Enter OTP",
                    labelStyle: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                _verifyOtp();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .87,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Center(child: Text("verify")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
