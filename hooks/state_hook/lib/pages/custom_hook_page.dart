import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:state_hook/hooks/custom_timer_hook.dart';

class CustomHookPage extends HookWidget {
  const CustomHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final number = useInfiniteTimer();
    return Center(child: Text(number.toString()),);
  }
}
