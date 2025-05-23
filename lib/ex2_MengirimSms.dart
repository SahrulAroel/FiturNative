import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Send SMS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Send SMS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  String _message = "";

  void _sendSMS(List<String> numbers, String message) async {
    try {
      String result = await sendSMS(message: message, recipients: numbers);
      setState(() => _message = result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _numController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Masukan nomor handphone',
                ),
              ),
              const SizedBox(height: 30.0),
              TextField(
                controller: _msgController,
                maxLines: 5,
                decoration: const InputDecoration(hintText: 'Pesan SMS'),
              ),
              const SizedBox(height: 30.0),
              Text(_message),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Kirim SMS",
        child: const Icon(Icons.sms),
        onPressed: () {
          List<String> numbers = [_numController.text];
          _sendSMS(numbers, _msgController.text);
        },
      ),
    );
  }
}
