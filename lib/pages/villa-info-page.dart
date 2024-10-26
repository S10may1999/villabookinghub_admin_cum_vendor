import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villachalo_admin/components/chart-list.dart';
import 'package:villachalo_admin/components/loading-bar.dart';
import 'package:villachalo_admin/methods/upload-task-method.dart';
import 'package:villachalo_admin/pages/image-upload-page.dart';

class VillaInfo extends StatefulWidget {
  const VillaInfo({super.key});

  @override
  State<VillaInfo> createState() => _VillaInfoState();
}

class _VillaInfoState extends State<VillaInfo> {
  bool isPool = false;
  bool isGarden = false;
  bool isActivity = false;
  bool isAmenties = false;

  TextEditingController poolSize = TextEditingController();
  TextEditingController garden = TextEditingController();
  TextEditingController priceWithFoodWeekDays = TextEditingController();
  TextEditingController priceWithoutFoodWeekDays=TextEditingController();
  TextEditingController priceWithFoodWeekend=TextEditingController();
  TextEditingController priceWithoutFoodWeekend = TextEditingController();
  TextEditingController maxGuset = TextEditingController();
  TextEditingController extraChargePerPerson = TextEditingController();
  TextEditingController villaName = TextEditingController();


  bool _isPoolSizeValid = true;
  bool _isPriceWithFoodWeekend = true;
  bool _isPriceWithoutFoodWeekend = true;
  bool _isPriceWithFoodWeekDays = true;
  bool _isPriceWithoutFoodWeekDays = true;
  bool _isMaxGuuestValid=true;
  bool _isExtraChargesValid=true;
  void _checkIsNum(String input, String fieldName) {
    bool isValid = RegExp(r'^\d+$').hasMatch(input); 
      if (input.isEmpty) {
        isValid=true;
      }
      switch (fieldName) {
        case "pool":
          setState(() {
            _isPoolSizeValid = isValid;
          });
          break;
        case "priceWithFoodWeekDays":
          setState(() {
            _isPriceWithFoodWeekDays = isValid;
          });
          break;
        case "priceWithoutFoodWeekDays":
          setState(() {
            _isPriceWithoutFoodWeekDays = isValid;
          });
          break;
        case "priceWithFoodWeekend":
          setState(() {
            _isPriceWithFoodWeekend = isValid;
          });
          break;
        case "priceWithoutFoodWeekend":
          setState(() {
            _isPriceWithoutFoodWeekend = isValid;
          });
          break;
        case "maxGuest":
          setState(() {
            _isMaxGuuestValid=isValid;
          });
          break;
        case "extraPerson":
          setState(() {
            _isExtraChargesValid=isValid;
          });
          break;
      }
  }

