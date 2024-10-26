import 'package:flutter/material.dart';
import 'package:villachalo_admin/components/property-list.dart';
import 'package:villachalo_admin/pages/add-property-form.dart';

class ImageAddPage extends StatefulWidget {
  const ImageAddPage({super.key});

  @override
  State<ImageAddPage> createState() => _ImageAddPageState();
}

class _ImageAddPageState extends State<ImageAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Added Properties",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PropertyAddForm()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.2, 0.2),
                          color: Colors.white,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Add Property",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PropertyList(),
          )
        ],
      ),
    );
  }
}
