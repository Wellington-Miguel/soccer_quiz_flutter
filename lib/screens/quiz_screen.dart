import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/di.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool loading = false;
  List<dynamic> questions = [];
  Map<int, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
            'assets/Logo.png',
            width: 160,
            fit: BoxFit.contain,
          ),
          Text("Quiz Disponíveis", style: TextStyle(color: Colors.white),)
        ]),
      ),
    );
  }
}