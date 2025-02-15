import 'package:flutter/material.dart';

class NullLocationPage extends StatefulWidget {
  const NullLocationPage({super.key});

  @override
  State<NullLocationPage> createState() => _NullLocationPageState();
}

class _NullLocationPageState extends State<NullLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(
        'Null Location Page'
      ))

    );
  }
}