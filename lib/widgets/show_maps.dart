import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double zoom;
  final String? markerTitle;
  final String? markerSnippet;
  final double? width;
  final double? height;
  final MapType mapType;
  final MapBorderStyle borderStyle; // New parameter for border style

  const LocationMapWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
    this.zoom = 15.0,
    this.markerTitle,
    this.markerSnippet,
    this.width,
    this.height,
    this.mapType = MapType.normal,
    this.borderStyle = MapBorderStyle.neon, // Default style
  }) : super(key: key);

  @override
  State<LocationMapWidget> createState() => _LocationMapWidgetState();
}

// Enum for different border styles
enum MapBorderStyle {
  modern,
  elegant,
  neon,
  gradient,
  glass,
  classic,
  floating,
}

class _LocationMapWidgetState extends State<LocationMapWidget> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarker();
  }

  @override
  void didUpdateWidget(LocationMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude ||
        oldWidget.markerTitle != widget.markerTitle ||
        oldWidget.markerSnippet != widget.markerSnippet) {
      _setMarker();
    }
  }

  void _setMarker() {
    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('location_marker'),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: InfoWindow(
            title: widget.markerTitle ?? 'Location',
            snippet: widget.markerSnippet,
          ),
        ),
      };
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  // Method to get decoration based on selected style
  BoxDecoration _getMapDecoration() {
    switch (widget.borderStyle) {
      case MapBorderStyle.modern:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 8),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 40,
              offset: Offset(0, 16),
            ),
          ],
        );

      case MapBorderStyle.elegant:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 30,
              offset: Offset(0, 8),
            ),
          ],
        );

      case MapBorderStyle.neon:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.cyan, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(0, 0),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.cyan.withOpacity(0.3),
              blurRadius: 40,
              offset: Offset(0, 0),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        );

      case MapBorderStyle.gradient:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.1),
              Colors.blue.withOpacity(0.1),
              Colors.cyan.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(width: 3, color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(-5, -5),
            ),
            BoxShadow(
              color: Colors.cyan.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(5, 5),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 25,
              offset: Offset(0, 10),
            ),
          ],
        );

      case MapBorderStyle.glass:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
          color: Colors.white.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 30,
              offset: Offset(0, -2),
            ),
          ],
        );

      case MapBorderStyle.classic:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        );

      case MapBorderStyle.floating:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 25,
              offset: Offset(0, 15),
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 50,
              offset: Offset(0, 25),
              spreadRadius: -10,
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.05),
              blurRadius: 60,
              offset: Offset(0, 30),
              spreadRadius: -15,
            ),
          ],
        );

      default:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: _getMapDecoration(),
        width: widget.width,
        height: widget.height ?? 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.borderStyle == MapBorderStyle.floating
                ? 28
                : widget.borderStyle == MapBorderStyle.modern
                ? 24
                : widget.borderStyle == MapBorderStyle.gradient
                ? 22
                : widget.borderStyle == MapBorderStyle.neon
                ? 20
                : widget.borderStyle == MapBorderStyle.glass
                ? 18
                : widget.borderStyle == MapBorderStyle.elegant
                ? 16
                : 12,
          ),
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: widget.zoom,
            ),
            markers: _markers,
            mapType: widget.mapType,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
