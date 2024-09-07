import 'package:flutter/material.dart';
import 'package:ina17_test/core/common/logger.dart';
import 'package:ina17_test/core/widget/button/default_button.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({super.key});

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
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
    // var textTheme = Theme.of(context).textTheme;
    // var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              // will change to image from galery or camera
              Image.network('https://picsum.photos/250?image=9'),
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
          child: DefaultButton(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {
              // go to add input page
              Logger.print('take photo');
            },
            // showLoading: state is SelfSummarySaveLoading,
            label: 'Take Photo',
            height: 40,
          ),
        ),
      ),
    );
  }
}
