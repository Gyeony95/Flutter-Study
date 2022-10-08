import 'package:flutter/material.dart';
import 'package:henry_some_one/index.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SomeOneGameApp(),
    );
  }
}

class SomeOneGameApp extends StatelessWidget {
  const SomeOneGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HenrySomeOneGame(),
    );
  }
}
