import 'package:flutter/material.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed:(){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios, size: 18,),
          ),
        title: Center(child: Text("Customer Details", style: TextStyle(fontSize: 18),),),
      ),
      body: Center(
        child:Text(
          "Customer Details"
        ),
      ),
    );
  }
}