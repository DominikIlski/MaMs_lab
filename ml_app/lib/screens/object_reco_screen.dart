import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/cordinates_translator.dart';

class ObjectRecoScreen extends StatefulWidget {
  ObjectRecoScreen({Key? key}) : super(key: key);

  @override
  State<ObjectRecoScreen> createState() => _ObjectRecoState();
}

class _ObjectRecoState extends State<ObjectRecoScreen> {
  File? photo;
  double photoHeight = 0;
  double photoWidth = 0;
  List<DetectedObject> detectedObjectsList = [];

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Center(
      child: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          photo != null
              ? Stack(
                fit: StackFit.loose,
                  children: [
                    Image.file(
                      File(photo!.path),
                      height: 300,
                      width: 300,
                    ),
                    CustomPaint(
                      size: Size(300,300),
                      painter: OpenPainter(
                          detectedObjectsList, Size(photoWidth, photoHeight)),
                    ),
                  ],
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
                      final objectDetector = ObjectDetector(
                        options: ObjectDetectorOptions(
                          mode: DetectionMode.singleImage,
                          classifyObjects: true,
                          multipleObjects: true,
                        ),
                      );
                      final List<DetectedObject> _objects =
                          await objectDetector
                              .processImage(InputImage.fromFile(photo!));
                      var decodedImage =
                          await decodeImageFromList(photo!.readAsBytesSync());

                      setState(() {
                        detectedObjectsList = _objects;
                        photoWidth = decodedImage.width * 1;
                        photoHeight = decodedImage.height * 1;
                      });

                      objectDetector.close();
                    })
                  : (null),
              child: Text('Label')),
        ]),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final List<DetectedObject> detectedObjects;
  final Size absoluteSize;
  OpenPainter(this.detectedObjects, this.absoluteSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff995588)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    detectedObjects.forEach((element) {
      final left = translateX(element.boundingBox.left, size, absoluteSize);
      final top = translateY(element.boundingBox.top, size, absoluteSize);
      final right = translateX(element.boundingBox.right, size, absoluteSize);
      final bottom = translateY(element.boundingBox.bottom, size, absoluteSize);

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint1,
      );
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
