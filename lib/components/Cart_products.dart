import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Men's blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 850,
      "size": "M",
      "color": "Black",
      "quantity": 1,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress1.jpeg",
      "price": 500,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Shoes",
      "picture": "images/products/shoe1.jpg",
      "price": 1200,
      "size": "6",
      "color": "Gray",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Products_on_the_cart[index]["name"],
            cart_prod_picture: Products_on_the_cart[index]["picture"],
            cart_prod_price: Products_on_the_cart[index]["price"],
            cart_prod_size: Products_on_the_cart[index]["size"],
            cart_prod_color: Products_on_the_cart[index]["color"],
            cart_prod_quantity: Products_on_the_cart[index]["quantity"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_quantity;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // ====================== LEADING ============================
        leading: new Image.asset(
          cart_prod_picture,
          width: 80.0,
          height: 80.0,
        ),

        // ======================== TITLE =============================
        title: new Text(cart_prod_name),

        // ======================= SUBTITLE =============================
        subtitle: new Column(
          children: <Widget>[
            //PUTTING A ROW INSIDE A COLUMN

            new Row(
              children: <Widget>[
                // ======================== Product Size ======================
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cart_prod_size,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                // ======================== Product Color ======================

                new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: new Text("Color:"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cart_prod_color,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                // REFER TO THE *PRODUCT DETAILS* SECTION TO SEE THE PRODUCT COUNT
                // ===== THIS SECTION ONLY SHOWS THE *PRODUCT QUANTITY* ========

                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 4.0, 4.0, 4.0),
                  child: new Text("Qty:"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    "$cart_prod_quantity",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),

            //=============== THE PRODUCT PRICE SECTION ========================

            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\k\s\h\ ${cart_prod_price}",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
