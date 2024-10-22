import 'package:flutter/material.dart';

import '../../routes/route.dart';

class MarcaDetalheScreen extends StatelessWidget {
  final String nomeMarca;

  MarcaDetalheScreen({required this.nomeMarca});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nomeMarca,
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
