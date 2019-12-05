import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/db/users.dart';
import 'package:ecommerce_app/components/pages/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce_app/db/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  UserServices userServices = UserServices();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();

  String gender;
  String groupValue = 'male';

  bool loading = false;
  bool hidePass = true;
  bool isLoggedin = false;

  void isSignedIn({bool isLoggedin}) async {
    setState(() {
      loading = false;
      isLoggedin = true;
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.4),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              controller: nameTextController,
                              decoration: InputDecoration(
                                hintText: 'Full name',
                                icon: Icon(Icons.person_outline),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'The name field cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

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
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
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

                      //---------------The male/female checkbox-----------------

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.4),
                          elevation: 0.0,
                          child: new Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'male',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Radio(
                                        value: 'male',
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      'female',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Radio(
                                        value: 'female',
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e)),
                                  ),
                                ),
                              ],
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
                                maxLines: 1,
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
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      //--------This is for the confirm password field----------

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
                                controller: confirmPasswordController,
                                obscureText: hidePass,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: 'Cofirm password',
                                  icon: Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'The password field cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'The password should be at least 6 characters';
                                  } else if (passwordTextController.text !=
                                      value) {
                                    return 'The passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidePass = false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      //------------This is for the Sign up button--------------

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.shade700,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () {
                              handleSignUp(
                                  emailTextController,
                                  passwordTextController,
                                  nameTextController,
                                  e);
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              'Sign up',
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
                          'Already have an account',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
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

          //------------This code here ensures the page visibility--------------

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

  valueChanged(e) {
    setState(() {
      if (e == 'male') {
        groupValue = e;
        gender = e;
      } else if (e == 'female') {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future<FirebaseUser> handleSignUp(emailTextController, passwordTextController,
      nameTextController, e) async {
    AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextController.text, password: passwordTextController.text);
    final FirebaseUser user = result.user;

    await UserServices().updateUserData(
        nameTextController, emailTextController, user.uid, e);

    assert(user != null);
    assert(await user.getIdToken() != null);



    isSignedIn(isLoggedin: true);

    Fluttertoast.showToast(
        msg: "Sign up successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.black.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0);

    return user;
  }
}
