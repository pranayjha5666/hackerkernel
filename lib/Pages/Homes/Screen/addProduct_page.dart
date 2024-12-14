import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/product_model.dart';

class AddProductPage extends StatefulWidget {
  final List<Product> productList;
  AddProductPage(this.productList);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? imagePath;

  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void addProduct() {
    if (_formKey.currentState!.validate()) {
      bool isDuplicate = widget.productList.any((product) =>
      product.name.trim().toLowerCase() == nameController.text.trim().toLowerCase());
      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product already exists')),
        );
        return;
      }

      setState(() {
        widget.productList.add(Product(
          name: nameController.text.trim(),
          price: double.parse(priceController.text),
          imagePath: imagePath,
        ));
      });

      saveProducts();
      Navigator.pop(context, true);
    }
  }

  void saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('products', jsonEncode(widget.productList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  imagePath != null
                      ? Image.file(File(imagePath!),
                      width: 100, height: 100, fit: BoxFit.cover)
                      : Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 50),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Pick Image'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/
