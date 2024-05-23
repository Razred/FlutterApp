import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/student_info_page.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:models/model.dart';
import 'package:repositories/repositories.dart';
import 'api_data_page.dart';
import 'feedback_page.dart';




Future<void> main() async {

  runApp(StudentApp());
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentInfoPage()),
                );
              },
              child: Text('ФИО '),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApiDataPage()),
                );
              },
              child: Text('Данные с API'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
              child: Text('Обратная связь'),
            ),
          ],
        ),
      ),
    );
  }
}




