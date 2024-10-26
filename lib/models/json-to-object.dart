class Property {
  final String id;
  final String vendorId;
  final String propertyName;
  final bool isPool;
  final String poolSize;
  final bool isGarden;
  final bool isActivity;
  final List<String> activities;
  final bool isAmenties;
  final List<String> amenties;
  final String priceWithFoodWeekdays;
  final String priceWithoutFoodWeekdays;
  final String priceWithFoodWeekend;
  final String priceWithoutFoodWeekend;
  final int maxGuest;  // Changed to int if it's an integer in the API
  final String extraCharge;
  final List<String> propertyImages; // Assuming this is a list of image URLs

  Property({
    required this.id,
    required this.vendorId,
    required this.propertyName,
    required this.isPool,
    required this.poolSize,
    required this.activities,
    required this.amenties,
    required this.extraCharge,
    required this.isActivity,
    required this.isAmenties,
    required this.isGarden,
    required this.maxGuest,
    required this.priceWithFoodWeekdays,
    required this.priceWithFoodWeekend,
    required this.priceWithoutFoodWeekdays,
    required this.priceWithoutFoodWeekend,
    required this.propertyImages,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'],
      vendorId: json['vendorId'],
      propertyName: json['propertyName'],
      isPool: json['isPool'],
      poolSize: json['poolSize'],
      activities: List<String>.from(json['activities'] ?? []), 
      amenties: List<String>.from(json['amenties'] ?? []),
      extraCharge: json['extraCharge'],
      isActivity: json['isActivity'],
      isAmenties: json['isAmenties'],
      isGarden: json['isGarden'],
      maxGuest: json['maxGuest'] is String ? int.parse(json['maxGuest']) : json['maxGuest'],
      priceWithFoodWeekdays: json['priceWithFoodWeekdays'],
      priceWithFoodWeekend: json['priceWithFoodWeekend'],
      priceWithoutFoodWeekdays: json['priceWithoutFoodWeekdays'],
      priceWithoutFoodWeekend: json['priceWithoutFoodWeekend'],
      propertyImages: List<String>.from(json['propertyImages'] ?? []), 
    );
  }
}
