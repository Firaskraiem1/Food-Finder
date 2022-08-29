 // isloggedin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool test = false;
  //   if (user != null) {
  //     test = true;
  //     setState(() {
  //       prefs.setBool("t", test);
  //     });
  //   } else {
  //     setState(() {
  //       prefs.setBool("t", test);
  //     });
  //   }
  // }
  

  // getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     bool?  test = prefs.getBool("t");
     
      
  //       islog = test;
  //       print(islog);
      

  //   });
  // }

  // deletePrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //    prefs.remove("name");
  //    prefs.remove("email");
  //   });
  // }


















  // GridView(
  //               scrollDirection: Axis.vertical,
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2, mainAxisExtent: 205),
  //               children: [
                  // Card(
                  //   shadowColor: Color.fromARGB(255, 105, 145, 240),
                  //   color: Color.fromARGB(255, 255, 255, 255),
                  //   child: Column(
                  //     children: [
                  //       Image.asset(
                  //         "assets/ice-cream.png",
                  //         width: 65,
                  //         height: 65,
                  //       ),
                  //       ListTile(
                  //         title: Text("$name"),
                  //         subtitle:
                  //             Text("$prix", style: TextStyle(fontSize: 15)),
                  //       ),
                  //       ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             primary: Color.fromARGB(
                  //                 255, 105, 145, 240), // background
                  //             onPrimary: Colors.white, // foreground
                  //           ),
                  //           onPressed: () {
                  //             Navigator.pushReplacement(
                  //                 context,
                  //                 MaterialPageRoute<void>(
                  //                     builder: (BuildContext context) =>
                  //                         const Panier()));
                  //           },
                  //           child: Row(
                  //             children: [
                  //               Text(
                  //                 "Ajout au panier",
                  //                 style: TextStyle(fontSize: 15),
                  //               ),
                  //               IconButton(
                  //                 onPressed: () {},
                  //                 icon: Icon(Icons.shopping_cart),
                  //                 iconSize: 20,
                  //                 alignment: Alignment.centerRight,
                  //               ),
                  //             ],
                  //           )),
                  //     ],
                  //   ),
                  // ),
  //                 Card(
  //                     shadowColor: Color.fromARGB(255, 8, 25, 64),
  //                     color: Color.fromARGB(255, 255, 255, 255),
  //                     child: Column(
  //                       children: [
  //                         Image.asset(
  //                           "assets/pizza.png",
  //                           width: 65,
  //                           height: 65,
  //                         ),
  //                         ListTile(
  //                           title: Text("Pizza"),
  //                           subtitle: Text("Prix=15Dt",
  //                               style: TextStyle(fontSize: 15)),
  //                         ),
  //                         ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                               primary: Color.fromARGB(
  //                                   255, 105, 145, 240), // background
  //                               onPrimary: Colors.white, // foreground
  //                             ),
  //                             onPressed: () {
  //                               Navigator.pushReplacement(
  //                                   context,
  //                                   MaterialPageRoute<void>(
  //                                       builder: (BuildContext context) =>
  //                                           const Panier()));
  //                             },
  //                             child: Row(
  //                               children: [
  //                                 Text(
  //                                   "Ajout au panier",
  //                                   style: TextStyle(fontSize: 15),
  //                                 ),
  //                                 IconButton(
  //                                   onPressed: () {},
  //                                   icon: Icon(Icons.shopping_cart),
  //                                   iconSize: 20,
  //                                   alignment: Alignment.centerRight,
  //                                 ),
  //                               ],
  //                             )),
  //                       ],
  //                     )),
  //               ],
  //               shrinkWrap: true,
  //             ),


















  // Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey,
//                                   offset: Offset.zero,
//                                   blurRadius: 5)
//                             ]),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   ConstrainedBox(
//                                       constraints: BoxConstraints(
//                                           maxHeight: double.infinity,
//                                           maxWidth: double.infinity,
//                                           minHeight: 70,
//                                           minWidth: 70),
//                                       child: Image(
//                                         image: NetworkImage("$u"),
//                                         width: 40,
//                                         height: 40,
//                                         fit: BoxFit.cover,
//                                       )),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(5),
//                                     child: Text(
//                                       "$n",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                       padding: const EdgeInsets.all(5),
//                                       child: Text(
//                                         "Prix:$p",
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 120,
//                                     child: TextField(
//                                       readOnly: true,
//                                       controller: TextEditingController(
//                                           text: valeur.toString()),
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(
//                                         prefixIcon: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 0.0),
//                                           child: IconButton(
//                                             onPressed: () {
//                                               setState(() {
//                                                 valeur--;
//                                               });
//                                             },
//                                             icon: Icon(Icons.remove),
//                                           ),
//                                         ),
//                                         suffixIcon: Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 0.0),
//                                           child: IconButton(
//                                               onPressed: () {
//                                                 setState(() {
//                                                   valeur++;
//                                                 });
//                                               },
//                                               icon: Icon(
//                                                 Icons.add,
//                                               )),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 50),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: Color.fromARGB(
//                                 255, 105, 145, 240), // background
//                             onPrimary: Colors.white, // foreground
//                           ),
//                           onPressed: () {},
//                           child: Row(
//                             children: [
//                               Text("Order"),
//                               IconButton(
//                                   onPressed: () {}, icon: Icon(Icons.paid))
//                             ],
//                           )),
//                     ),
//                   ],
//                 )




