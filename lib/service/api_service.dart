import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.18.11:3000';

  Future<List<dynamic>> getCategorias() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar categorias');
    }
  }

  Future<List<dynamic>> getMarcas() async {
    final response = await http.get(Uri.parse('$baseUrl/marcas'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar Marcas');
    }
  }
  
  Future<List<dynamic>> getLojas() async {
    final response = await http.get(Uri.parse('$baseUrl/lojas'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar Lojas');
    }
  }

  Future<void> addCategoria(String nome) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categorias'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'nome': nome}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar categoria');
    }
  }

  Future<void> addMarca(String nome) async {
    final response = await http.post(
      Uri.parse('$baseUrl/marcas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'nome': nome}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar Marca');
    }
  }
  Future<void> addLoja(String nome) async {
    final response = await http.post(
      Uri.parse('$baseUrl/lojas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'nome': nome}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar Loja');
    }
  }

  Future<http.Response> addProduct(Map<String, dynamic> productData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produtos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(productData),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar produto: ${response.body}');
    }

    return response;
  }

  Future<List<dynamic>> getProdutos() async {
    final response = await http.get(Uri.parse('$baseUrl/produtos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }


  // ------------------delete e edit --------------------

   Future<void> editLoja(int id, String nome) async {
    final response = await http.put(
      Uri.parse('$baseUrl/lojas/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'nome': nome}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao editar Loja');
    }
  }

  Future<void> deleteLoja(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/lojas/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir Loja');
    }
  }
}
