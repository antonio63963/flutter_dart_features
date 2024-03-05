import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimerPage extends HookWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    useEffect(() {
      final _timer = Timer.periodic(
        const Duration(seconds: 1),
        (time) => count.value = time.tick,
      );
    }, const []);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text('Timer')),
            body: Center(
              child: Text(count.value.toString(), style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
            )));
  }
}
