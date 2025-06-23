import 'package:favorite_places/models/location_data.dart';
import 'package:favorite_places/widgets/place_details_widget.dart';
import 'package:flutter/material.dart';

class PlaceDetailsPage extends StatefulWidget {
  const PlaceDetailsPage({super.key, required this.place});
  final Location place;

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.place.place} Details")),
      body: PlaceDetails(place: widget.place),
    );
  }
}
