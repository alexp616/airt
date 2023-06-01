import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'dart:math';

class CustomTextField extends StatelessWidget {
  final TextfieldTagsController controller;
  final Widget submit;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      height: min(0.30 * MediaQuery.of(context).size.height, 200),
      width: min(0.90 * MediaQuery.of(context).size.width, 750),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: min(0.20 * MediaQuery.of(context).size.height, 130),
              child: SingleChildScrollView(
                child: TextFieldTags(
                  textfieldTagsController: controller,
                  initialTags: const [
                    'colorful',
                    'landscape',
                    'fantasy',
                    'daytime',
                  ],
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.small,
                  validator: (String tag) {
                    if (tag == 'php') {
                      return 'Cool!';
                    } else if (controller.getTags!.contains(tag)) {
                      return 'You already entered that.';
                    }

                    return null;
                  },
                  inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
                    return (context, sc, tags, onDeleteTag) {
                      return Column(
                        children: [
                          TextField(
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.black
                            ),
                            cursorColor: Theme.of(context).colorScheme.secondary,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: tec,
                            focusNode: fn,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 3.0
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 3.0
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  width: 3.0,
                                ),
                              ),
                              hintText: 'Describe your image...',
                              hintStyle: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: Colors.grey,
                              ),
                              errorText: error,
                              prefixIconConstraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.40 //0.74,
                              ),
                              suffix: GestureDetector(
                                onTap: () => controller.clearTags(),
                                child: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            onChanged: onChanged,
                            onSubmitted: onSubmitted,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 5.0,
                            runSpacing: 5.0,
                            children: tags.map((String tag) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      child: Text(tag),
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      onTap: () {
                                        onDeleteTag(tag);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    };
                  }
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            submit,
          ],
        ),
      ),      
    );
  }
}

