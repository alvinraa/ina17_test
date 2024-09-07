import 'package:flutter/material.dart';
import 'package:ina17_test/core/theme/style.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(1),
        title: Text(
          'test',
          style: TextStyle(color: Styles().color.primary),
        ),
      ),
      body: const Center(
        child: Text('testing page'),
      ),
    );
  }
}
