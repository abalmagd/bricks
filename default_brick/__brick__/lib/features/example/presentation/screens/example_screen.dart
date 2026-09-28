import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/features/example/presentation/providers/example_provider.dart';

class ExampleScreen extends HookConsumerWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examples = ref.watch(exampleProvider);

    useEffect(() {
      ref.read(exampleProvider.notifier).load();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: ListView.builder(
        itemCount: examples.length,
        itemBuilder: (context, index) {
          final example = examples[index];
          return ListTile(title: Text(example.title));
        },
      ),
    );
  }
}
