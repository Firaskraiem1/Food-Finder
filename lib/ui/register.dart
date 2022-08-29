import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/ui/myhome.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isobscure = true;
  bool isobscure1 = true;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
   final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
   final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
   final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  void enregis() {
    String user = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("users");
    userRef.doc(user).set({
      "email": _email.text,
      "username": _username.text,
      "adress": _address.text,
      "password": _password.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const Login()));
                            },
                            icon: Icon(Icons.arrow_back),
                            iconSize: 35,
                            color: Color.fromARGB(255, 105, 145, 240),
                          ),
                        ),
                        Image.asset(
                          "assets/register.png",
                          width: 180,
                          height: 250,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: _formKey1,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return "email required";
                                }
                              },
                              controller: _email,
                              cursorHeight: 21,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 215, 215, 215),
                                // labelText: ("Email:"),
                                hintText: "Email:",
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.mail,
                                        color: Color.fromARGB(
                                            255, 105, 145, 240))),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: (OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                                 key: _formKey5,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return "adress required";
                                }
                              },
                              controller: _address,
                              cursorHeight: 21,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 215, 215, 215),
                                // labelText: ("Adress:"),
                                hintText: "Adress:",
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.alternate_email,
                                        color: Color.fromARGB(
                                            255, 105, 145, 240))),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: (OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: _formKey4,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return "username required";
                                }
                              },
                              controller: _username,
                              cursorHeight: 21,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 215, 215, 215),
                                // labelText: ("Username:"),
                                hintText: "UserName:",
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.person,
                                        color: Color.fromARGB(
                                            255, 105, 145, 240))),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: (OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: _formKey2,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return "password required";
                                }
                              },
                              controller: _password,
                              obscureText: isobscure1,
                              cursorHeight: 21,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 215, 215, 215),
                                // labelText: ("Password:"),
                                hintText: "Password:",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      isobscure1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          Color.fromARGB(255, 105, 145, 240)),
                                  onPressed: () {
                                    setState(() {
                                      isobscure1 = !isobscure1;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: (OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                             key: _formKey3,
                            child: TextFormField(
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return "confirm password required";
                                }
                              },
                              controller: _confirmpassword,
                              cursorHeight: 21,
                              cursorColor: Colors.black,
                              obscureText: isobscure,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 215, 215, 215),
                                //  labelText: ("Confirm password:"),
                                hintText: "Confirm password:",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      isobscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          Color.fromARGB(255, 105, 145, 240)),
                                  onPressed: () {
                                    setState(() {
                                      isobscure = !isobscure;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: (OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(
                                  255, 105, 145, 240), // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {
                              if (_email.text.isEmpty ||
                                  _password.text.isEmpty||_confirmpassword.text.isEmpty ||_username.text.isEmpty||_address.text.isEmpty) {
                                _formKey1.currentState!.validate();
                                _formKey2.currentState!.validate();
                                _formKey3.currentState!.validate();
                                _formKey5.currentState!.validate();
                                _formKey4.currentState!.validate();
                              } else {
                                if (_password.text!=_confirmpassword.text)
                                {_formKey1.currentState!.validate();
                                _formKey2.currentState!.validate();
                                _formKey3.currentState!.validate();
                                 _formKey4.currentState!.validate();
                                _formKey5.currentState!.validate();
                               showtoast1();
                               }
                                // if (_password.text!=_confirmpassword.text)
                                // {}
                                else {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _password.text)
                                      .then((value) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const MyHome()));
                                    // setPrefs();
                                    enregis();
                                  });

                                  const snack = SnackBar(
                                    content: Text("Account created!"),
                                    backgroundColor:
                                        Color.fromARGB(1000, 0, 51, 102),
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                } on FirebaseAuthException catch (e) {
                                  showtoast();
                                }
                                }
                              }
                            },
                            child: Text("Sign up"),
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}

void showtoast() => Fluttertoast.showToast(
    msg: "Email or password required !!",
    fontSize: 12,
    backgroundColor: Color.fromARGB(255, 120, 118, 125));
    void showtoast1() => Fluttertoast.showToast(
    msg: "confirm password or password not the same",
    fontSize: 12,
    backgroundColor: Color.fromARGB(255, 120, 118, 125));
