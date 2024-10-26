import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({super.key});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        
        child: Text("Vendor home Page")
        
        ),
    );
  }
}