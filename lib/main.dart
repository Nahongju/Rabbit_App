import 'package:animation_study/introPage.dart';
import 'package:animation_study/miniGame.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rabbit',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: MiniGame(),
    );
  }

  Future<Database> createDatabase() async {
    return openDatabase(
        join(await getDatabasesPath(), 'subject_table.db'),
        onCreate: (db, version) {
          return db.execute(""
              "CREATE TABLE sub("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT, "
              "content TEXT, "
              "day TEXT, "
              "done INTEGER)");
        },
        version: 1
    );
  }
}