  bool _isOwnerNameValid = true;
  void _checkValidOwnerName(String input) {
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(input)) {
      setState(() {
        _isOwnerNameValid = false;
      });
    }
    if (input.isEmpty) {
      setState(() {
        _isOwnerNameValid = true;
      });
    }
  }


  int _selectedChoiceIndex = -1; 
  int _selectedChoiceIndex2=-1; 
  List<String> _options = ["Cricket", "Table Tennis", "Badminton", "Basketball"];
  List<String> _amenties=["AC","Fridge","BathRoom","Furniture","TV"];
  
  void _handleChipSelection(int index) {
    setState(() {
      _selectedChoiceIndex = index; 
    });
    print("Selected Activity: ${_options[index]}");
  }

  Future<void> sharedData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    final id=sharedPreferences.getString("vendor_Id");
    print(id);
  }

  void _handleAmentySelection(int index){
    setState(() {
      _selectedChoiceIndex2=index;
    });
    print("selected Amenties: ${_amenties[index]}");
  }

  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 104, 220, 108),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        title: const Center(
            child: Text(
          "Villa Info",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        )),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: villaName,
                    onChanged: (value) => _checkValidOwnerName(value),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _isOwnerNameValid
                                    ? Colors.black
                                    : Colors.red)),
                        errorText: _isOwnerNameValid ? null : "Invalid name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Villa Name",
                        labelStyle: TextStyle(
                            color:
                                _isOwnerNameValid ? Colors.black : Colors.red),
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Swimming Pool ?"),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPool = true;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("Yes"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor:
                                            isPool ? Colors.black : Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPool = false;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("No"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor:
                                          !isPool ? Colors.black : Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: isPool ? 10 : 0,
                  ),
                  isPool
                      ? TextField(
                          controller: poolSize,
                          onChanged: (value) =>
                              _checkIsNum(value, "pool"),
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: _isPoolSizeValid
                                          ? Colors.black
                                          : Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusColor: Colors.pink[244],
                              labelText: "Swimming pool Size",
                              errorText:
                                  _isPoolSizeValid ? null : 'Invalid Size',
                              hoverColor: Colors.pink),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Garden ?"),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGarden = true;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("Yes"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: isGarden
                                            ? Colors.black
                                            : Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGarden = false;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("No"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: !isGarden
                                          ? Colors.black
                                          : Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Playing Activities ?"),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isActivity = true;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("Yes"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: isActivity
                                            ? Colors.black
                                            : Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isActivity = false;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("No"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: !isActivity
                                          ? Colors.black
                                          : Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  isActivity
                ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(_options.length, (int index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(_options[index]),
                            selected: _selectedChoiceIndex == index,
                            onSelected: (bool selected) {
                              _handleChipSelection(index);
                              sharedData(); 
                            },
                          ),
                        );
                      }).toList(),
                    ),
                )
                : SizedBox(height: 0),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amenties ?"),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAmenties = true;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("Yes"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: isAmenties
                                            ? Colors.black
                                            : Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAmenties = false;
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text("No"),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: !isAmenties
                                          ? Colors.black
                                          : Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  isAmenties
                      ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(_amenties.length, (int index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(_amenties[index]),
                            selected: _selectedChoiceIndex2 == index,
                            onSelected: (bool selected) {
                              _handleAmentySelection(index); 
                            },
                          ),
                        );
                      }).toList(),
                    ),
                )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: priceWithFoodWeekDays,
                    onChanged: (value) =>
                        _checkIsNum(value, "priceWithFoodWeekDays"),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: _isPriceWithFoodWeekDays?Colors.black:Colors.red
                        )
                      
                      ),
                        errorText: _isPriceWithFoodWeekDays?null:"Invalid Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Price With Food (WeekDays)",
                        hoverColor: Colors.pink),
                        
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: priceWithoutFoodWeekDays,
                    onChanged: (value) => _checkIsNum(value,"priceWithoutFoodWeekDays"),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: _isPriceWithoutFoodWeekDays?Colors.black:Colors.red)),
                        errorText: _isPriceWithoutFoodWeekDays?null:"Inavlid Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Price Without Food (Weekdays)",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: priceWithFoodWeekend,
                    onChanged: (value) => _checkIsNum(value, "priceWithFoodWeekend"),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: _isPriceWithFoodWeekend?Colors.black:Colors.red)
                        ),
                        errorText: _isPriceWithFoodWeekend?null:"Invalid Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Price With Food (WeekDays)",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: priceWithoutFoodWeekend,
                    onChanged: (value) => _checkIsNum(value, "priceWithoutFoodWeekend"),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: _isPriceWithoutFoodWeekend?Colors.black:Colors.red)
                      ),
                      errorText: _isPriceWithoutFoodWeekend?null:"Inavlid Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Price Without Food (Weekend)",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: maxGuset,
                    onChanged: (value) => _checkIsNum(value,"maxGuest"),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(20),
                        borderSide: BorderSide(color: _isMaxGuuestValid?Colors.black:Colors.red)
                         ),
                         errorText: _isMaxGuuestValid?null:"Invalid Guest",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Max Guest Allowed",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: extraChargePerPerson,
                    onChanged: (value) => _checkIsNum(value,"extraPerson"),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: _isExtraChargesValid?Colors.black:Colors.red)
                        ),
                        errorText: _isExtraChargesValid?null:"Invalid person",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Extra Charge Per Person",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: ()async {
                if (villaName.text.isEmpty ||
                    priceWithFoodWeekDays.text.isEmpty ||
                    priceWithoutFoodWeekDays.text.isEmpty ||
                    priceWithFoodWeekend.text.isEmpty ||
                    priceWithoutFoodWeekend.text.isEmpty
                    ) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                          content: Text("Please Enter all the fields !!", style: TextStyle(color: Colors.white),))
                      );
                  } 
                  else
                  {
                  setState(() {
                    _isLoading = true;
                  });
                  _isLoading ? ShowDialog.show(context, "Loading....") : null;
                  SharedPreferences preferences=await SharedPreferences.getInstance();
                  final vendorId=preferences.getString("vendor_Id");
                  String activity=_options[_selectedChoiceIndex].toString();
                  String amenity=_amenties[_selectedChoiceIndex2].toString();
                  await villaInfoUploader(
                    vendorId.toString(), 
                    villaName.text,
                     isPool,
                    poolSize.text, 
                    isGarden, 
                    isActivity, 
                    activity,
                    isAmenties, 
                    amenity, 
                    priceWithFoodWeekDays.text, 
                    priceWithoutFoodWeekDays.text, 
                    priceWithFoodWeekend.text, 
                    priceWithoutFoodWeekend.text, 
                    maxGuset.text, 
                    extraChargePerPerson.text);
                  setState(() {
                    _isLoading = false;
                  });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageUploaderPage()));
              }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .10,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            offset: Offset(4, 4),
                            spreadRadius: BorderSide.strokeAlignOutside,
                            blurRadius: BorderSide.strokeAlignOutside,
                            blurStyle: BlurStyle.normal)
                      ]),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
