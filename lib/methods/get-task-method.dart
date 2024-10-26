import 'dart:convert';
import 'package:villachalo_admin/models/json-to-object.dart'; 
import 'package:http/http.dart' as http;

Future<List<Property>> getAllProperties() async {
  try {
    final response = await http.get(Uri.parse("https://tripolo-backend.onrender.com/api/property/property-details-all"));
    
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse is List) {
        List<Property> propertyList = decodedResponse.map((json) => Property.fromJson(json)).toList();
        print(propertyList);
        return propertyList;
      } else {
        throw Exception("Unexpected JSON format: ${response.body}");
      }
    } else {
      throw Exception("Failed to load properties, status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to load properties, error: $e");
  }
}
