import 'package:flutter/material.dart';
import 'package:airt/utils/image.dart';

class SelectableGrid extends StatefulWidget {
  List<ImageData> images;
  int selectedIndex = -1;
  get selectedImage => images[selectedIndex];

  SelectableGrid({
    super.key,
    required this.images
  });

  @override
  SelectableGridState createState() => SelectableGridState();
}

class SelectableGridState extends State<SelectableGrid> {
  void handleSelection(int index) {
    setState(() {
      if (widget.selectedIndex == index) {
        widget.selectedIndex = -1;
      } else {
        widget.selectedIndex = index;
      }
    });
  }

  Widget selectableImage(int index) {
    return GestureDetector(
      onTap: () => handleSelection(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.selectedIndex == index ?
              Theme.of(context).colorScheme.secondary :
              Colors.transparent,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: widget.images[index].display,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        widget.images.length,
        (index) => selectableImage(index),
      ),
    );
  }
}