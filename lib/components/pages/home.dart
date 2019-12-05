import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//Personal Imports
import 'package:ecommerce_app/components/horizontal_listview.dart';
import 'package:ecommerce_app/components/Products.dart';
import 'package:ecommerce_app/components/pages/Cart.dart';
import 'package:ecommerce_app/components/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
bool loading = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("images/products/blazer1.jpeg"),
          AssetImage("images/products/blazer2.jpeg"),
          AssetImage("images/products/dress1.jpeg"),
          AssetImage("images/products/dress2.jpeg"),
          AssetImage("images/products/hills1.jpeg"),
          AssetImage("images/products/hills2.jpeg"),
          AssetImage("images/products/pants1.jpg"),
          AssetImage("images/products/pants2.jpeg"),
          AssetImage("images/products/shoe1.jpg"),
          AssetImage("images/products/skt1.jpeg"),
          AssetImage("images/products/skt2.jpeg"),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text("Net Shop"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
          new IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new Shopping_cart(),
                ),
              );
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            //Header
            new UserAccountsDrawerHeader(
              accountName: Text("Collins Murakayo"),
              accountEmail: Text("cmurakayo@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.red,
              ),
            ),

            //body

            InkWell(
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("My Account"),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("My Orders"),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("Shopping cart"),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new Shopping_cart(),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("Favorites"),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ),

            Divider(),

            InkWell(
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(
                  Icons.settings,
                ),
                onTap: () {},
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("About"),
                leading: Icon(
                  Icons.help,
                ),
                onTap: () {},
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("Log out"),
                leading: Icon(
                  Icons.exit_to_app,
                ),
                onTap: () {
                  signOut();
                },
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          //========Image carousel begins here============
          //image_carousel,

          //Padding widget
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text("Categories"),
            ),
          ),

          //Horizontal ListView

          HorizontalList(),

          //Padding Widget
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text("Recent Products"),
            ),
          ),

          //Grid View
          Flexible(
            child: Products(),
          ),
        ],
      ),
    );
  }

  void isSignedOut({bool isLoggedOut: false}) async {
    setState(() {
      loading = false;
    });

    if (isLoggedOut) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new Login(),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> signOut() async {
    isSignedOut(isLoggedOut: true);
    return firebaseAuth.signOut();
  }
}
