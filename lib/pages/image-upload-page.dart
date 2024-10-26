import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:villachalo_admin/components/loading-bar.dart';
import 'package:villachalo_admin/methods/upload-task-method.dart';
import 'package:villachalo_admin/pages/home-page.dart';
import 'package:villachalo_admin/pages/image-add-page.dart';

class ImageUploaderPage extends StatefulWidget {
  const ImageUploaderPage({super.key});

  @override
  State<ImageUploaderPage> createState() => _ImageUploaderPageState();
}

class _ImageUploaderPageState extends State<ImageUploaderPage> {
  File? _mainImage;
  List<File> otherImages = [];
  ImagePicker imagePicker = ImagePicker();
  bool _isLoading=false;

  Future<void> _pickSingleImageFromGallery() async {
    try {
      XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _mainImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      // Handle errors
      print("Error picking image: $e");
    }
  }

  Future<void> _pickMultipleImagesFromGallery() async {
    try {
      List<XFile>? pickedImages = await imagePicker.pickMultiImage();
      if (pickedImages != null) {
        setState(() {
          otherImages = pickedImages.map((image) => File(image.path)).toList();
        });
      }
    } catch (e) {
      // Handle errors
      print("Error picking images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 104, 220, 108),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 18),
        ),
        title: Center(child: Text("Villa Image Upload", style: TextStyle(fontSize: 18))),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                otherImages.isEmpty? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickMultipleImagesFromGallery,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(style: BorderStyle.solid),
                        ),
                        child: Wrap(
                          children: [Text("Click here to select other images")],
                        ),
                      ),
                    ),
                  ],
                ):SizedBox(height: 0,),

                
                if (otherImages.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    itemCount: otherImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Image.file(
                          otherImages[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 100,)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async{
                if (otherImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                          content: Text("Please Upload Image !!", style: TextStyle(color: Colors.white),))
                      );
                  } 
                  else
                  {
                  setState(() {
                    _isLoading = true;
                  });
                  _isLoading ? ShowDialog.show(context, "Submiting...") : null;
                  SharedPreferences preferences=await SharedPreferences.getInstance();
                  final propertyId=preferences.getString("villa_id");
                  await uploadImages(otherImages,propertyId.toString());
                  setState(() {
                    _isLoading = false;
                  });
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Home()), (route) => false);
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
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          )
          
        ],
      ),
    );
  }
}
