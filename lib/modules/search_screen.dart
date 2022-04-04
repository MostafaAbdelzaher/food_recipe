import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/cubit/states.dart';
import 'package:food_recipe/modules/web_view.dart';
import 'package:food_recipe/shared/dio.dart';

import '../cubit/cubit.dart';
import '../shared/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {},
      builder: (context, state) {
        List searchList = RecipeCubit.get(context).searchList;
        var cubit = RecipeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  'Food Recipe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Lemon',
                  ),
                )
              ],
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
            children: [
              const HeaderWithSearchBox(),
              State is GetDataSearchLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                      strokeWidth: 30,
                    ))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => viewUrl(
                                    url: searchList[index].url!,
                                  ),
                                ),
                              );
                            },
                            child: RecipeCard(
                                isRatingRow: true,
                                title: searchList[index].name!,
                                cookTime: searchList[index].totalTime!,
                                rating: searchList[index].rating!.toString(),
                                thumbnailUrl: searchList[index].images!),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
