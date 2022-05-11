import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextRecoScreen extends StatefulWidget {
  TextRecoScreen({Key? key}) : super(key: key);

  @override
  State<TextRecoScreen> createState() => _TextRecoScreenState();
}

class _TextRecoScreenState extends State<TextRecoScreen> {
  File? photo;
  List<String> labelsList = [];
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            photo != null
                ? Image.file(
                    File(photo!.path),
                    width: double.infinity,
                    height: 300,
                  )
                : const SizedBox(
                    height: 300,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      var photoHelper =
                          await _picker.pickImage(source: ImageSource.camera);
                      setState((() {
                        if (photoHelper != null) {
                          photo = File(photoHelper!.path);
                        }
                      }));
                    },
                    child: Text('take a  photo')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var photoHelper =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState((() {
                        if (photoHelper != null) {
                          photo = File(photoHelper.path);
                        }
                      }));
                    },
                    child: Text('choose a photo'))
              ],
            ),
            ElevatedButton(
                onPressed: photo != null
                    ? (() async {
                        final textRecognizer =
                            TextRecognizer(script: TextRecognitionScript.latin);
                        final RecognizedText recognizedText =
                            await textRecognizer
                                .processImage(InputImage.fromFile(photo!));

                        setState(() {
                          labelsList =
                              recognizedText.blocks.map((e) => e.text).toList();
                        });

                        textRecognizer.close();
                      })
                    : (null),
                child: Text('Label')),
            ...labelsList
                .map((e) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Card(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      ), ),
                    ))
                .toList()
          ]),
        ),
      ),
    );
  }
}
