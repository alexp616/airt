import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:airt/pages/style.dart';
import 'package:airt/widgets/selectable_grid.dart';
import 'package:airt/widgets/custom_text_field.dart';
import 'package:airt/widgets/app_bar.dart';
import 'package:airt/utils/image.dart';
import 'package:airt/utils/request.dart';
import 'dart:ui';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  GeneratePageState createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  final selectableGrid = SelectableGrid(images: images);
  final controller = TextfieldTagsController();
  bool isLoading = false;

  static late final List<ImageData> images = [
    ImageData.direct(Image.asset('art/one.png')),
    ImageData.direct(Image.asset('art/two.png')),
    ImageData.direct(Image.asset('art/three.png')),
    ImageData.direct(Image.asset('art/four.png')),
  ];

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> generateImages(List<String> tags) async {
    setState(() {
      isLoading = true;
    });

    try {
      final client = RequestClient('https://airt.ngrok.app/');
      final data = await client.generateImages(tags.join(', '));

      setState(() {
        selectableGrid.images = [for (var image in data) ImageData(image)];

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('background2.png'),
            fit: BoxFit.cover,
          )),
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
          appBar: CustomAppBar(
              // width: min(MediaQuery.of(context).size.width, 750),
              // color: Theme.of(context).colorScheme.background,
              context: context),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller,
                    submit: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the border radius
                        ),
                        // textStyle: Theme.of(context).textTheme.headlineSmall,
                      ),
                      onPressed: isLoading ? null : () => generateImages(controller.getTags!),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Generate',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 0.4 * MediaQuery.of(context).size.height,
                    child: selectableGrid,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StylePage(
                                content: selectableGrid.selectedImage)),
                      );
                    },
                    child: const Text('continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
