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

  @override
  Widget build(BuildContext context) {
    ProductsViewModel productsModel = Provider.of<ProductsViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            productsModel.addProduct(ProductModel(
              _nameController.text,
              _imageUrl.text,
              double.tryParse(_priceController.text) ?? 0.0,
              _descriptionController.text,
            ));

            Navigator.popAndPushNamed(context, '/').then((_) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
            });
          }
        },
      ),
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
