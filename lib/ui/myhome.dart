import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/meal.dart';
import 'package:flutter_application_1/provider/panierProvider.dart';
import 'package:flutter_application_1/ui/login.dart';
import 'package:flutter_application_1/ui/panier.dart';
import 'package:flutter_application_1/ui/utils%20.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var username;
  var mail;
  var islog;
  var name;
  var prix;
  var index;
  List<int> qte = [];
  List<bool> isAdd = [];
  
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    getuser();
  }

  setPrefs(int i,String n,String u,int p,int q) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("index", i);
    prefs.setString("name", n);
     prefs.setString("url", u);
      prefs.setInt("prix", p);
      prefs.setInt("qte", q);
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    index = prefs.getInt("index");
  }

  final l = <String, dynamic>{};
  getMenu() async {
    CollectionReference menuRef = FirebaseFirestore.instance.collection("menu");
    await menuRef.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          l[element.id] = element.data();
        });
      }
    });
    for (var i = 0; i < l.length; i++) {
      qte.add(1);
      isAdd.add(false);
    }
  }

  getuser() async {
    if (user != null && user?.isAnonymous == false) {
      var uid = user!.uid;
      DocumentReference doc =
          FirebaseFirestore.instance.collection("users").doc(uid);
      await doc.get().then((value) {
        var n = value.get("username");
        var m = value.get("email");
        setState(() {
          if (n != null && m != null) {
            username = n;
            mail = m;
          }
        });
      });
      getMenu();
    } else {
      UserCredential ann = await FirebaseAuth.instance.signInAnonymously();
      if (user?.isAnonymous == true) getMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<panier_Provider>(context);
    //  provider cart

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
            title: Text('Food Finder',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
            backgroundColor: Color.fromARGB(1000, 0, 51, 102),
            centerTitle: true,
            actions: [
              Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Panier()));
                        //  cart.deleteprefs();
                      },
                      icon: Icon(Icons.shopping_cart)),
                  Positioned(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 21),
                        child: Badge(
                          badgeContent: Consumer<panier_Provider>(
                            builder: (context, value, child) {
                              return Text(
                                value.getCounter().toString(),
                                style: TextStyle(color: Colors.white),
                              );
                              //  provider
                            },
                          ),
                          position: BadgePosition.topEnd(),
                          badgeColor: Color.fromARGB(255, 136, 133, 133),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(1000, 0, 51, 102),
                  child: Image.asset(
                    "assets/user.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                accountEmail: user != null && user?.isAnonymous == false
                    ? Text("$mail")
                    : Text(""),
                accountName: user != null && user?.isAnonymous == false
                    ? Text(
                        '$username',
                        style: TextStyle(fontSize: 24.0),
                      )
                    : Text(
                        "No user connected",
                        style: TextStyle(fontSize: 20.0),
                      ),
                decoration:
                    BoxDecoration(color: Color.fromARGB(1000, 0, 51, 102)),
              ),
              ListTile(
                leading: const Icon(Icons.home,
                    color: Color.fromARGB(1000, 0, 51, 102)),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 17.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              user != null && user?.isAnonymous == false
                  ? ListTile(
                      leading: const Icon(Icons.logout,
                          color: Color.fromARGB(1000, 0, 51, 102)),
                      title: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            title: const Text("Are you sure ?"),
                            content: const Text("you want to logout !"),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const MyHome()));
                                                  //********//
                                      setState(() {
                                        mealList.removeRange(
                                            0, mealList.length);
                                        cart.deleteprefs();
                                      });
                                      //********//
                                    },
                                    child: const Text(" Yes ",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text(" No ",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 15)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );

                        await FirebaseAuth.instance.signOut().then((value) {
                          const snack = SnackBar(
                            content: Text("Log out successful!"),
                            backgroundColor: Color.fromARGB(1000, 0, 51, 102),
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        });
                      })
                  : ListTile(
                      leading: const Icon(Icons.login,
                          color: Color.fromARGB(1000, 0, 51, 102)),
                      title: const Text(
                        'Login',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Login()));
                      },
                    )
            ],
            shrinkWrap: true,
          ),
        ),
        body: RefreshIndicator(
          backgroundColor: Color.fromARGB(232, 255, 255, 255),
          onRefresh: () => getMenu(),
          child: Container(
            padding: EdgeInsets.all(5.0),
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  "assets/menu.jpg",
                  height: 140,
                  width: 140,
                  centerSlice: Rect.largest,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Menu",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 93, 94, 95),
                        letterSpacing: 2),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      primary: true,
                      itemCount: l.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.7,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: ((context, i) {
                        final item = l[i];

                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            semanticContainer: true,
                            margin: EdgeInsets.symmetric(),
                            shadowColor: Color.fromARGB(255, 105, 145, 240),
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              children: [
                                Image(
                                    image: NetworkImage(
                                        "${l.values.elementAt(i)["url"]}"),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover),
                                ListTile(
                                  title: Center(
                                    child: Text(
                                      "${l.values.elementAt(i)["name"]}",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17),
                                    ),
                                  ),
                                  subtitle: Center(
                                    child: Text(
                                        "Prix: ${l.values.elementAt(i)["prix"]} DT",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 5),
                                  child: ListTile(
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 130,
                                          child: TextField(
                                            readOnly: true,
                                            controller: TextEditingController(
                                                text: "${qte[i]}"),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0),
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (qte[i] > 1)
                                                        qte[i] -= 1;
                                                    });
                                                  },
                                                  icon:
                                                      Icon(Icons.remove_circle),
                                                ),
                                              ),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0.0),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        qte[i] += 1;
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
                                TextButton(
                                    onPressed: (isAdd[i] == false)
                                        ? () async {
                                            isAdd[i] = true;

                                            mealList.add(Meal(
                                                l.keys.elementAt(i),
                                                mealItem: MealItem(
                                                    name: l.values
                                                        .elementAt(i)["name"],
                                                    prix: l.values
                                                        .elementAt(i)["prix"],
                                                    url: l.values
                                                        .elementAt(i)["url"],
                                                    qte: qte[i],
                                                    isAdd: isAdd[i])));
                                            setPrefs(i, l.values.elementAt(i)["name"],l.values.elementAt(i)["url"],l.values.elementAt(i)["prix"], qte[i]);
                                            cart.addTotal(
                                                double.parse(l.values
                                                    .elementAt(i)["prix"]
                                                    .toString()),
                                                double.parse(
                                                    qte[i].toString()));
                                            cart.addCounter();
                                            
                                          }
                                        : null,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Add to cart",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.shopping_cart),
                                          iconSize: 20,
                                          alignment: Alignment.center,
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                      shrinkWrap: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showtoast() => Fluttertoast.showToast(
    msg: "Email or password required !!",
    fontSize: 13,
    backgroundColor: Color.fromARGB(255, 120, 118, 125));
