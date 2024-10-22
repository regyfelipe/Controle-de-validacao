import 'package:flutter/material.dart';
import '../../service/api_service.dart';
import 'Marca_detalhe_screen.dart';

class MarcaScreen extends StatefulWidget {
  @override
  _MarcaScreenState createState() => _MarcaScreenState();
}

class _MarcaScreenState extends State<MarcaScreen> {
  final List<String> _Marcas = [];
  final TextEditingController _MarcaController = TextEditingController();
  final ApiService apiService = ApiService(); 

  @override
  void initState() {
    super.initState();
    _carregarMarcas(); 
  }

  void _carregarMarcas() async {
    try {
      final Marcas = await apiService.getMarcas();
      setState(() {
        _Marcas.addAll(Marcas.map((cat) => cat['nome'] as String).toList());
      });
    } catch (e) {
      // Tratar erro
    }
  }

  void _adicionarMarca() async {
    String novaMarca = _MarcaController.text.trim();
    if (novaMarca.isNotEmpty) {
      await apiService.addMarca(novaMarca);
      _MarcaController.clear();
      _carregarMarcas(); 
    }
  }

  void _navegarParaDetalhes(String Marca) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarcaDetalheScreen(nomeMarca: Marca),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _MarcaController,
              decoration: InputDecoration(
                labelText: 'Nome da Marca',
                hintText: 'Digite uma nova Marca...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _adicionarMarca,
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Marcas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _Marcas.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    elevation: 2,
                    child: ListTile(
                      title: Text(_Marcas[index]),
                      leading: Icon(Icons.category, color: Colors.deepPurpleAccent),
                      onTap: () => _navegarParaDetalhes(_Marcas[index]),
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
