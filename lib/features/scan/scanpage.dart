import 'package:flutter/material.dart';



class ScanPage extends StatefulWidget {
  const ScanPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ScanPage> createState() => _MyScanPageState();
}

class _MyScanPageState extends State<ScanPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyScanPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Product Scan pressed');
                  },
                  child: const Text(
                    'Scan Product',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Scan Receipt pressed');
                  },
                  child: const Text(
                    'Scan Receipt',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Custom Product pressed');
                  },
                  child: const Text(
                    'Custom Product',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),

    );
  }
}