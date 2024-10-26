import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:villachalo_admin/pages/common-login-page.dart';
import 'package:villachalo_admin/pages/home-page.dart';
import 'package:villachalo_admin/pages/image-add-page.dart';
import 'package:villachalo_admin/pages/main-page.dart';
import 'package:villachalo_admin/pages/vendor/pages/bottom-top-bar.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-home-page.dart';
import 'package:villachalo_admin/utility/check-and-render.dart';

void main()async {
  runApp(const VillaChaloAdmin());
}


class VillaChaloAdmin extends StatelessWidget {
  const VillaChaloAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(76, 175, 80, 1),
      scaffoldBackgroundColor: Colors.white,
    ),
    home:CheckAndRender()
    );
  }
}