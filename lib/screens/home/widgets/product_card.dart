import 'dart:convert'; 
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final int quantity;
  final String creationDate; 
  final String expiryDate;   

  const ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.quantity,
    required this.creationDate,
    required this.expiryDate,
  });

  // Função para formatar a data
  String formatarData(String data) {
    DateTime dataTime = DateTime.parse(data); 
    return DateFormat('dd/MM/yyyy').format(dataTime); 
  }

  @override
  Widget build(BuildContext context) {
    final String base64String = imageUrl.split(',').last; 
    final Uint8List bytes = base64.decode(base64String); 

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(
              bytes,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Quantidade: $quantity'),
                  SizedBox(height: 8.0),
                  Text('criado: ${formatarData(creationDate)}'),
                  SizedBox(height: 8.0),
                  Text('vencimento: ${formatarData(expiryDate)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
