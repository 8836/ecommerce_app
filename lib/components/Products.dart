import 'package:flutter/material.dart';
import 'package:shop_app/components/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Men's blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 1200,
      "price": 850,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 1000,
      "price": 500,
    },
    {
      "name": "Ladies' blazer",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 800,
      "price": 550,
    },
    {
      "name": "Black dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": 500,
      "price": 350,
    },
    {
      "name": "Brown heels",
      "picture": "images/products/hills1.jpeg",
      "old_price": 750,
      "price": 650,
    },
    {
      "name": "Red heels",
      "picture": "images/products/hills2.jpeg",
      "old_price": 800,
      "price": 700,
    },
    {
      "name": "Jumpsuit",
      "picture": "images/products/pants1.jpg",
      "old_price": 1000,
      "price": 850,
    },
    {
      "name": "Yoga Pants",
      "picture": "images/products/pants2.jpeg",
      "old_price": 1000,
      "price": 900,
    },
    {
      "name": "Shoes",
      "picture": "images/products/shoe1.jpg",
      "old_price": 1500,
      "price": 1200,
    },
    {
      "name": "Flowery skirt",
      "picture": "images/products/skt1.jpeg",
      "old_price": 600,
      "price": 450,
    },
    {
      "name": "Pink skirt",
      "picture": "images/products/skt2.jpeg",
      "old_price": 700,
      "price": 600,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]["name"],
              prod_picture: product_list[index]["picture"],
              prod_old_price: product_list[index]["old_price"],
              prod_price: product_list[index]["price"],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                // passing product values to the new routed product page
                builder: (context) => ProductDetails(
                  product_detail_name: prod_name,
                  product_detail_new_price: prod_price,
                  product_detail_old_price: prod_old_price,
                  product_detail_picture: prod_picture,
                ),
              ),
            ),
            child: GridTile(
              footer: Container(
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text(
                        prod_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    new Text(
                      "\k\s\h\ $prod_price",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
