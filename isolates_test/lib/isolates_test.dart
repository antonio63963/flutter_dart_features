import 'dart:isolate';

class IsolatesMessage<T> {
  final SendPort sender;
  final T message;

  IsolatesMessage({
    required this.sender,
    required this.message,
  });
}

class IsolateController {
  final Isolate isolate;
  SendPort sendPort;

  IsolateController({required this.isolate, required this.sendPort});

  // Future<String> send(String message) async{
  //   final port = ReceivePort();
  //   sendPort = port.sendPort;
  //   sendPort.send(IsolatesMessage(sender: port.sendPort, message: message));
  //   return await port.first;
  // }
}

// Future<IsolateController> createIsolateController(
//   dynamic Function(SendPort) entryPoint,
//   SendPort sendPort,
// ) async {
//   var isolate = await Isolate.spawn(entryPoint, sendPort);
//   var isolateSendPort = await receivePort.first;

//   return IsolateController(isolate: isolate, sendPort: isolateSendPort);
// }

// Future<String> sendReceive(String message, SendPort sendPort) async {
//   final port = ReceivePort(); //
//   sendPort.send(IsolatesMessage(sender: port.sendPort, message: message));
//   return await port.first;
// }
