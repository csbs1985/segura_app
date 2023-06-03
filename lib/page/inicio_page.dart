import 'package:flutter/material.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/widget/padrao_input.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 8,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: PadraoInput(
              callback: (value) => {print(value)},
              hintText: PESQUISAR,
              pesquisar: true,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "data",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
