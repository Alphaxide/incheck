import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:http/http.dart' as http;

class UploadProductPage extends StatefulWidget {
  @override
  _UploadProductPageState createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController flavourController = TextEditingController();
  TextEditingController ratingsController = TextEditingController();
  bool onOffer = false;
  File? _image;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadProduct() async {
    if (!_formKey.currentState!.validate()) return;

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:3000/api/products'));

    request.fields['productName'] = nameController.text;
    request.fields['price'] = priceController.text;
    request.fields['category'] = categoryController.text;
    request.fields['flavour'] = flavourController.text;
    request.fields['onOffer'] = onOffer.toString();
    request.fields['ratings'] = ratingsController.text;

    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    var response = await request.send();
    if (response.statusCode == 201) {
      print("Product uploaded successfully");
      // Handle success response
    } else {
      print("Failed to upload product");
      // Handle error response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Product")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter product name' : null,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter product price' : null,
              ),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Enter category' : null,
              ),
              TextFormField(
                controller: flavourController,
                decoration: InputDecoration(labelText: 'Flavour'),
                validator: (value) => value!.isEmpty ? 'Enter flavour' : null,
              ),
              TextFormField(
                controller: ratingsController,
                decoration: InputDecoration(labelText: 'Ratings'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter ratings' : null,
              ),
              SwitchListTile(
                title: Text("On Offer"),
                value: onOffer,
                onChanged: (value) {
                  setState(() {
                    onOffer = value;
                  });
                },
              ),
              _image == null
                  ? Text("No image selected")
                  : Image.file(_image!, height: 100),
              ElevatedButton(
                onPressed: pickImage,
                child: Text("Pick Image"),
              ),
              ElevatedButton(
                onPressed: uploadProduct,
                child: Text("Upload Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
