import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:villachalo_admin/components/loading-bar.dart';
import 'package:villachalo_admin/methods/login-check-method.dart';
import 'package:villachalo_admin/pages/otp-page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumber=TextEditingController();
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Chat With Your Customers !" ,style:TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800) ,)
            ,SizedBox(height: 20,),
            Center(
              child: Column(
                children: [
                  Text("Enter the number you have given while", style: TextStyle(color: Colors.grey),),
                  Text("registering with us.", style: TextStyle(color: Colors.grey),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: mobileNumber,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  labelText:"Phone Number",
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
                ),
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: () async{
                setState(() {
                  _isLoading=true;
                });
                _isLoading?ShowDialog.show(context, "Sending OTP.."):null;
                bool isOtpReceived=await isLoggined(mobileNumber.text);
                print(isOtpReceived);
                if(isOtpReceived){
                 setState(() {
                   _isLoading=false;
                 });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPPage(mobileNumber: mobileNumber.text,)));
                }else{
                  setState(() {
                    _isLoading=false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mobile Number Not Found !!"),backgroundColor: Colors.green,));
                }
                
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.87,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green
                ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child: Center(child: Text("Get OTP")),
              ),
            ),
          ],
        ),
      )
    );
  }
}