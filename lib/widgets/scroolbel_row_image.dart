import 'dart:ffi';

import 'package:favorite_places/pages/place_details_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/loacation_provider.dart';

class ScroolbelRowImage extends ConsumerStatefulWidget {
  const ScroolbelRowImage({super.key});

  @override
  ConsumerState<ScroolbelRowImage> createState() => _ScroolbelRowImageState();
}

class _ScroolbelRowImageState extends ConsumerState<ScroolbelRowImage> {
  @override
  Widget build(BuildContext context) {
    final images = ref.watch(locationProvider);

    // Filter out locations that don't have valid image files
    final validImages = images
        .where(
          (location) =>
              location.imageFile != null && location.imageFile!.existsSync(),
        )
        .toList();

    // Return nothing (SizedBox.shrink) if no valid images
    if (validImages.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No images available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: validImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PlaceDetailsPage(place: validImages[index]),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  validImages[index].imageFile!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback widget if image fails to load
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[600],
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
