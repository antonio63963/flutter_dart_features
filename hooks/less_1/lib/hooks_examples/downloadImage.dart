import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://bit.ly/3qYOtDm';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

class DownloadImage extends HookWidget {
  const DownloadImage({super.key});

  @override
  Widget build(BuildContext context) {
    final image = useMemoized(
      () => NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((value) => value.buffer.asUint8List())
          .then(
            (value) => Image.memory(value),
          ),
    );
    final snapshot = useFuture(image);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Download Image'),
      ),
      body: Column(
        children: [snapshot.data].compactMap().toList(),
      ),
    ));
  }
}
