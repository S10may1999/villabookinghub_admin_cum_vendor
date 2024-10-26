import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villachalo_admin/pages/common-login-page.dart';
import 'package:villachalo_admin/pages/home-page.dart';
import 'package:villachalo_admin/pages/vendor/pages/bottom-top-bar.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-home-page.dart';

class CheckAndRender extends StatelessWidget {
  const CheckAndRender({super.key});

  Future<Widget> _getInitialPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isAdmin = preferences.getBool("isAdmin");
    bool? isVerified = preferences.getBool("isVerified");

    if (isVerified == true) {
      if (isAdmin == true) {
        return Home(); // Render admin page
      } else {
        return BottomTopBar(); // Render vendor page
      }
    } else {
      return LoginPage(); // Send to login page
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialPage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Handle errors
          return Scaffold(
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else {
          // Return the appropriate page based on preferences
          return snapshot.data!;
        }
      },
    );
  }}