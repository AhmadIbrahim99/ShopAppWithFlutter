import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    CollectionReference product = FirebaseFirestore.instance.collection('products');

    return Scaffold(
      appBar: AppBar(
        title: Text("My Products"),
        centerTitle: true,
      ),
      body: _drawProduct(product),
    );
  }

  Widget _drawProduct(CollectionReference product){
    return StreamBuilder<QuerySnapshot>(
      stream: product.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if(snapshot.hasData){
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: Container(
                  child: Column(
                    children: [
                      new ListTile(
                        title: new Text(document.data()['product_title']),
                        subtitle: new Text(document.data()['product_price']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,color: Colors.red,),
                          onPressed: (){
                            product.doc(document.id).delete();
                          },
                        ),

                      ),
                      new Text(document.data()['product_description']),
                      Padding(
                        padding: const EdgeInsets.only(top:16.0),
                        child: new Text(document.data()['category_title']),
                      ),
                      SizedBox(height: 16,),
                      Image.network(document.data()['product_image'].toString()),
                      Divider()
                    ],
                  ),

                ),
              );
            }).toList(),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Data",style: TextStyle(fontSize: 24),),
              SizedBox(width: 34,),
              Icon(Icons.hourglass_empty_outlined,size: 32,),
            ],
          ),),
        );

      },
    );
  }
}
