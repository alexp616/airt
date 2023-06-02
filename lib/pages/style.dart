import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:airt/utils/request.dart';
import 'package:airt/utils/image.dart';
import 'package:airt/utils/storage.dart';
import 'package:airt/utils/data.dart';
import 'package:airt/widgets/app_bar.dart';
import 'package:airt/widgets/image_carousel.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';

class StylePage extends StatefulWidget {
  final Storage storage;
  ImageData content;

  StylePage({super.key, required this.content, required this.storage});

  @override
  StylePageState createState() => StylePageState();
}

class StylePageState extends State<StylePage> {
  late final List<ImageData> savedStyles;
  late ImageCarousel carousel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    savedStyles = widget.storage.styles;
  }

  static final List<ImageData> defaultStyles = [
    DefaultStyles.one.toImage(),
    DefaultStyles.two.toImage(),
    DefaultStyles.three.toImage(),
  ];

  Future<void> addStyle() async {
    ImageData? image;

    while (image == null) {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        Uint8List bytes = await picked.readAsBytes();
        image = ImageData(bytes);
      }
    }

    Storage.addStyle(image);
    setState(() {
      savedStyles.insert(0, image!);
    });
  }

  Future<void> mergeImages(ImageData content, ImageData style) async {
    try {
      final client = RequestClient('https://airt.ngrok.app/');
      final data = await client.mergeImages(content.bytes, style.bytes);

      Storage.addImage(ImageData(data));

      setState(() {
        widget.content = ImageData(data);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    carousel = ImageCarousel(
      images: List.from(savedStyles)..addAll(defaultStyles),
      // height: min(0.4 * MediaQuery.of(context).size.height, 325),
      autoPlay: false,
      focus: false,
    );

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('background2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(context: context),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: min(0.9 * MediaQuery.of(context).size.width, 750),
                        maxHeight: min(0.3 * MediaQuery.of(context).size.height, 250)
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                            offset: const Offset(6.0, 6.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: widget.content.display,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: min(0.90 * MediaQuery.of(context).size.width, 750),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize: Size(
                                  min(0.35 * MediaQuery.of(context).size.width, 300),
                                  min(0.13 * MediaQuery.of(context).size.height, 93),
                                ),
                              ),
                              onPressed: () async {
                                await addStyle();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    IconData(0xf537, fontFamily: 'MaterialIcons'),
                                    size: 60,
                                  ),
                                  Text(
                                    'Add Style',
                                    style: TextStyle(
                                      fontSize: 18
                                    )
                                  ),
                                ]
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fixedSize: Size(
                                  min(0.35 * MediaQuery.of(context).size.width, 300),
                                  min(0.13 * MediaQuery.of(context).size.height, 93),
                                ),
                              ),
                              onPressed: () {
                                mergeImages(widget.content, carousel.focusedImage);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.arrow_right,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Merge',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Apply Style',
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                        shadows: const [
                          Shadow(
                            offset: Offset(6.0, 6.0),
                            blurRadius: 6.0,
                            color: Colors.black,
                          ),
                        ],
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: min(0.25 * MediaQuery.of(context).size.height, 200),
                      width: min(0.8 * MediaQuery.of(context).size.width, 675),
                      child: carousel,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
