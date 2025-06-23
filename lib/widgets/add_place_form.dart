import 'package:favorite_places/models/location_data.dart' as LocationData;
import 'package:favorite_places/providers/loacation_provider.dart';
import 'package:favorite_places/widgets/add_image_widget.dart';
import 'package:favorite_places/widgets/show_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  // using Global Key
  final _formKey = GlobalKey<FormState>();

  // Add TextEditingController for the title field
  final _titleController = TextEditingController();

  var title = '';
  File? imageFile;
  var latiude = 0.0;
  var longitude = 0.0;
  var addressLocation = 'Unknown Map Location';

  // Add loading state
  bool _isGettingLocation = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // Convert latitude and longitude to a human-readable address
  Future<String> geocodingLocation({
    required latitude,
    required longitude,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.name}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Unknown Location';
  }

  void _getCurrentLocation() async {
    // Show loading state
    setState(() {
      _isGettingLocation = true;
    });

    final location.Location _location = location.Location();
    try {
      // Check if location services are enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location services are disabled')),
            );
          }
          return;
        }
      }

      // Check for permissions
      location.PermissionStatus permissionGranted = await _location
          .hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != location.PermissionStatus.granted) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permission denied')),
            );
          }
          return;
        }
      }

      final currentLocation = await _location.getLocation();
      print(
        'Current Location: ${currentLocation.latitude}, ${currentLocation.longitude}',
      );

      setState(() {
        latiude = currentLocation.latitude ?? 0.0;
        longitude = currentLocation.longitude ?? 0.0;
      });

      // Get the address and update the title field
      final address = await geocodingLocation(
        latitude: latiude,
        longitude: longitude,
      );

      if (mounted) {
        setState(() {
          title = address;
          addressLocation = address; // Update the address variable
          _titleController.text = address; // Update the controller's text
        });
      }
    } catch (e) {
      print('Could not get current location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not get current location: $e')),
        );
      }
    } finally {
      // Hide loading state
      if (mounted) {
        setState(() {
          _isGettingLocation = false;
        });
      }
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    if (value.length < 3) {
      return 'Title must be at least 3 characters long';
    }
    return null;
  }

  // add image camera
  Future<void> _addImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  // add image gallery
  Future<void> _addImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  // create the save function
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // add location to the provider
      ref
          .read(locationProvider.notifier)
          .addLocation(
            LocationData.Location(
              place: title,
              imageFile: imageFile,
              latitude: latiude,
              longitude: longitude,
              address: addressLocation, // Use the controller's text
            ),
          );
      // pop the screen to go back to the previous screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
        // Add progress indicator to AppBar
        bottom: _isGettingLocation
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: LinearProgressIndicator(),
              )
            : null,
        actions: [
          // Optional: Add a status indicator in the actions
          if (_isGettingLocation)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title field with controller
                TextFormField(
                  controller:
                      _titleController, // Use controller instead of initialValue
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  validator: validateTitle,
                  onSaved: (value) {
                    title = value ?? '';
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Camera and Gallery buttons row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _addImageFromCamera,
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: _addImageFromGallery,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Gallery'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: _isGettingLocation
                            ? null
                            : _getCurrentLocation,
                        icon: const Icon(Icons.location_on),
                        label: const Text('Get Current Location'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Show status message when getting location
                if (_isGettingLocation)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_searching,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Getting your current location...',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Image picker - give it a fixed height
                SizedBox(
                  height: 200,
                  child: AddImagePicker(imagePath: imageFile ?? File('')),
                ),
                const SizedBox(height: 16),
                ShowLocation(latitude: latiude, longitude: longitude),

                const SizedBox(height: 16),
                // Add location button - full width
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveForm,
                    icon: const Icon(Icons.add_location_alt),
                    label: const Text('Add Location'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

