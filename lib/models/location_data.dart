import 'dart:io';

class Location {
  final String id;
  final String place;
  // image file can be added later if needed
  final File? imageFile;
  final double? latitude;
  final double? longitude;
  final String? address;

  Location({
    this.id = '',
    required this.place,
    this.imageFile,
    this.latitude,
    this.longitude,
    this.address,
  });
}
