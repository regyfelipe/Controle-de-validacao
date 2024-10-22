import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import 'widgets/filter_bar.dart';
import 'widgets/product_card.dart';
import '../../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> produtos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProdutos();
  }

  Future<void> _fetchProdutos() async {
    ApiService apiService = ApiService();
    try {
      final List<dynamic> data = await apiService.getProdutos();
      setState(() {
        produtos = data;
        isLoading = false;
      });
    } catch (error) {
      print('Erro ao carregar produtos: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        userName: 'Regy Robson',
        avatarUrl: 'https://example.com/avatar.png',
      ),
      body: Column(
        children: [
          FilterBar(),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      final produto = produtos[index];
                      return ProductCard(
                        imageUrl: produto['imagem'] ?? 'https://example.com/default.png', 
                        productName: produto['nome'],
                        quantity: produto['quantidade'],
                        creationDate: produto['created_at'],
                        expiryDate: produto['data_vencimento'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
