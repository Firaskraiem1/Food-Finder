import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/meal.dart';
import 'package:flutter_application_1/ui/utils%20.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../provider/panierProvider.dart';
import 'login.dart';
import 'myhome.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  int valeur = 1;
  List<int> qte = [];
  final User? user = FirebaseAuth.instance.currentUser;
   var index;
   var p;
   var u;
   var q;
   var n;
  @override
  void initState() {
    super.initState();
    //  final cart = Provider.of<panier_Provider>(context);
    //  cart.deleteprefs();
  }

  // getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   index = prefs.getInt("index");
  //   n = prefs.getString("name");
  //   u = prefs.getString("url");
  //   p = prefs.getInt("prix");
  //   q = prefs.getInt("qte");
  // }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<panier_Provider>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/back9.jpg"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const MyHome()));
                        },
                        icon: Icon(Icons.arrow_back),
                        iconSize: 35,
                        color: Color.fromARGB(255, 105, 145, 240),
                      ),
                    ),
                    Text(
                      "Panier",
                      style: TextStyle(
                          color: Color.fromARGB(255, 105, 145, 240),
                          fontSize: 20),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    primary: true,
                    scrollDirection: Axis.vertical,
                    itemCount: mealList.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Dismissible(
                            key: Key(mealList[i].toString()),
                            // key utilisable to delete item
                            onDismissed: ((DismissDirection dir) {
                              setState(() {
                                cart.RemoveCounter();
                                // to dicremente counter
                                cart.RemoveTotal(
                                    double.parse(
                                        mealList[i].mealItem!.prix.toString()),
                                    double.parse(
                                        mealList[i].mealItem!.qte.toString()));

                                // to remove prix of item from total
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(dir == DismissDirection.startToEnd
                                    ? '${mealList[i].mealItem!.name} removed.'
                                    : '${mealList[i].mealItem!.name} removed.'),
                                backgroundColor:
                                    Color.fromARGB(1000, 0, 51, 102),
                              ));
                              mealList.removeAt(i);

                            }),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: const Icon(Icons.delete),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Icon(Icons.delete),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: ListTile(
                                  tileColor: Colors.green,
                                  leading: Image(
                                      image: NetworkImage(
                                          "${mealList[i].mealItem?.url}"),
                                      fit: BoxFit.cover),
                                  title: Text(
                                    "${mealList[i].mealItem?.name}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  subtitle: Text(
                                    "Prix:${mealList[i].mealItem?.prix} DT",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: TextField(
                                          readOnly: true,
                                          controller: TextEditingController(
                                              text:
                                                  "${mealList[i].mealItem!.qte}"),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  if (mealList[i]
                                                          .mealItem!
                                                          .qte !=
                                                      1) {
                                                    setState(() {
                                                      var name = mealList[i]
                                                          .mealItem!
                                                          .name;
                                                      var prix = mealList[i]
                                                          .mealItem!
                                                          .prix;
                                                      var url = mealList[i]
                                                          .mealItem!
                                                          .url;
                                                      var id = mealList[i].id;
                                                      var qte = mealList[i]
                                                          .mealItem!
                                                          .qte;

                                                      if (qte != null &&
                                                          qte > 1)
                                                        qte = qte - 1;
                                                      cart.RemoveTotal(
                                                          double.parse(
                                                              mealList[i]
                                                                  .mealItem!
                                                                  .prix
                                                                  .toString()),
                                                          double.parse("1"));
                                                      mealList[i] = Meal(
                                                          id.toString(),
                                                          mealItem: MealItem(
                                                              name: name,
                                                              prix: prix,
                                                              qte: qte,
                                                              url: url));
                                                    });
                                                  }
                                                },
                                                icon: Icon(Icons.remove_circle),
                                              ),
                                            ),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      var qte = mealList[i]
                                                          .mealItem!
                                                          .qte;
                                                      var name = mealList[i]
                                                          .mealItem!
                                                          .name;
                                                      var prix = mealList[i]
                                                          .mealItem!
                                                          .prix;
                                                      var url = mealList[i]
                                                          .mealItem!
                                                          .url;
                                                      var id = mealList[i].id;

                                                      if (qte != null)
                                                        qte = qte + 1;
                                                      mealList[i] = Meal(
                                                          id.toString(),
                                                          mealItem: MealItem(
                                                              name: name,
                                                              prix: prix,
                                                              qte: qte,
                                                              url: url));
                                                      cart.addTotal(
                                                          double.parse(
                                                              mealList[i]
                                                                  .mealItem!
                                                                  .prix
                                                                  .toString()),
                                                          double.parse("1"));

                                                      // cart.addQte();
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.add_circle,
                                                  )),
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
                        ],
                      );
                    },
                    shrinkWrap: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Total:",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            child: TextFormField(
                                readOnly: true,
                                controller: TextEditingController(
                                    text: "${cart.getTotal().toString()} DT"),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 215, 215, 215),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 0, 0, 0))))),
                          ),
                        ],
                      ),
                      user != null && user?.isAnonymous == false
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 105, 145, 240)),
                                  onPressed: () {
                                    // var t=cart.getTotal();
                                    print(mealList.length);
                                    if (mealList.length != 0) {
                                      // showtoast();
                                       showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          title: const Text("Order validate ",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
                                          content: Image(
                                            image:
                                                AssetImage("assets/check.png"),width: 60,height: 60,
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const MyHome()));
                                                    //********//
                                                    setState(() {
                                                      mealList.removeRange(
                                                          0, mealList.length);
                                                      cart.deleteprefs();
                                                    });
                                                    //********//
                                                  },
                                                  child: const Text(" Ok ",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontSize: 15)),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text(" Cancel ",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                       showtoast1();
                                     
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.monetization_on),
                                      Text("Order",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  )),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromARGB(255, 105, 145, 240)),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const Login())).then((value) {
                                      // showtoast();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.login),
                                      Text("please login",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  )),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showtoast() => Fluttertoast.showToast(
    msg: "Order validated!!",
    fontSize: 13,
    backgroundColor: Color.fromARGB(255, 120, 118, 125));
void showtoast1() => Fluttertoast.showToast(
    msg: "no added product!!",
    fontSize: 13,
    backgroundColor: Color.fromARGB(255, 120, 118, 125));
