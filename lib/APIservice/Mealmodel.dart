import 'Meals.dart';

class Mealmodel {
  Mealmodel({
      List<Meals>? meals,}){
    _meals = meals;
}

  Mealmodel.fromJson(dynamic json) {
    if (json['meals'] != null) {
      _meals = [];
      json['meals'].forEach((v) {
        _meals?.add(Meals.fromJson(v));
      });
    }
  }
  List<Meals>? _meals;

  List<Meals>? get meals => _meals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meals != null) {
      map['meals'] = _meals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}