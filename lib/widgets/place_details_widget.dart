import 'package:favorite_places/models/location_data.dart';
import 'package:favorite_places/widgets/add_image_widget.dart';
import 'package:favorite_places/widgets/show_location.dart';
import 'package:favorite_places/widgets/show_maps.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/models/location_data.dart';
import 'dart:io';

class PlaceDetails extends StatefulWidget {
  const PlaceDetails({super.key, required this.place});
  final Location place;
  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Image",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          AddImagePicker(imagePath: widget.place.imageFile ?? File('')),
          SizedBox(height: 10),
          Text(
            "Map Location",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          LocationMapWidget(
            latitude: widget.place.latitude ?? 0.0,
            longitude: widget.place.longitude ?? 0.0,
          ),
          SizedBox(height: 10),
          Text(
            widget.place.address ?? 'No Place Name',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
