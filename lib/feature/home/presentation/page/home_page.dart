import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ina17_test/core/common/logger.dart';
import 'package:ina17_test/core/common/navigation.dart';
import 'package:ina17_test/core/common/routes.dart';
import 'package:ina17_test/core/theme/style.dart';
import 'package:ina17_test/core/widget/button/default_button.dart';
import 'package:ina17_test/feature/home/data/model/result_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ResultModel> listResult = [];
  ResultModel? resultModel;
  String? input;
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Calculator from Image',
          style: TextStyle(color: Styles().color.primary),
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
              buildResultCalc(context),
            ],
          ),
        ),
        const SizedBox(height: 24),
        buildAddInput(context),
      ],
    );
  }

  Widget buildResultCalc(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return listResult.isEmpty
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
            child: Center(
              child: Text(
                'Data still empty',
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
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listResult.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      'Result ${index + 1} ',
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
                  resultCalc(listResult[index].input ?? '',
                      listResult[index].result ?? ''),
                ],
              );
            },
          );
  }

  Widget resultCalc(String input, String result) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // input
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'input: ',
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
              Expanded(
                child: Text(
                  // change to image to text
                  input,
                  softWrap: true,
                  style: GoogleFonts.lato(
                    textStyle: textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      // color: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // result
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'result: ',
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
              Text(
                // calc from image to text
                result,
                softWrap: true,
                style: GoogleFonts.lato(
                  textStyle: textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    // color: colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddInput(BuildContext context) {
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
                flex: 1,
                child: DefaultButton(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {
                    Logger.print('reset result');
                    setState(() {
                      listResult = [];
                    });
                  },
                  label: 'Reset',
                  height: 40,
                ),
              ),
              Expanded(
                flex: 2,
                child: DefaultButton(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {
                    // go to add input page
                    Logger.print('go to add_input_page');
                    navigatorKey.currentState
                        ?.pushNamed(
                      Routes.takePhotoPage,
                      // arguments: data,
                    )
                        .then((value) {
                      if (value != null) {
                        resultModel = value as ResultModel?;
                        if (resultModel != null) {
                          setState(() {
                            listResult.add(resultModel ?? ResultModel());
                          });
                        }
                      }
                    });
                  },
                  label: 'Add Input',
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
