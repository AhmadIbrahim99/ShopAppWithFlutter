import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    CollectionReference category = FirebaseFirestore.instance.collection('categories');

    return Scaffold(
      appBar: AppBar(
        title: Text("All categories"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _allCategories(category),
      ),
    );
  }

  Widget _allCategories(CollectionReference category){
    return StreamBuilder(
      stream: category.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
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
                Text("No Data",style: TextStyle(fontSize: 24),),
                SizedBox(width: 34,),
                Icon(Icons.hourglass_empty_outlined,size: 32,),
              ],
            ),),
          );
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['title']),
              trailing: IconButton(
                icon: Icon(Icons.delete,color: Colors.red,),
                onPressed: (){
                  category.doc(document.id).delete();
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
