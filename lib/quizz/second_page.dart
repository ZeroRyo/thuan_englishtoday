import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Learn_English_Today/quizz/api_trivia.dart';
import 'package:Learn_English_Today/models/questions.dart';
import 'dart:math';

import 'package:Learn_English_Today/quizz/question_pageview.dart';
import 'package:Learn_English_Today/models/shuffleanswers.dart';

//todo change this name
typedef void Randomise(List options);

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}) : super(key: key);
  List wrongRightList = [];

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final ApiTrivia _apitrivia = ApiTrivia();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Color(0xffF7EBE1),
      appBar: AppBar(
        elevation: 0.0,
            backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text('English_today questions'),
      ),
      body: _futureWidget(),
    );
  }

  _futureWidget() {
    return FutureBuilder(
      future: _apitrivia.getStates(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List results = snapshot.data as List;
          ShuffleRight(
              result: results,
              Shuffler: (options) {
                widget.wrongRightList = options;
              });

          return QuestionsPageView(
              results: results, wrongRightList: widget.wrongRightList);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
