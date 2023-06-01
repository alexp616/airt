import 'package:flutter/material.dart';
import 'dart:typed_data';

class ImageData {
  final Image display;
  final Uint8List bytes;

  ImageData(Uint8List bytes) : 
    this.display = Image.memory(bytes),
    this.bytes = bytes;
  
  ImageData.direct(Image display) :
    this.display = display,
    this.bytes = Uint8List(0);  
}