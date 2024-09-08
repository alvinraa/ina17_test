import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ina17_test/core/common/logger.dart';
import 'package:ina17_test/core/widget/button/default_button.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  XFile? pickedImage;
  String textFromImage = '';
  bool scanning = false;
  int calcResult = 0;

  final ImagePicker _imagePicker = ImagePicker();

  getImage(ImageSource imageSource) async {
    XFile? result = await _imagePicker.pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (result != null) {
      setState(() {
        pickedImage = result;
      });

      performceTextRecognition();
    }
  }

  performceTextRecognition() async {
    setState(() {
      scanning = true;
    });
    try {
      if (pickedImage?.path != null) {
        // add textRecognizer
        final textRecognizer =
            TextRecognizer(script: TextRecognitionScript.latin);
        // add image from path
        final InputImage inputImage =
            InputImage.fromFilePath(pickedImage?.path ?? '');
        // process the image
        final RecognizedText recognizedText =
            await textRecognizer.processImage(inputImage);

        setState(() {
          textFromImage = recognizedText.text;
          calculate(textFromImage);
          scanning = false;
        });

        textRecognizer.close();
      }
    } catch (e) {
      Logger.print('error during text recognition : $e');
    }
  }

  // for now only support single calculation
  // example : 1+1, 2-2, 3*3, 4:2
  int calculate(String s) {
    // Split string based on the operators
    List<String> numbers = s.split(RegExp(r'[\+\-\*\/]'));

    // Get the operator
    String operator = s.replaceAll(RegExp(r'[0-9]'), '');

    // Convert string numbers to integers
    int num1 = int.parse(numbers[0]);
    int num2 = int.parse(numbers[1]);

    // Perform the operation based on the operator
    switch (operator) {
      case '+':
        return calcResult = num1 + num2;
      case '-':
        return calcResult = num1 - num2;
      case '*':
        return calcResult = num1 * num2;
      case '/':
        return calcResult = num1 ~/ num2; // pembagian Integer
      default:
        throw Exception('Invalid operator');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'Take Photo',
        ),
      ),
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              // will change to image from galery or camera
              pickedImage == null
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 300,
                      child: Center(
                        child: Text(
                          'No image selected',
                          softWrap: true,
                          style: GoogleFonts.lato(
                            textStyle: textTheme.labelLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 300,
                      child: Center(
                        child: Image.file(
                          File(pickedImage?.path ?? ''),
                          height: 300,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Recognized Text : ',
                  softWrap: true,
                  style: GoogleFonts.lato(
                    textStyle: textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              pickedImage == null
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$textFromImage = $calcResult',
                        softWrap: true,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
        const SizedBox(height: 24),
        buildTakePhoto(context),
      ],
    );
  }

  Widget buildTakePhoto(BuildContext context) {
    // var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: DefaultButton(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  // showLoading: state is SelfSummarySaveLoading,
                  label: 'Take a picture',
                  height: 40,
                ),
              ),
              Expanded(
                child: DefaultButton(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  // showLoading: state is SelfSummarySaveLoading,
                  label: 'Select from galery',
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
