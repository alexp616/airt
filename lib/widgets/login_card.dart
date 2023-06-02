import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:airt/widgets/custom_button.dart';
import 'package:airt/widgets/image_carousel.dart';
import 'package:airt/pages/style.dart';
import 'package:airt/pages/generate.dart';
import 'package:airt/utils/auth.dart';
import 'package:airt/utils/image.dart';
import 'dart:typed_data';
import 'dart:math';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  LoginCardState createState() => LoginCardState();
}

class LoginCardState extends State<LoginCard> {
  Future<ImageData> addImage() async {
    ImageData? image;
    while (image == null) {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        Uint8List bytes = await picked.readAsBytes();
        image = ImageData(bytes);
      }
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Authentication.initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error initializing Firebase.');
        }

        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 0.05 * MediaQuery.of(context).size.height,
              horizontal: 0.1 * MediaQuery.of(context).size.width,
            ),
            child: SizedBox(
              height: 0.85 * MediaQuery.of(context).size.height,
              width: min(0.8 * MediaQuery.of(context).size.width, 750),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.1 * MediaQuery.of(context).size.width,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AI',
                            style:
                                Theme.of(context).textTheme.displayLarge!.apply(
                              fontWeightDelta: 2,
                              color: Theme.of(context).colorScheme.primary,
                              shadows: [
                                const Shadow(
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 6.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'rt',
                            style:
                                Theme.of(context).textTheme.displayLarge!.apply(
                              fontWeightDelta: 2,
                              color: Theme.of(context).colorScheme.secondary,
                              shadows: [
                                const Shadow(
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 6.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '.',
                            style:
                                Theme.of(context).textTheme.displayLarge!.apply(
                              fontWeightDelta: 2,
                              color: Theme.of(context).colorScheme.primary,
                              shadows: [
                                const Shadow(
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 6.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                offset: const Offset(6.0, 6.0),
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 0.003 *
                                    MediaQuery.of(context)
                                        .size
                                        .height, // Half of the screen height
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary, // Top half color
                              ),
                              Container(
                                height: 0.004 *
                                    MediaQuery.of(context)
                                        .size
                                        .height, // Half of the screen height // Top half color
                              ),
                              Container(
                                height: 0.003 *
                                    MediaQuery.of(context)
                                        .size
                                        .height, // Half of the screen height
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Bottom half color
                              ),
                            ],
                          ),
                      ),
                      SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                      CustomButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () async {
                          if (snapshot.data!.auth.currentUser == null) {
                            await snapshot.data!.signInWithGoogle();
                            await snapshot.data!.storage.update();
                            setState(() { });
                          }

                          final image = await addImage();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StylePage(
                                content: image,
                                storage: snapshot.data!.storage
                              ),
                            ),
                          );
                        },
                        label: 'Upload Image',
                        iconId: 0xf05d,
                      ),
                      SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                      CustomButton(
                        onPressed: () async {
                          if (snapshot.data!.auth.currentUser == null) {
                            await snapshot.data!.signInWithGoogle();
                            await snapshot.data!.storage.update();
                            setState(() { });
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GeneratePage(
                                storage: snapshot.data!.storage
                              ),
                            ),
                          );
                        },
                        color: Theme.of(context).colorScheme.primary,
                        label: 'Generate Image',
                        iconId: 0xf0787,
                      ),
                      ImageCarousel(
                        images: snapshot.data!.storage.images,
                        height: 0.2 * MediaQuery.of(context).size.height,
                        autoPlay: true,
                        focus: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondary,
          ),
        );
      },
    );
  }
}
