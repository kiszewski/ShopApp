import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/viewmodels/products_viewmodel.dart';

class ProductFormPage extends StatefulWidget {
  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrl = TextEditingController();

  _saveProduct(ProductModel product, ProductsViewModel productsViewModel) {
    if (_formKey.currentState.validate()) {
      if (product == null) {
        productsViewModel.addProduct(ProductModel(
          _nameController.text,
          _imageUrl.text,
          double.tryParse(_priceController.text) ?? 0.0,
          _descriptionController.text,
        ));
      } else {
        productsViewModel.updateProduct(
          product,
          _nameController.text,
          _imageUrl.text,
          double.tryParse(_priceController.text) ?? 0.0,
          _descriptionController.text,
        );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsViewModel =
        Provider.of<ProductsViewModel>(context);
    final ProductModel product = ModalRoute.of(context).settings.arguments;

    _nameController.text = product?.name;
    _priceController.text = product?.price?.toString();
    _descriptionController.text = product?.description;
    _imageUrl.text = product?.imageUrl;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text(
          'Criar Produto',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.check),
          onPressed: () {
            _saveProduct(product, productsViewModel);
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Nome*', hintText: 'Digite o nome do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      labelText: 'Preço*',
                      hintText: 'Digite o preço do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Descrição*',
                      hintText: 'Digite a descrição do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                TextFormField(
                  controller: _imageUrl,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                      labelText: 'Link da imagem*',
                      hintText: 'Coloque o link da imagem aqui'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
              ],
            )),
      ),
    );
  }
}
