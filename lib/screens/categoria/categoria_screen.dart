import 'package:flutter/material.dart';
import '../../service/api_service.dart';
import 'categoria_detalhe_screen.dart';

class CategoriaScreen extends StatefulWidget {
  @override
  _CategoriaScreenState createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final List<String> _categorias = [];
  final TextEditingController _categoriaController = TextEditingController();
  final ApiService apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
    _carregarCategorias(); 
  }

  void _carregarCategorias() async {
    try {
      final categorias = await apiService.getCategorias();
      setState(() {
        _categorias.addAll(categorias.map((cat) => cat['nome'] as String).toList());
      });
    } catch (e) {
      // Tratar erro
    }
  }

  void _adicionarCategoria() async {
    String novaCategoria = _categoriaController.text.trim();
    if (novaCategoria.isNotEmpty) {
      await apiService.addCategoria(novaCategoria);
      _categoriaController.clear();
      _carregarCategorias(); 
    }
  }

  void _navegarParaDetalhes(String categoria) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriaDetalheScreen(nomeCategoria: categoria),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(
                labelText: 'Nome da Categoria',
                hintText: 'Digite uma nova categoria...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _adicionarCategoria,
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Categorias:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _categorias.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    elevation: 2,
                    child: ListTile(
                      title: Text(_categorias[index]),
                      leading: Icon(Icons.category, color: Colors.deepPurpleAccent),
                      onTap: () => _navegarParaDetalhes(_categorias[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
