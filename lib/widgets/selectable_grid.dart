import 'package:flutter/material.dart';
import 'package:airt/utils/image.dart';
import 'package:airt/utils/storage.dart';
import 'package:airt/pages/style.dart';

class SelectableGrid extends StatefulWidget {
  final Storage storage;
  late SelectableGridState state;
  List<ImageData> images;
  int selectedIndex = -1;

  get selectedImage => (selectedIndex >= 0) ? images[selectedIndex] : null;

  SelectableGrid({
    super.key,
    required this.images,
    required this.storage
  });

  void updateImages(List<ImageData> images) {
    state.setState(() {
      this.images = images;
    });
  }

  @override
  SelectableGridState createState() {
    state = SelectableGridState();
    return state;
  }
}

class SelectableGridState extends State<SelectableGrid> {
  void handleSelection(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  Widget selectableImage(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        handleSelection(index);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      widget.images[widget.selectedIndex].display,
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(
                            Icons.close,
                            shadows: [
                              Shadow(
                                blurRadius: 6.0,
                                offset: Offset(6.0, 12.0),
                                color: Color.fromARGB(255, 0, 0, 0),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Continue',
                              style: Theme.of(context).textTheme.headlineSmall!.apply(
                                fontWeightDelta: 2,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(6.0, 6.0),
                                    blurRadius: 6.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: const Icon(
                                IconData(0xe09b, fontFamily: 'MaterialIcons'),
                                shadows: [
                                  Shadow(
                                    blurRadius: 6.0,
                                    offset: Offset(6.0, 12.0),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StylePage(
                                      content: widget.selectedImage,
                                      storage: widget.storage,
                                    )
                                  )
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 6.0,
                offset: const Offset(6.0, 6.0),
                color: const Color.fromARGB(255, 0, 0, 0)
                  .withOpacity(0.2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: widget.images[index].display,
          ),
        ),
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
