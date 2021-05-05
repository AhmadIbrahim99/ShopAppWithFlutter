import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _categoryTitle = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Category"),
        centerTitle: true,
      ),
      body: (isLoading) ? _loading() : _categoryForm(),
    );
  }

  Widget _categoryForm() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _categoryTitle,
                decoration: InputDecoration(
                  hintText: "Product Title",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Title Is Required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true;
                    });

                    //search value
                    var response = await FirebaseFirestore.instance
                        .collection("categories")
                        .where('title', isEqualTo: _categoryTitle.text.trim())
                        .snapshots()
                        .first;

                    if (response.docs.length >= 1) {
                      Fluttertoast.showToast(
                          msg: "This Category Is Already Exist",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      FirebaseFirestore.instance
                          .collection("categories")
                          .doc()
                          .set({
                        "title": _categoryTitle.text,
                      }).then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        _categoryTitle.text = "";
                      });
                    }
                  }
                },
                child: Text(
                  "Save Category",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
