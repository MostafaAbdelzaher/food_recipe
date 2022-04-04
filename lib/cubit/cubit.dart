import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/cubit/states.dart';
import 'package:food_recipe/model/recipe.dart';
import 'package:food_recipe/shared/dio.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(InitialState());
  static RecipeCubit get(context) => BlocProvider.of(context);
  List<Recipe> recipeList = [];
  List<Recipe> searchList = [];
  List<Image> imageList = [];

  void getData() {
    DioHelper.getData(
      query: {
        "limit": "24",
        "start": "0",
        "tag": "list.recipe.popular",
      },
      url: '/feeds/list',
    ).then((value) {
      for (var i in value.data['feed']) {
        recipeList.add(Recipe.fromJson(i['content']['details']));
      }

      emit(GetDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetDataErrorState(onError));
    });
  }

  void getDataSearch({required String value}) {
    emit(GetDataSearchLoadingState());
    DioHelper.getData(
      query: {
        "maxResult": "18",
        "start": "0",
        "q": value,
      },
      url: '/feeds/search',
    ).then((value) {
      List<Recipe> searchList = [];

      for (var i in value.data['feed']) {
        searchList.add(Recipe.fromJson(i['content']['details']));
      }

      emit(GetDataSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetDataSearchErrorState(onError));
    });
  }
}
