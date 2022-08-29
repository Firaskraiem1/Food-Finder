import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/utils%20.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/panierProvider.dart';
import 'register.dart';

import '../main.dart';
import 'myhome.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isobscure = true;
  var username;
  var mail;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<panier_Provider>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: SingleChildScrollView(
            reverse: true,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/back9.jpg"),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 10),
                      child: Image.asset(
                        "assets/key (1).png",
                        width: 150,
                        height: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Text("Sign In",
                          style: TextStyle(
                            fontSize: 35,
                            height: 0.4,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50, left: 15, right: 15, bottom: 15),
                      child: Form(
                        key: _formKey1,
                        child: TextFormField(
                          validator: (value) {
                            if (value?.isEmpty == true) return "email required";
                          },
                          cursorHeight: 21,
                          controller: _email,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: (OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              )),
                              filled: true,
                              fillColor: Color.fromARGB(255, 215, 215, 215),
                              hintText: ("Email: example@gmail.com"),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 105, 145, 240),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                          key: _formKey2,
                          child: TextFormField(
                            validator: (value) {
                              if (value?.isEmpty == true)
                                return "password required";
                            },
                            controller: _password,
                            obscureText: isobscure,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 215, 215, 215),
                              // labelText: ("Password:"),
                              hintText: "Password:",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              focusedBorder: (OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    isobscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color.fromARGB(255, 105, 145, 240)),
                                onPressed: () {
                                  setState(() {
                                    isobscure = !isobscure;
                                  });
                                },
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 20),
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Color.fromARGB(255, 105, 145, 240), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          if (_email.text.isEmpty || _password.text.isEmpty) {
                            _formKey1.currentState!.validate();
                            _formKey2.currentState!.validate();
                          } else {
                            _formKey1.currentState!.validate();
                            _formKey2.currentState!.validate();
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text)
                                  .then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const MyHome()));
                                //************************/
                                setState(() {
                                  mealList.removeRange(0, mealList.length);
                                  cart.deleteprefs();
                                });
                                //************************/
                              });
                              print("SignedIn");
                              const snack = SnackBar(
                                content: Text("Login successful!"),
                                backgroundColor:
                                    Color.fromARGB(1000, 0, 51, 102),
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            } on FirebaseAuthException catch (e) {
                              showtoast();
                            }
                          }
                        },
                        child: Text(" Sign In "),
                      ),
                    ),
                    Text(
                      "Or",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 105, 145, 240)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 5, top: 10, bottom: 70),
                          child: Text(
                            "Don't have account?",
                            style: TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 30, top: 10, bottom: 70),
                          child: TextButton(
                            onPressed: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const Register()));
                            },
                            child: Text(
                              " Sign Up ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 105, 145, 240)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

void showtoast() => Fluttertoast.showToast(
    msg: "Email or password required !!",
    fontSize: 13,
    backgroundColor: Color.fromARGB(255, 120, 118, 125));
