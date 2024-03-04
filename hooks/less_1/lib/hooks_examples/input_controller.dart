import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InputController extends HookWidget {
  const InputController({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState('');

    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('Input controller')),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text("Value is: ${text.value}"),
        ],
      ),
    ));
  }
}
