import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/cubit/cubit.dart';
import 'package:food_recipe/cubit/states.dart';
import 'package:food_recipe/modules/web_view.dart';

import '../shared/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {},
      builder: (context, state) {
        List recipe = RecipeCubit.get(context).recipeList;
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
            ),
            body: recipe.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const HeaderWithSearchBox(navigatorSearch: true),
                      Expanded(
                        child: ListView.builder(
                          itemCount: recipe.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => viewUrl(
                                      url: recipe[index].url!,
                                    ),
                                  ),
                                );
                              },
                              child: RecipeCard(
                                  isRatingRow: true,
                                  title: recipe[index].name!,
                                  cookTime: recipe[index].totalTime!,
                                  rating: recipe[index].rating!.toString(),
                                  thumbnailUrl: recipe[index].images!),
                            );
                          },
                        ),
                      ),
                    ],
                  ));
      },
    );
  }
}
