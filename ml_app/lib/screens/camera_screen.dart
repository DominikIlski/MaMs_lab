import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? photo;
  List<String> labelsList = [];
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Center(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                      photo = File(photoHelper!.path);
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
                      final imageLabeler = ImageLabeler(
                          options:
                              ImageLabelerOptions(confidenceThreshold: 0.5));
                      final List<ImageLabel> labels = await imageLabeler
                          .processImage(InputImage.fromFile(photo!));
                      setState(() {
                        labelsList = labels.map((e) => e.label).toList();
                      });
                      imageLabeler.close();
                    })
                  : (null),
              child: Text('Label')),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: labelsList
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(label: Text(e)),
                          ))
                      .toList(),
                )),
          )
        ]),
      ),
    );
  }
}
