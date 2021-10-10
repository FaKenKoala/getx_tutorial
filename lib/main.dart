import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
// import 'package:nested_route_package/nested_route_package.dart' as nested_route;
import 'nested_main.dart' as nested_main;

// what
class EnvironmentConfig {
  static const nestedRoute =
      bool.fromEnvironment('nested_route', defaultValue: false);
}

void main() {
  if (EnvironmentConfig.nestedRoute) {
    nested_main.main();
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const MyHomePage2(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text('Clicks: ${c.count}'))),
      body: Center(
        child: ElevatedButton(
            child: const Text('Go to Other'),
            onPressed: () => Get.to(const Other())),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: c.increament,
      ),
    );
  }
}

class Other extends StatelessWidget {
  const Other({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other'),
      ),
      body: Center(
        child: Text('${c.count}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.backpack),
        onPressed: () async {
          // Get.offAll(const Three());
          var result = await Get.to(const Three());
          print('Three return result: $result');
        },
      ),
    );
  }
}

class Three extends StatelessWidget {
  const Three({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Three'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.backpack),
        onPressed: () {
          Get.back(result: 'good');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CounterController extends GetxController {
  var count = 0.obs;
  increament() => count++;
}

abstract class One {}

class OneImpl extends One {}

extension OneExtension on One {}

final OneGet = OneImpl();
void test() {
  // OneExtension(OneGet);
}
