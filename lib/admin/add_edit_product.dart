import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class AddEditProduct extends StatefulWidget {
  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {

  final _formKey=GlobalKey<FormState>();
  File _image;
  final picker=ImagePicker();

  String imageUrl;

  TextEditingController _productTitle=TextEditingController();
  TextEditingController _productDescription=TextEditingController();
  TextEditingController _productPrice=TextEditingController();
  String hintText="Select Category";
  String selectedValueCategory;


  bool isLoading=false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productPrice.dispose();
    _productDescription.dispose();
    _productTitle.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("New Product Or Edit"),
        centerTitle: true,
      ),
      body: ( isLoading )?_loading() : _addProduct(),
    );
  }

  Widget _addProduct(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productTitle,
                decoration: InputDecoration(
                  hintText: "Product Title",
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Title Is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _productDescription,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Product Description",
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Title Is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _productPrice,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: "Price",
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Title Is Required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
              SizedBox(
                  width: double.infinity,
                  child: _selectCategory()),
              SizedBox(height: 16,),
              (_image==null)?Text("No Image Selected",textAlign: TextAlign.center,):Image.file(_image),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: (){
                getImage();
              }, child: Text("Select Image")),
              SizedBox(height: 32,),
              ElevatedButton(onPressed: (){
                if(_formKey.currentState.validate()){
                  setState(() {
                    isLoading=true;
                  });

                  upload(_productTitle.text);

                  FirebaseFirestore.instance.collection("products").doc()
                      .set({
                    "product_title" : _productTitle.text,
                    "product_description" : _productDescription.text,
                    "product_price" : _productPrice.text,
                    "category_title" : selectedValueCategory,
                    "product_image" : imageUrl,
                  }).then((value) async {
                    setState(() {
                      isLoading=false;
                    });
                    _productPrice.text="";
                    _productDescription.text="";
                    _productTitle.text="";
                    selectedValueCategory=null;
                    _image=null;
                  });
                }
              },
                child: Text("Save Product",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _loading(){
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _selectCategory() {
     return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if(snapshot.data.docs.isEmpty){
            return Container(
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Data",style: TextStyle(fontSize: 16),),
                  SizedBox(width: 34,),
                  Icon(Icons.hourglass_empty_outlined,size: 16,),
                ],
              ),),
            );
          }
          return DropdownButton<String>(
            value: selectedValueCategory,
            hint: Text(hintText),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down,color: Colors.teal,),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (String newValue) {
              setState(() {
                selectedValueCategory= newValue;
              });
            },
            items:snapshot.data.docs.map((DocumentSnapshot document){
              return DropdownMenuItem<String>(
                value: document['title'],
                child:  Text(document['title']),
              );
            }).toList(),
          );

        }
    );

    }


  Future upload(String name)async{
    var file=File(_image.path);
    if(_image!=null){
      var snapshot= await firebase_storage.FirebaseStorage.instance.ref().child("images/$name").putFile(file).whenComplete(() => null);

      setState(() async {
        var downloadUrl= await snapshot.ref.getDownloadURL();
        imageUrl=downloadUrl;
      });
    }else{

    }

  }

}
