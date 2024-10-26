import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-customer-chat-page.dart';

class VendorChatPage extends StatefulWidget {
  const VendorChatPage({super.key});

  @override
  State<VendorChatPage> createState() => _VendorChatPageState();
}

class _VendorChatPageState extends State<VendorChatPage> {
  List<Map<String,String>> map=[{"name":"sandeep sharma","message":"how are you !!","userID":"1234565"},
                                {"name":"pradeep sharma","message":"what's the price !!","userID":"1234563"},
                                {"name":"Prem sharma","message":"confirm my booking !!","userID":"1234562"}
                                ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: map.length,
          itemBuilder: (context,index){
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                  username: map[index]["name"]??"unKonwn User",userId: map[index]["userID"]!??"no user id", )));
              },
              leading: CircleAvatar(),
              title: Text(map[index]["name"]!),
              subtitle: Text(map[index]["message"]!),
              trailing: Text("3.30 pm" ),
            );
          }),
      ),
    );
  }
}