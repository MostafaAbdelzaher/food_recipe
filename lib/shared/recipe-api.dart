import 'dart:convert';
import 'package:food_recipe/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "a175286dddmsh81a35037b2f067fp1622bajsn7a202458daa6",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List<Recipe> getData = [];

    for (var i in data['feed']) {
      getData.add(Recipe.fromJson(i['content']['details']));
    }

    return getData;
  }
}
