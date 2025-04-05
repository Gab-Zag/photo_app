import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo App'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: checkValue,
                  onChanged: (bool? value) {
                    setState(() {
                      checkValue = value ?? true;
                    });
                  },
                ),
                Text('Texte 1')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
