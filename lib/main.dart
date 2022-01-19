import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isolated_worker/js_isolated_worker.dart';
import 'package:showing_isolated_worker/fib.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Web Isolates'),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  void onRunOnMainPressed(BuildContext context) {
    final fibonacci = fib(45);
    Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SecondScreen(
            data: fibonacci,
          ),
        ),);
  }

  void onRunOnIsolatePressed(BuildContext context) async {
    final loaded = await JsIsolatedWorker().importScripts(['worker.js']);
    if (loaded) {
      final data = await JsIsolatedWorker().run(
        functionName: 'fibonacci',
        arguments: 45,
      );
      log(data.runtimeType.toString());
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SecondScreen(
            data: data,
          ),
        ),
      );
    } else {
      log('Web worker not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Center(child: CircularProgressIndicator()),
          ElevatedButton(
            onPressed: () => onRunOnMainPressed(context),
            child: const Text('Run on Main Thread'),
          ),
          ElevatedButton(
            onPressed: () => onRunOnIsolatePressed(context),
            child: const Text('Run on Isolate'),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: HomeBody(),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, this.data}) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Center(
        child: Text(data.toString()),
      ),
    );
  }
}
