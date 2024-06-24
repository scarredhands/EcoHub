import 'dart:developer' as devtools;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class TfliteModel extends StatefulWidget {
  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  File? filePath;
  String label = '';
  double confidence = 0.0;
  Future<void> _tfLteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
      confidence = 0.0;
      label = '';
    });

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      devtools.log(recognitions.toString());
      setState(() {
        confidence = recognitions[0]['confidence'] * 100;
        label = recognitions[0]['label'].toString();
      });
    } else {
      devtools.log("No recognitions found");
    }
  }

  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
      confidence = 0.0;
      label = '';
    });
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      devtools.log(recognitions.toString());
      setState(() {
        confidence = recognitions[0]['confidence'] * 100;
        label = recognitions[0]['label'].toString();
      });
    } else {
      devtools.log("No recognitions found");
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tfLteInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 249, 249),
      appBar: AppBar(
        title: Text('Image Classifier'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Card(
              elevation: 20,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/plant_disease_detect.png',
                            ),
                            fit: BoxFit
                                .contain, // How to fit the image within the container
                            alignment: Alignment.center,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: filePath == null
                            ? const Text('')
                            : Image.file(
                                filePath!,
                                fit: BoxFit.fill,
                              ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              'image is ${label}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              'the accuracy is ${confidence.toStringAsFixed(0)}%',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                pickImageCamera();
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  foregroundColor: Colors.black),
              child: Text('Take a photo'),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                pickImageGallery();
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  foregroundColor: Colors.black),
              child: Text('take from gallery'),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'NOTE- If the accuracy is less than 70% ,the prediction might be wrong',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
