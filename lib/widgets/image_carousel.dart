import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:airt/utils/image.dart';
import 'dart:math';

class ImageCarousel extends StatelessWidget {
  final List<ImageData> images;
  final double height;
  final bool autoPlay;
  final bool focus;
  int _index = 0;

  get focusedImage => images[_index];

  ImageCarousel({
    super.key,
    required this.images,
    required this.autoPlay,
    required this.focus,
    this.height = 400
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: autoPlay,
        enableInfiniteScroll: false,
        viewportFraction: 0.4,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        onPageChanged: (index, _) {
          _index = index;
        },
      ),
      items: images.map((image) {
        return GestureDetector(
          onTap: focus ? () {
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
                          image.display,
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.close, shadows: [
                                Shadow(
                                  blurRadius: 6.0,
                                  offset: Offset(6.0, 12.0),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ]),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } : () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    offset: const Offset(6.0, 6.0),
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                  ),
                ],
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: image.display,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
