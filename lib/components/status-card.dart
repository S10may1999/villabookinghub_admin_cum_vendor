import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:villachalo_admin/pages/customer-details.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({super.key});

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              //Customer details section
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerDetails()));
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color:Colors.black.withOpacity(0.1),
                          offset: Offset(0,4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color:Colors.black.withOpacity(0.2),
                          offset: Offset(0,-4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ]
                    ),
                
                    child:const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        //Customer card monthly details
                        Row(
                        children: [
                          Icon(Icons.person_3_outlined, color: Colors.white,),
                          SizedBox(width: 5,),
                          Text("Customers", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Row(
                                children: [
                                Icon(Icons.calendar_today_outlined,size: 14,color: Colors.white,),
                               SizedBox(width: 5,), 
                              Text("Monthly", style: TextStyle(color: Colors.white),)]),
                              SizedBox(height: 5,),
                              Text("100", style: TextStyle(color: Colors.white),)
                
                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Row(
                                children: [
                                Icon(Icons.calendar_month_outlined,size: 14,color: Colors.white,),
                               SizedBox(width: 5,), 
                              Text("Yearly", style: TextStyle(color: Colors.white),)]),
                              SizedBox(height: 5,),
                              Text("5000", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ])
                
                      ],
                    ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.black.withOpacity(0.1),
                        offset: Offset(0,4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color:Colors.black.withOpacity(0.2),
                        offset: Offset(0,-4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  ),

                  child:const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Icon(Icons.villa_outlined),
                        SizedBox(width: 5,),
                        Text("Vendors", style: TextStyle(fontWeight: FontWeight.w700),)
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Row(
                              children: [
                              Icon(Icons.calendar_today_outlined,size: 14,),
                             SizedBox(width: 5,), 
                            Text("Monthly")]),
                            SizedBox(height: 5,),
                            Text("100")

                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Row(
                              children: [
                              Icon(Icons.calendar_month_outlined,size: 14,),
                             SizedBox(width: 5,), 
                            Text("Yearly")]),
                            SizedBox(height: 5,),
                            Text("5000")
                          ],
                        ),
                      ])
                    ],
                  ),
              )
            ],
          );
          
  }
}