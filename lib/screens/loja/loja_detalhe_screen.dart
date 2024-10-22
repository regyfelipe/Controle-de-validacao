import 'package:flutter/material.dart';

import '../../routes/route.dart';

class LojaDetalheScreen extends StatelessWidget {
  final String nomeLoja;

  LojaDetalheScreen({required this.nomeLoja});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nomeLoja,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Não há produtos para mostrar...'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.add);

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
