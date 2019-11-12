import 'package:flutter/material.dart';

// My imports

import 'package:shop_app/components/Cart_products.dart';

class Shopping_cart extends StatefulWidget {
  @override
  _Shopping_cartState createState() => _Shopping_cartState();
}

class _Shopping_cartState extends State<Shopping_cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text("Shopping Cart"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: new Cart_products(),

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new ListTile(
                title: new Text("Total:"),
                subtitle: new Text("\k\s\h\ \ 2500"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: new Text(
                  "Buy",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
