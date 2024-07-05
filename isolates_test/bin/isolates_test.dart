import 'dart:isolate';

import 'package:isolates_test/isolates_test.dart';

// void main(List<String> arguments) async {
//   final receivePort =
//       ReceivePort(); // сздаю порт main isolate для обратной связи
//   final isolate = await Isolate.spawn(funcNeedToDo,
//       receivePort.sendPort); // Выполнит function и вернет данные по sendPort
//   receivePort.listen((message) {
//     // подписываюсь на сообщения приходящие на receivePort
//     print('Message: $message');
//     receivePort.close(); // закрыл порт
//     isolate.kill(); // убил изолят
//   });
// }

// void funcNeedToDo(SendPort sendPort) {
//   var result = 0;
//   for (var i = 1; i <= 5000000000; i++) {
//     result = i;
//   }
//   sendPort.send(result);
// }

void main() async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(fun, receivePort.sendPort);

  receivePort.listen((message) {
    if (message is SendPort) {
      message.send('Take a message');
    }
    if (message is String) {
      print('Main Isolate: $message');

      if (message == 'close') {
        print('Close me I tired');
        receivePort.close();
        isolate.kill();
      }
    }
  });
}

void fun(SendPort sendPort) async {
  final port = ReceivePort();
  var result = 0;
  for (var i = 1; i <= 5000000000; i++) {
    result = i;
  }
  sendPort.send(result.toString());
  sendPort.send(port.sendPort);

  Future.delayed(Duration(seconds: 5), () {
    print("DELAYED");
    sendPort.send('close');
  });

  port.listen((message) {
    print('Isolate: $message');
  });
}
