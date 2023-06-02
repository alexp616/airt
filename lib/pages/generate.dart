import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:airt/widgets/selectable_grid.dart';
import 'package:airt/widgets/custom_text_field.dart';
import 'package:airt/widgets/app_bar.dart';
import 'package:airt/utils/image.dart';
import 'package:airt/utils/request.dart';
import 'package:airt/utils/data.dart';
import 'package:airt/utils/storage.dart';
import 'dart:ui';
import 'dart:math';

class GeneratePage extends StatefulWidget {
  final Storage storage;
  
  const GeneratePage({
    super.key,
    required this.storage
  });

  @override
  GeneratePageState createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  final controller = TextfieldTagsController();
  late final SelectableGrid selectableGrid;
  bool isLoading = false;

  static final List<ImageData> images = [
    DefaultImages.one.toImage(),
    DefaultImages.two.toImage(),
    DefaultImages.three.toImage(),
    DefaultImages.four.toImage(),
  ];

  @override
  void initState() {
    super.initState();
    selectableGrid = SelectableGrid(images: images, storage: widget.storage);
  }

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
      selectableGrid.updateImages([for (var image in data) ImageData(image)]);
    } catch (e) {}

    setState(() {
      isLoading = false;
    });
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
                    CustomTextField(
                      controller: controller,
                      submit: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: isLoading ? null :
                          () => generateImages(controller.getTags!),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            isLoading ? 'Loading...' : 'Generate',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    SizedBox(
                      height:
                          min(0.80 * MediaQuery.of(context).size.width, 650),
                      width: min(0.80 * MediaQuery.of(context).size.width, 650),
                      child: selectableGrid,
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
