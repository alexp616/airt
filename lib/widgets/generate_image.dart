import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:airt/utils/auth.dart';
import 'dart:typed_data';

class GenerateImageButton extends StatelessWidget {
  final Authentication authentication;

  const GenerateImageButton({super.key, required this.authentication});
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO
        
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'add image'
          )
        )
      )
    ); 
  }
}