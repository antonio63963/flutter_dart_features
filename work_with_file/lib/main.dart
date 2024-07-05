import 'package:work_with_file/models/student_model.dart';
import './student.service.dart';

void main() async {
  const st1 = Student(
    name: 'Vasa',
    age: 22,
    single: true,
    description: ['Выпить', 'Покурить'],
  );

  await StudentService.ho();
  // await StudentService.setStudentJSON(st1);
  var studentFromFile = await StudentService.readStudentJSON();

  print('Student From File: $studentFromFile');
}
