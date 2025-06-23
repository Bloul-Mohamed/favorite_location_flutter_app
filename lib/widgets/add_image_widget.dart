import 'package:flutter/material.dart';
import 'dart:io';

class AddImagePicker extends StatefulWidget {
  const AddImagePicker({super.key, required this.imagePath});
  final File imagePath;
  @override
  State<AddImagePicker> createState() => _AddImagePickerState();
}

class _AddImagePickerState extends State<AddImagePicker> {
  @override
  Widget build(BuildContext context) {
    return widget.imagePath.path.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
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
            ),
          )
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
                'No Image Selected',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
