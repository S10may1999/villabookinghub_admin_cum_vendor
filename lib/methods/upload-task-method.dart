import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> villaPersonInfoUploader(
  String ownerName, 
  String ownerContact,
  String address,
  String careTakerName,
  String careTakerNumber,
  )async{
   

    
    final url=Uri.parse('https://tripolo-backend.onrender.com/api/vendor/vendor-details-post?vendorName=${ownerName}&vendorContact=${ownerContact}&address=${address}&careTakerName=${careTakerName}&careTakerContact=${careTakerNumber}');

    try{
        final response=await http.post(url);

        if(response.statusCode==201){
          final jsonData=jsonDecode(response.body);
          print(jsonData['data_id']);
          final pref=await SharedPreferences.getInstance();
          pref.setString("vendor_Id", jsonData['data_id'].toString());
        }
    }catch(e)
    {
      print(e);
    }
  

}



Future<void> villaInfoUploader(
       String vendorId,
       String propertyName,
       bool isPool,
       String poolSize,
       bool isGarden,
       bool  isActivites,
       String activites,
       bool isAmenties,
       String ameneties,
       String priceWithFoodWeekdays,
       String priceWithoutFoodWeekDays,
       String priceWithFoodWeekends,
       String priceWithoutFoodWeekends,
       String maxGuest,
       String extraCharge,
)async{
  
 final url=Uri.parse('https://tripolo-backend.onrender.com/api/property/property-upload?vendorId=${vendorId}&propertyName=${propertyName}&isPool=${isPool}&poolSize=${poolSize}&isGarden=${isGarden}&isActivites=${isActivites}&activites=${activites}&isAmenties=${isAmenties}&ameneties=${isAmenties}&priceWithFoodWeekdays=${priceWithFoodWeekdays}&priceWithoutFoodWeekDays=${priceWithoutFoodWeekDays}&priceWithFoodWeekends=${priceWithFoodWeekends}&priceWithoutFoodWeekends=${priceWithoutFoodWeekends}&maxGuest=${maxGuest}&extraCharge=${extraCharge}'); 
 try{
    final response=await http.post(url);

    if(response.statusCode==201){
        final decode=jsonDecode(response.body);
        SharedPreferences preferences=await SharedPreferences.getInstance();
        preferences.setString("villa_id", decode['vill_id']);
    }
 }
 catch(e)
 {
    print(e);
 }

}


Future<void> uploadImages(List<File> imageFiles, String propertyId) async {
  var uri = Uri.parse("https://tripolo-backend.onrender.com/api/property/property-image-upload");

  var request = http.MultipartRequest('POST', uri);
  request.fields['property_id'] = propertyId;

  for (File imageFile in imageFiles) {
    var stream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();

    var mimeType = lookupMimeType(imageFile.path);

    request.files.add(http.MultipartFile(
      'media',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: MediaType(mimeType!.split('/')[0], mimeType.split('/')[1]),
    ));
  }


  var response = await request.send();

  if (response.statusCode == 201) {
    print('Images uploaded successfully!');
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("vendor_Id");
    preferences.remove("villa_id");
    var responseData = await http.Response.fromStream(response);
    print(responseData.body);
  } else {
    print('Image upload failed with status: ${response.statusCode}');
  }
}