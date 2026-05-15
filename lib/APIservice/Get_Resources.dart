import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/APIservice/Categories.dart';

import 'CategoriesModel.dart';
import 'Mealmodel.dart';
import 'Meals.dart';

 class GetResponse  {
   static String baseurl="www.themealdb.com";
   static String categoryEndPoint="/api/json/v1/1/categories.php";
   static String mealEndPoint="/api/json/v1/1/filter.php";

  static Future<List<Categories>?> getCategories() async {
    Uri url = Uri.https(baseurl,categoryEndPoint);
    http.Response responce = await http.get(url);
    var json = jsonDecode(responce.body);
    CategoriesModel categories= CategoriesModel.fromJson(json);
    return categories.categories ?? [];
  }
   static Future<List<Meals>> getMeals(String category) async {
     final url = Uri.https(
       baseurl, mealEndPoint,
       {'c': category},
     );
     final responce = await http.get(url);
     if (responce.statusCode != 200) {
       throw Exception('Failed to load meals');
     }
     final json = jsonDecode(responce.body);
     final meals = Mealmodel.fromJson(json);
     return meals.meals ?? [];
   }
 }