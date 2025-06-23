import 'package:favorite_places/widgets/show_maps.dart';
import 'package:flutter/material.dart';

class ShowLocation extends StatefulWidget {
  const ShowLocation({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;
  @override
  State<ShowLocation> createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {
  @override
  Widget build(BuildContext context) {
    return widget.latitude != 0.0 && widget.longitude != 0.0
        ? LocationMapWidget(latitude: widget.latitude, longitude: widget.longitude)
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            width: double.infinity,
            height: 200,
            child: const Center(
              child: Text(
                'No Location Selected',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
