// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ina17_test/core/common/logger.dart';
import 'package:ina17_test/core/widget/button/default_button.dart';
import 'package:ina17_test/feature/home/data/model/result_model.dart';
import 'package:ina17_test/feature/take_photo/bloc/take_photo_bloc.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  XFile? pickedImage;
  String textFromImage = '';
  bool scanning = false;
  bool isTextConvertSuccess = false;
  late TakePhotoBloc bloc;

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
      isTextConvertSuccess = false;
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

        // note: if using camera still always failed, but if using image from galery sometimes it success,
        // here the success image when using galery :
        // https://www.google.com/imgres?q=2%2B2&imgurl=https%3A%2F%2Fwww.islingtontribune.co.uk%2Fmedia%2F2023%2F09%2F2-2-two-arsenal.jpg&imgrefurl=https%3A%2F%2Fwww.islingtontribune.co.uk%2Farticle%2Farsenal-frustrated-by-bayern-in-close-encounter&docid=92XjSd0wh8hP1M&tbnid=D1xnjl9h-gbMtM&vet=12ahUKEwj_jYqI9LKIAxV5e2wGHZLCDTcQM3oECEcQAA..i&w=1600&h=900&hcb=2&ved=2ahUKEwj_jYqI9LKIAxV5e2wGHZLCDTcQM3oECEcQAA
        // https://www.google.com/imgres?q=2%2B2&imgurl=https%3A%2F%2Fwww.shanghaireunited.com%2Fwp-content%2Fuploads%2F2015%2F01%2Fdraw-score-640x360.jpg&imgrefurl=https%3A%2F%2Fwww.shanghaireunited.com%2F3u-anzacs-draw-2-2%2F&docid=mJFPApMiBOFBUM&tbnid=GSWWKxjO8K1mbM&vet=12ahUKEwj_jYqI9LKIAxV5e2wGHZLCDTcQM3oECGYQAA..i&w=640&h=360&hcb=2&ved=2ahUKEwj_jYqI9LKIAxV5e2wGHZLCDTcQM3oECGYQAA

        setState(() {
          textFromImage = recognizedText.text;
          bloc.add(TakePhotoRequest(value: textFromImage));
          scanning = false;
          isTextConvertSuccess = true;
        });

        textRecognizer.close();
      }
    } catch (e) {
      Logger.print('error during text recognition : $e');
      setState(() {
        isTextConvertSuccess = false;
        scanning = false;
      });
    }
  }

  @override
  void initState() {
    bloc = TakePhotoBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // have some issue with PopScope
        // PopScope(
        //   onPopInvoked: (didPop) {
        // if (isTextConvertSuccess == true) {
        //   ResultModel resultModel = ResultModel();
        //   resultModel.input = textFromImage;
        //   resultModel.result = calcResult.toString();

        //   Navigator.pop(context, resultModel);
        // }
        //   },
        WillPopScope(
      onWillPop: () async {
        // Data yang ingin dikirim saat pengguna menekan tombol "Back"
        if (isTextConvertSuccess == true) {
          ResultModel resultModel = ResultModel();
          resultModel.input = textFromImage;
          resultModel.result = bloc.result.toString();

          Navigator.pop(context, resultModel);
        } else {
          Navigator.pop(context);
        }

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text(
            'Image to Text',
          ),
        ),
        body: buildContent(context),
      ),
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
              BlocConsumer(
                bloc: bloc,
                listener: (context, state) {
                  if (state is TakePhotoError) {
                    textFromImage = "Failed recognized";
                    isTextConvertSuccess = false;
                    scanning = false;
                  }
                },
                builder: (context, state) {
                  if (state is TakePhotoLoading) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16),
                      child: const CircularProgressIndicator(),
                    );
                  }

                  if (state is TakePhotoError) {
                    return Container(
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
                        state.errorMessage ?? "-",
                        softWrap: true,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    );
                  }

                  return pickedImage == null
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
                            '$textFromImage = ${bloc.result}',
                            softWrap: true,
                            style: GoogleFonts.lato(
                              textStyle: textTheme.labelLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: colorScheme.secondary,
                              ),
                            ),
                          ),
                        );
                },
              ),
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
                  label: 'Take a Picture',
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
                  label: 'Select from Galery',
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
