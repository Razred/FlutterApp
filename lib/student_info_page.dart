import 'package:flutter/material.dart';

class StudentInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ФИО студента'),
      ),
      body: Center(
        child: Text(
          'Ращукин Никита Сергеевич',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}