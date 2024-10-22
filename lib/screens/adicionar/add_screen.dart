import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../service/api_service.dart';
import 'components/date_selector.dart';
import 'components/dropdown_field.dart';
import 'components/text_field.dart';
import 'components/title_section.dart';
import 'utils/date_utils.dart';
import 'dart:convert';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedCategory;
  String? selectedBrand;
  String? selectedLoja;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _loteController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _diasVencimentoController =
      TextEditingController(); 

  List<String> categories = [];
  List<String> brands = [];
  List<String> lojas = []; 

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchMarcas();
    fetchLojas();
  }

  Future<void> fetchCategories() async {
    ApiService apiService = ApiService();
    try {
      final List<dynamic> data = await apiService.getCategorias();
      setState(() {
        categories = data.map((item) => item['nome'] as String).toList();
      });
      print("Categorias carregadas: $categories");
    } catch (error) {
      print("Erro ao carregar categorias: $error");
    }
  }

  Future<void> fetchMarcas() async {
    ApiService apiService = ApiService();
    try {
      final List<dynamic> data = await apiService.getMarcas();
      setState(() {
        brands = data.map((item) => item['nome'] as String).toList();
      });
      print("Marcas carregadas: $brands");
    } catch (error) {
      print("Erro ao carregar marcas: $error");
    }
  }

  Future<void> fetchLojas() async {
    ApiService apiService = ApiService();
    try {
      final List<dynamic> data = await apiService.getLojas();
      setState(() {
        lojas = data.map((item) => item['nome'] as String).toList(); 
      });
      print("Lojas carregadas: $lojas");
    } catch (error) {
      print("Erro ao carregar Lojas: $error");
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurpleAccent,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _adicionarProduto() async {
    ApiService apiService = ApiService();

    if (_nomeController.text.isEmpty ||
        _quantidadeController.text.isEmpty ||
        selectedDate == null) {
      print('Por favor, preencha todos os campos obrigatórios');
      return;
    }

    String? base64Image;
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    try {
      final response = await apiService.addProduct({
        'nome': _nomeController.text,
        'categoria_id': selectedCategory,
        'marca_id': selectedBrand,
        'loja_id': selectedLoja,
        'preco': double.tryParse(_precoController.text) ?? 0.0,
        'quantidade': int.tryParse(_quantidadeController.text) ?? 0,
        'lote': int.tryParse(_loteController.text) ?? 0,
        'data_vencimento': selectedDate.toIso8601String(),
        'imagem': base64Image,
      });

      print('Produto adicionado com sucesso: $response');
      _showSuccessDialog(); 
      _clearFields(); 
    } catch (error) {
      print('Erro ao adicionar produto: $error');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Produto adicionado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Função para limpar os campos
  void _clearFields() {
    _nomeController.clear();
    _loteController.clear();
    _quantidadeController.clear();
    _precoController.clear();
    _diasVencimentoController.clear();
    setState(() {
      selectedCategory = null;
      selectedBrand = null;
      selectedLoja = null;
      selectedDate = DateTime.now(); 
      _image = null; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSection(title: 'Informações do Produto'),
              SizedBox(height: 24),
              Center(
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Text('Nenhuma imagem selecionada'),
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt),
                      label: Text('Câmera'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: Icon(Icons.photo),
                      label: Text('Galeria'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                  label: 'Nome do produto',
                  icon: Icons.shopping_cart_outlined,
                  controller: _nomeController),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: CustomSimpleTextField(
                          label: 'Lote', controller: _loteController)),
                  SizedBox(width: 20),
                  Expanded(
                      child: CustomSimpleTextField(
                          label: 'Quantidade',
                          controller: _quantidadeController)),
                ],
              ),
              SizedBox(height: 20),
              CustomSimpleTextField(
                  label: 'Preço unitário', controller: _precoController),
              SizedBox(height: 20),
              CustomTextFieldArea(
                label:
                    'Quantos dias do vencimento o produto é considerado próximo a vencer?',
                hint: 'Ex: 10 dias',
                controller: _diasVencimentoController,
              ),
              SizedBox(height: 20),
              CustomDropdownField(
                label: 'Categoria',
                items: categories,
                selectedValue: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomDropdownField(
                label: 'Marca',
                items: brands,
                selectedValue: selectedBrand,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBrand = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomDropdownField(
                label: 'Loja',
                items: lojas,
                selectedValue: selectedLoja,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLoja = newValue;
                  });
                },
              ),
              SizedBox(height: 30),
              TitleSection(title: 'Data de Vencimento'),
              SizedBox(height: 10),
              DateSelector(
                  selectedDate: selectedDate, onSelectDate: _selectDate),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _adicionarProduto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Text('Adicionar Produto',
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
