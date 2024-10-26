import 'package:flutter/material.dart';
import 'package:villachalo_admin/methods/get-task-method.dart';
import 'package:villachalo_admin/models/json-to-object.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  late Future<List<Property>> properties;

  @override
  void initState() {
    super.initState();
    properties = getAllProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Property>>(
        future: properties,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Property>? propertyData = snapshot.data;

            if (propertyData != null && propertyData.isNotEmpty) {
              return ListView.builder(
                itemCount: propertyData.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0,0.1),
                          blurRadius:1,
                          spreadRadius: BorderSide.strokeAlignOutside
                        )
                      ]
                    ),
                    child: ListTile(
                      leading: CircleAvatar(),
                      title: Text(propertyData[index].propertyName),
                      subtitle: Text(propertyData[index].priceWithFoodWeekdays),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min, 
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit_outlined),
                            onPressed: () {
                             
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No Property Added"));
            }
          } else {
            return Center(child: Text("No Property Added"));
          }
        },
      ),
    );
  }
}
