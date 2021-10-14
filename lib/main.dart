import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Division and Remainder'),
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
  late TextEditingController controller1;
  late TextEditingController controller2;
  int? _quotient, _remainder;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
  }

  void _calculate() {
    if (controller1.value.text.trim() == '' || controller2.value.text.trim() == '') {
      setState(() {
        _quotient = null;
        _remainder = null;
      });
      return;
    }
    int a = int.parse(controller1.value.text);
    int b = int.parse(controller2.value.text);
    setState(() {
      _quotient = (a / b).floor();
      _remainder = a.remainder(b);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 50,
                  child: TextField(
                    controller: controller1,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                const Text('divided by'),
                SizedBox(
                  height: 30,
                  width: 50,
                  child: TextField(
                    controller: controller2,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
              ],
            ),
            Text('Quotient: ${_quotient ?? ''}'),
            Text('Remainder: ${_remainder ?? ''}'),
            ElevatedButton(onPressed: _calculate, child: const Text('Calculate'))
          ],
        ),
      ),
    );
  }
}
