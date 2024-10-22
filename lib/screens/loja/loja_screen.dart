import 'package:flutter/material.dart';
import '../../service/api_service.dart';
import 'loja_detalhe_screen.dart';

class Loja {
  final int id;
  final String nome;

  Loja({required this.id, required this.nome});
}

class LojaScreen extends StatefulWidget {
  @override
  _LojaScreenState createState() => _LojaScreenState();
}

class _LojaScreenState extends State<LojaScreen> {
  final List<Loja> _lojas = [];
  final TextEditingController _lojaController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _carregarLojas();
  }

  void _carregarLojas() async {
    try {
      final lojas = await apiService.getLojas();
      setState(() {
        _lojas.clear();
        _lojas.addAll(lojas
            .map((cat) => Loja(id: cat['id'], nome: cat['nome']))
            .toList());
      });
    } catch (e) {
    }
  }

  void _adicionarLoja() async {
    String novaLoja = _lojaController.text.trim();
    if (novaLoja.isNotEmpty) {
      await apiService.addLoja(novaLoja);
      _lojaController.clear();
      _carregarLojas();
      _mostrarMensagem('Loja adicionada com sucesso!');
    }
  }

  void _navegarParaDetalhes(Loja loja) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LojaDetalheScreen(nomeLoja: loja.nome),
      ),
    );
  }

  void _exibirModalOpcoes(Loja loja) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Escolha uma opção'),
        content: Text('Você deseja editar ou excluir a loja "${loja.nome}"?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              _editarLoja(loja); 
            },
            child: Text('Editar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              _excluirLoja(loja.id); 
            },
            child: Text('Excluir'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('Cancelar'),
          ),
        ],
      );
    },
  );
}


 void _editarLoja(Loja loja) {
  String nomeAntigo = loja.nome; 
  String novoNome = nomeAntigo; 

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Loja'),
        content: TextField(
          onChanged: (value) {
            novoNome = value; 
          },
          controller: TextEditingController(text: nomeAntigo), 
          decoration: InputDecoration(
            labelText: 'Nome da Loja',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (novoNome.isNotEmpty) {
                await apiService.editLoja(loja.id, novoNome); 
                _carregarLojas(); 
                _mostrarMensagem('Loja editada com sucesso!'); 
                Navigator.of(context).pop(); 
              } else {
                _mostrarMensagem('O nome da loja não pode estar vazio!'); 
              }
            },
            child: Text('Salvar'),
          ),
        ],
      );
    },
  );
}


  void _excluirLoja(int id) async {
    await apiService.deleteLoja(id);
    _carregarLojas();
    _mostrarMensagem('Loja excluída com sucesso!');
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lojas', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _lojaController,
              decoration: InputDecoration(
                labelText: 'Nome da Loja',
                hintText: 'Digite uma nova Loja...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _adicionarLoja,
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lojas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _lojas.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    elevation: 2,
                    child: ListTile(
                      title: Text(_lojas[index].nome),
                      leading:
                          Icon(Icons.category, color: Colors.deepPurpleAccent),
                      onTap: () => _navegarParaDetalhes(_lojas[index]),
                      onLongPress: () => _exibirModalOpcoes(_lojas[index]),
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
