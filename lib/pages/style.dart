import 'package:flutter/material.dart';
import 'package:airt/utils/request.dart';
import 'package:airt/widgets/scroll_background.dart';
import 'package:airt/widgets/login_card.dart';
import 'package:airt/widgets/app_bar.dart';
import 'package:airt/utils/image.dart';

import 'dart:ui';

class StylePage extends StatefulWidget {
  ImageData content;
  StylePage({super.key, required this.content});

  @override
  _StylePageState createState() => _StylePageState();
}

class _StylePageState extends State<StylePage> {
  void mergeImages(ImageData content, ImageData style) async {
    try {
      final client = RequestClient('https://airt.ngrok.app/');
      final data = await client.mergeImages(content.bytes, style.bytes);

      setState(() {
        widget.content = ImageData(data);
      });
    } catch (e) {
      print(e);
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
          appBar: CustomAppBar(context: context),
        ),
      ],
    );
  }
}
