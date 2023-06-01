import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:airt/pages/style.dart';
import 'package:airt/utils/auth.dart';
import 'package:airt/utils/image.dart';
import 'dart:typed_data';

class CustomButton extends StatelessWidget {
  final Authentication authentication;
  final void Function() onPressed;
  final Color color;
  final int iconId;

  const CustomButton({
    super.key, 
    required this.authentication,
    required this.onPressed,
    required this.color,
    required this.iconId
  });

  Future<ImageData> _pickImage(ImageSource source) async {
    ImageData? image;

    while (image == null) {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source);

      if (picked != null) {
        Uint8List bytes = await picked.readAsBytes();
        image = ImageData(bytes);
      }
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      // onPressed: () async {
      //   if (authentication.auth.currentUser == null) {
      //     await authentication.signInWithGoogle();
      //   }
      //   print('suss');
        
      //   ImageData image = await _pickImage(ImageSource.gallery);
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => StylePage(content: image)
      //     )
      //   );
      // },
      onPressed: onPressed,
      icon: Column(
        children: [
          Icon(
            const IconData(0xf05d, fontFamily: 'MaterialIcons'),
            size: 100,
            color: color,
            shadows: const [
              Shadow(
                offset: Offset(4.0, 6.0),
                blurRadius: 6.0,
                color:Color.fromARGB(255, 0, 0, 0)
              )
            ],
          ),
          Text(
            'Upload an Image',
            style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: color,
              fontWeightDelta: -3,
              shadows: const [
                Shadow(
                  offset: Offset(4.0, 6.0),
                  blurRadius: 6.0,
                  color:Color.fromARGB(255, 0, 0, 0)
                )
              ]
            )
          )
        ]
      ),
      label: const Text('')
    );
        
        
        // Container(
        //     alignment: Alignment.center,
        //     decoration: const BoxDecoration(
        //         color: Colors.deepOrange,
        //         borderRadius: BorderRadius.all(Radius.circular(20))),
        //     child: Container(
        //         decoration: const BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: const Text('add image'))));
  }
}
