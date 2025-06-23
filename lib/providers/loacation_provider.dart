import 'package:favorite_places/models/location_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

Future<Database> getDatabase() async {
  // Get the path to the database
  var databasesPath = await getDatabasesPath();
  String pathDb = path.join(databasesPath, 'places.db');

  // Open the database
  return openDatabase(
    pathDb,
    version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE places ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'place TEXT, '
        'imageFile TEXT, '
        'latitude REAL, '
        'longitude REAL, '
        'address TEXT'
        ')',
      );
    },
  );
}

// create class LocationProviderNotifier to manage the state of the location
class LocationProviderNotifier extends StateNotifier<List<Location>> {
  LocationProviderNotifier() : super([]);
  // Method to fetch locations from the database
  Future<void> fetchLocations() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> maps = await database.query('places');

    // Convert the List<Map<String, dynamic>> to List<Location>
    state = maps.map((map) {
      return Location(
        id: map['id'].toString(),
        place: map['place'],
        imageFile: map['imageFile'] != null ? File(map['imageFile']) : null,
        latitude: map['latitude'],
        longitude: map['longitude'],
        address: map['address'],
      );
    }).toList();
  }

  // Method to update the location
  // Method to add location (fixed version)
  void addLocation(Location location) async {
    // get the path image from the location
    final gatAppDir = await path_provider.getApplicationDocumentsDirectory();

    String? finalImagePath;
    if (location.imageFile != null) {
      // Generate unique filename to avoid conflicts
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(location.imageFile!.path);
      final fileName = 'image_${timestamp}$extension';
      final newImagePath = path.join(gatAppDir.path, fileName);

      // Copy the image file to the app directory
      await location.imageFile!.copy(newImagePath);
      finalImagePath = newImagePath;
    }

    // Insert the location into the database
    final database = await getDatabase();
    final insertedId = await database.insert('places', {
      'place': location.place,
      'imageFile': finalImagePath,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'address': location.address,
    });

    // Create a new Location object with the database-generated ID
    final newLocation = Location(
      id: insertedId.toString(), // ✅ Use the database-generated ID
      place: location.place,
      imageFile: finalImagePath != null ? File(finalImagePath) : null,
      latitude: location.latitude,
      longitude: location.longitude,
      address: location.address,
    );

    state = [...state, newLocation];
  }

  // Method to remove a location from db
  void removeLocation(Location location) async {
    final database = await getDatabase();
    // Delete the location from the database
    await database.delete('places', where: 'id = ?', whereArgs: [location.id]);

    // Remove the location from the state
    state = state.where((loc) => loc.id != location.id).toList();
  }
}

// Create a provider for the LocationProviderNotifier
final locationProvider =
    StateNotifierProvider<LocationProviderNotifier, List<Location>>(
      (ref) => LocationProviderNotifier(),
    );
