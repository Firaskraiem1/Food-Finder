class Meal {
  String? id; 
  MealItem? mealItem;

  Meal(String elementAt, {this.id , this.mealItem});

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id']; 
    mealItem = json['mealItem'] != null
        ? new MealItem.fromJson(json['mealItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id; 
    if (this.mealItem != null) {
      data['mealItem'] = this.mealItem!.toJson();
    }
    return data;
  }
}

class MealItem {
  String? name;
  int? prix;
  String? url;
  int? qte;
  bool? isAdd;

  MealItem({this.name, this.prix, this.url, this.qte,this.isAdd});

  MealItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    prix = json['prix'];
    url = json['url'];
    qte = json['qte'];
    isAdd= json ['isAdd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['prix'] = this.prix;
    data['url'] = this.url;
    data['qte'] = this.qte;
    data['isAdd'] = this.isAdd;
    return data;
  }
}
 