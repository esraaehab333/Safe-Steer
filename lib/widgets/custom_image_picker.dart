import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_steer/constants/colors.dart';



class CustomPicker extends StatefulWidget {
  const CustomPicker({super.key});

  @override
  CustomPickerState createState() => CustomPickerState();

}
class CustomPickerState extends State<CustomPicker> {
  String? _animal;
  XFile? image;
  bool isUploaded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundColor: MyGray2,
              backgroundImage:
              image == null ? null : FileImage(File(image!.path)), // we can take this path
              radius: 85,
            ),
            Positioned(
              right: 5,
              bottom: 10,
              child: GestureDetector(
                onTap: _pickImage,
                child: Icon(
                  Icons.camera_alt,
                  color:MyWhite,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Visibility(
          visible: !isUploaded,
          child: const Text(
            'Upload your Profile Picture',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    isUploaded = true;
    setState(() {});
    print(image!.path);
    if (image != null) {
      _animal = await _getAnimal(image!);
      setState(() {});
    }
  }

  Future<String?> _getAnimal(XFile file) async {
    return null;
  }
}
