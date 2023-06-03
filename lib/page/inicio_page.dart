import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(
          "data",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
