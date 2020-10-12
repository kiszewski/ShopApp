import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product_model.dart';
import 'package:shopApp/models/products_model.dart';

class ProductFormPage extends StatefulWidget {
  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  File _image;

  Future _getImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    var pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductsModel productsModel = Provider.of<ProductsModel>(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            productsModel.addProduct(ProductModel(
              description: _descriptionController.text,
              name: _nameController.text,
              price: double.tryParse(_priceController.text) ?? 0.0,
              imageUrl: _image,
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
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                      labelText: 'Descrição*',
                      hintText: 'Digite a descrição do produto'),
                  validator: (String value) {
                    return value.isEmpty ? 'Digite algo' : null;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: _getImage,
                ),
                _image != null
                    ? Image.file(
                        _image,
                        width: 100,
                      )
                    : Text('')
              ],
            )),
      ),
    );
  }
}
