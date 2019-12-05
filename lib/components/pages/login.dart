import 'package:ecommerce_app/components/pages/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/components/pages/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  SharedPreferences preferences;

  bool loading = false;
  bool hidePass = true;
  bool isLoggedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn({bool isLoggedin}) async {
    setState(() {
      loading = false;
    });

    await firebaseAuth.currentUser().then((user){
      if (user != null) {
        setState(() => isLoggedin = true);
      }  
    });
    if (isLoggedin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new HomePage(),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  Widget showCircularProgress(){
    if (loading) {
      return Center(child: CircularProgressIndicator(),);
    }
    return new HomePage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          showCircularProgress(),
          Image.asset(
            "images/back.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/logo2.png',
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: <Widget>[
                      //---------------This is for the email--------------------

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.4),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 1,
                              autofocus: false,
                              controller: emailTextController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                icon: Icon(Icons.alternate_email),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value))
                                    return 'Please make sure your email address is valid';
                                  else
                                    return null;
                                } else
                                  return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      //--------------This is for the password------------------

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.4),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: passwordTextController,
                                obscureText: hidePass,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  icon: Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'The password field cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'The password should be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidePass = false;
                                    Timestamp(1, 0);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      //-------------This is for the login button-----------------

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.shade700,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () {
                              handleSignInEmail(emailTextController.text,
                                  passwordTextController.text);
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Forgot password',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<FirebaseUser> handleSignInEmail(
      String emailTextController, String passwordTextController) async {
    AuthResult result = await firebaseAuth.signInWithEmailAndPassword(
        email: emailTextController, password: passwordTextController);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    isSignedIn(isLoggedin: true);

    Fluttertoast.showToast(
        msg: "Login successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.black.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0);

    return currentUser;
  }
}
