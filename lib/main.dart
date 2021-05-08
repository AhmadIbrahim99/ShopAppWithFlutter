import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop/admin/add_category.dart';
import 'package:flutter_shop/admin/add_edit_product.dart';
import 'package:flutter_shop/admin/categories.dart';
import 'package:flutter_shop/admin/products.dart';
import 'package:flutter_shop/authentication/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlutterShop());
}

class FlutterShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthTest(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        dividerTheme: DividerThemeData(
          space: 25,
          thickness: 10,
          color: Colors.black12,
          indent: 20,
          endIndent: 20
        ),
      ),
      routes: {
        "/add_category"  : (context) => AddCategory(),
        "/add_product"  : (context) => AddEditProduct(),
        "/all_products"  : (context) => AllProducts(),
        "/all_categories"  : (context) => AllCategories(),
      },
    );
  }
}

class AuthTest extends StatefulWidget {
  @override
  _AuthTestState createState() => _AuthTestState();
}

class _AuthTestState extends State<AuthTest> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  FireBaseAuthentication fireBaseAuthentication = FireBaseAuthentication();

  @override
  void initState() {
    // TODO: implement initState
    fireBaseAuthentication.getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Shop Drawer',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('Add Category'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/add_category");
              },
            ),
            ListTile(
              title: Text('Add Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,"/add_product");
              },
            ),
            ListTile(
              title: Text('All Categories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/all_categories");
              },
            ),
            ListTile(
              title: Text('All Products'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/all_products");
              },
            ),

          ],
        ),
      ),

    );

  }
}


/*return Scaffold(
      appBar: AppBar(
        title: Text("AuthTest"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register"),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _passWordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "PassWord",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String passWord = _passWordController.text;
                  var user =
                      await fireBaseAuthentication.register(email, passWord);
                  print(user);
                },
                child: Text("Register")),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
                onPressed: () async {
                  fireBaseAuthentication.signOut();
                },
                child: Text("SignOut")),
          ],
        ),
      ),
    );*/