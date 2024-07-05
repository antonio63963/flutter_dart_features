import 'dart:convert';
import 'dart:io';

import 'package:work_with_file/models/student_model.dart';

class StudentService {
  static const _encoder = JsonEncoder.withIndent('');
  static const _filePath = './lib/appConfig/studenFile.json';

  static ho() => print("HOHO+++");

  static Future<void> setStudentJSON(Student student) async {
    final studentFile = File(_filePath);
    if (!studentFile.existsSync()) {
      await studentFile.create(recursive: true);
    }
    await studentFile.writeAsString(_encoder.convert(student));
  }

  static Future<Student> readStudentJSON() async {
    final studentFile = File(_filePath);
    return await Student.fromJson(
      jsonDecode(
        await studentFile.readAsString(),
      ),
    );
  }
}
