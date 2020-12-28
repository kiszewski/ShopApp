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

  Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'price': TextEditingController(),
    'description': TextEditingController(),
    'imageUrl': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel _productViewModel =
        Provider.of<ProductsViewModel>(context);
    final ProductModel product = ModalRoute.of(context).settings.arguments;

    _controllers['name'].text = product?.name;
    _controllers['price'].text = product?.price?.toString();
    _controllers['description'].text = product?.description;
    _controllers['imageUrl'].text = product?.imageUrl;

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
            if (_formKey.currentState.validate()) {
              _productViewModel.saveProduct(product, _controllers);
            }
            Navigator.of(context).pop();
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controllers['name'],
                  decoration: InputDecoration(
                      labelText: 'Nome*', hintText: 'Digite o nome do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                TextFormField(
                  controller: _controllers['price'],
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                  ],
                  decoration: InputDecoration(
                      labelText: 'Preço*',
                      hintText: 'Digite o preço do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                TextFormField(
                  controller: _controllers['description'],
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Descrição*',
                      hintText: 'Digite a descrição do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                TextFormField(
                  controller: _controllers['imageUrl'],
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
