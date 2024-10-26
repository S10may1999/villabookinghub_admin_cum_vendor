import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villachalo_admin/main.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-chat-page.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-home-page.dart';
import 'package:villachalo_admin/pages/vendor/pages/vendor-profile-page.dart';

class BottomTopBar extends StatefulWidget {
  const BottomTopBar({super.key});

  @override
  State<BottomTopBar> createState() => _BottomTopBarState();
}

class _BottomTopBarState extends State<BottomTopBar> {
  int selectedItem=0;
  
  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[VendorHomePage(),VendorChatPage(),VendorProfilePage()];
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                margin:const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                    style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow:const [BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.5, 0.5),
                      blurRadius: BorderSide.strokeAlignOutside,
                      blurStyle: BlurStyle.solid
                    ),]
                ),
                child:const Icon(Icons.menu,color: Colors.white,),
                ),
            );
          }
        ),
       backgroundColor: const Color.fromARGB(255, 104, 220, 108),
       title:const Center(child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Icon(Icons.villa,color: Colors.white,),
            SizedBox(width: 2,),
            Text("villachalo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                 ],
       ) ),
       actions: <Widget>[
        Icon(Icons.more_vert_outlined)
       ], 
       elevation: BorderSide.strokeAlignOutside,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 104, 220, 108),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: selectedItem,
        onTap: (index) {
          setState(() {
            selectedItem=index;
          });
        },
        items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.message_outlined),label: "chats"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: "Profile"),
        
      ],     
      ),

      drawerEnableOpenDragGesture: false,
      drawer:Drawer(
  backgroundColor: Colors.green,
  surfaceTintColor: Colors.white,
  width: MediaQuery.of(context).size.width * 0.70,
  child: Stack(
    children: [
      Container(
        width: double.infinity,
        child: DrawerHeader(
          child: Text(
            "Villachalo",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          decoration: BoxDecoration(color: Colors.green),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () async{
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setBool("isAdmin", false);
              preferences.setBool("isVerified",false);
              runApp(VillaChaloAdmin());
            },
            child: Container(
              height: MediaQuery.of(context).size.height*.10,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(.2, .2),
                    blurRadius: BorderSide.strokeAlignOutside,
                    spreadRadius: BorderSide.strokeAlignOutside,
                    color: Colors.white
                    )]
              ),
              width: double.infinity,
              child: Center(child: Text("Log out", style: TextStyle(color: Colors.white),)),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
    ],
  ),
),
    body: pages[selectedItem],
      
    );
  }
}