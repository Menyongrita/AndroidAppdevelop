import 'package:flutter/material.dart';
import 'student.dart'; // 👈 adjust if your file name is different

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Future<List<Student>> students;

  @override
  void initState() {
    super.initState();
    students = readStudentsFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Grades")),
      body: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data ?? [];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final student = data[index];
              return ListTile(
                title: Text(student.name),
                subtitle: Text(student.formattedResult),
              );
            },
          );
        },
      ),
    );
  }
}