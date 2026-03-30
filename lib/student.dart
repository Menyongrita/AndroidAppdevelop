import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';

class Student {
  final String name;
  final int? score;

  Student(this.name, this.score);

  bool get hasScore => score != null;

  String get grade {
    if (score == null) return "No Score";
    if (score! >= 90) return "A";
    if (score! >= 80) return "B";
    if (score! >= 70) return "C";
    if (score! >= 60) return "D";
    return "F";
  }

  String get formattedResult =>
      hasScore ? "$name scored $score : Grade $grade" : "No score for $name";
}

Future<List<Student>> readStudentsFromAssets() async {
  final bytes = await rootBundle.load('assets/excel/students.xlsx');
  final excel = Excel.decodeBytes(bytes.buffer.asUint8List());

  List<Student> students = [];

  for (var table in excel.tables.keys) {
    var sheet = excel.tables[table];

    for (var row in sheet!.rows.skip(1)) {
      final name = row[0]?.value.toString() ?? "Unknown";

      final score = (row[1]?.value != null &&
          row[1]!.value.toString().isNotEmpty)
          ? int.tryParse(row[1]!.value.toString())
          : null;

      students.add(Student(name, score));
    }
  }

  return students;
}