import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class panier_Provider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  int _Qte=1;
   int get Qte => _Qte;
deleteprefs()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("cart_item");
  prefs.remove("total_price");
  // prefs.remove("qte");
}

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("cart_item", _counter);
    prefs.setDouble("total_price", _totalPrice);
    // prefs.setInt("qte", _Qte);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt("cart_item") ?? 0;
    _totalPrice = prefs.getDouble("total_price") ?? 0.0;
    // _Qte= prefs.getInt("qte") ?? 1;

    notifyListeners();
  }


// Total
  void addTotal(double productPrice,double q ) {
    _totalPrice = _totalPrice + (productPrice*q);
    _setPrefItems();
    notifyListeners();
  }

  void RemoveTotal(double productPrice,double q ) {
    _totalPrice = _totalPrice -(productPrice*q);
    _setPrefItems();
    notifyListeners();
  }

  double getTotal() {
    _getPrefItems();
    return _totalPrice;
  } 
  




//  Counter
  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void RemoveCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
  
}
