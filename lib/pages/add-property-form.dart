import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:villachalo_admin/components/loading-bar.dart';
import 'package:villachalo_admin/methods/upload-task-method.dart';
import 'package:villachalo_admin/pages/villa-info-page.dart';

class PropertyAddForm extends StatefulWidget {
  const PropertyAddForm({super.key});

  @override
  State<PropertyAddForm> createState() => _PropertyAddFormState();
}

class _PropertyAddFormState extends State<PropertyAddForm> {
  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController careTakerNumber = TextEditingController();
  TextEditingController careTakerName = TextEditingController();

  bool _isLoading = false;

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

  bool _isOwnerMobileNumberValid = true;
  void _checkOwnerMobileNumberValid(String input) {
    if (input.isEmpty) {
      setState(() {
        _isOwnerMobileNumberValid = true;
      });
    }

    if (RegExp(r'[\D \{ \} *  + - / - _ \[ \] \( \)]').hasMatch(input)) {
      setState(() {
        _isOwnerMobileNumberValid = false;
      });
    }

    if (input.length > 10) {
      setState(() {
        _isOwnerMobileNumberValid = false;
      });
    }
  }

  bool _isAddressValid = true;
  void _checkAddressValid(String input) {
    if (!RegExp(r"^[a-zA-Z0-9\s,'#\.-]+$").hasMatch(input)) {
      setState(() {
        _isAddressValid = false;
      });
    }

    if (input.isEmpty) {
      setState(() {
        _isAddressValid = true;
      });
    }
  }

  bool _isCareTakerNameValid = true;

  void _checkIsCAreTakerNameValid(String input) {
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(input)) {
      setState(() {
        _isCareTakerNameValid = false;
      });
    }

    if (input.isEmpty) {
      setState(() {
        _isCareTakerNameValid = true;
      });
    }
  }

  bool _isCareTakerMobileNumberValid = true;

  void _checkCareTakerMobileNumberValid(String input) {
    if (input.isEmpty) {
      setState(() {
        _isCareTakerMobileNumberValid = true;
      });
    }

    if (RegExp(r'[\D \{ \} *  + - / - _ \[ \] \( \)]').hasMatch(input)) {
      setState(() {
        _isCareTakerMobileNumberValid = false;
      });
    }

    if (input.length > 10) {
      setState(() {
        _isCareTakerMobileNumberValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 104, 220, 108),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        title: Center(
            child: Text(
          "Villa Person Info",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        )),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: ownerName,
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
                        labelText: "Owner Name ",
                        labelStyle: TextStyle(
                            color:
                                _isOwnerNameValid ? Colors.black : Colors.red),
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ownerNumber,
                    onChanged: (value) => _checkOwnerMobileNumberValid(value),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _isOwnerMobileNumberValid
                                    ? Colors.black
                                    : Colors.red)),
                        labelText: "Owner Number ",
                        errorText:
                            _isOwnerMobileNumberValid ? null : "Invalid Number",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: address,
                    onChanged: (value) => _checkAddressValid(value),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        hintMaxLines: 10,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _isAddressValid
                                    ? Colors.black
                                    : Colors.red)),
                        focusColor: Colors.pink[244],
                        errorText: _isAddressValid ? null : "Invalid Address",
                        labelText: "Address",
                        hoverColor: Colors.pink),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) => _checkIsCAreTakerNameValid(value),
                    controller: careTakerName,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _isCareTakerNameValid
                                    ? Colors.black
                                    : Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Care Taker Name ",
                        hoverColor: Colors.pink,
                        errorText:
                            _isCareTakerNameValid ? null : "Invalid name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) =>
                        _checkCareTakerMobileNumberValid(value),
                    controller: careTakerNumber,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _isCareTakerMobileNumberValid
                                    ? Colors.black
                                    : Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.pink[244],
                        labelText: "Care Taker Number ",
                        hoverColor: Colors.pink,
                        errorText: _isCareTakerMobileNumberValid
                            ? null
                            : "invalid mobile number"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                if (ownerName.text.isEmpty ||
                    ownerNumber.text.isEmpty ||
                    address.text.isEmpty ||
                    careTakerName.text.isEmpty ||
                    careTakerNumber.text.isEmpty) {
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
                  await villaPersonInfoUploader(
                      ownerName.text,
                      ownerNumber.text,
                      address.text,
                      careTakerName.text,
                      careTakerNumber.text);
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VillaInfo()));
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .10,
                margin: EdgeInsets.all(10),
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
          )
        ],
      ),
    );
  }
}
