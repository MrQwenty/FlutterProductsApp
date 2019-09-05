//Add this package to debug UI rendering issues
// import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:starter_app/pages/auth.dart';
import 'pages/product.dart';
import 'pages/products.dart';
import 'pages/products_admin.dart';

main(List<String> args) {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];
  bool isFirstLoad;
  @override
  void initState() {
    isFirstLoad = true;
    super.initState();
  }

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() {
      _products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.deepPurple,
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          buttonColor: Colors.deepPurple),
      // home: AuthPage(), //because we have a default route "/"
      routes: {
        "/": (BuildContext context) {
          if (isFirstLoad == true) {
            isFirstLoad = false;
            return AuthPage();
          }
          return ProductsPage(_products);
        },
        "/auth": (BuildContext context) => AuthPage(),
        "/admin": (BuildContext context) => ProductsAdminPage(
            _products, _addProduct, _updateProduct, _deleteProduct)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;
        if (pathElements[1] == 'product') {
          final int productIndex = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductPage(_products[productIndex]));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },
    );
  }
}
