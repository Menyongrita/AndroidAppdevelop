import 'package:flutter_test/flutter_test.dart';
import 'package:student_grade_calculator/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentApp());
    expect(find.text('Student Grades'), findsOneWidget);
  });
}