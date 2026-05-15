class Meals {
  Meals({
      String? strMeal, 
      String? strMealThumb, 
      String? idMeal, 
      String? strArea, 
      String? strCountry,}){
    _strMeal = strMeal;
    _strMealThumb = strMealThumb;
    _idMeal = idMeal;
    _strArea = strArea;
    _strCountry = strCountry;
}

  Meals.fromJson(dynamic json) {
    _strMeal = json['strMeal'];
    _strMealThumb = json['strMealThumb'];
    _idMeal = json['idMeal'];
    _strArea = json['strArea'];
    _strCountry = json['strCountry'];
  }
  String? _strMeal;
  String? _strMealThumb;
  String? _idMeal;
  String? _strArea;
  String? _strCountry;

  String? get strMeal => _strMeal;
  String? get strMealThumb => _strMealThumb;
  String? get idMeal => _idMeal;
  String? get strArea => _strArea;
  String? get strCountry => _strCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strMeal'] = _strMeal;
    map['strMealThumb'] = _strMealThumb;
    map['idMeal'] = _idMeal;
    map['strArea'] = _strArea;
    map['strCountry'] = _strCountry;
    return map;
  }

}