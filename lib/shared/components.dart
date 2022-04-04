import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/cubit/cubit.dart';
import 'package:food_recipe/cubit/states.dart';
import 'package:food_recipe/modules/search_screen.dart';

import 'constatnts.dart';

var searchController = TextEditingController();

class RecipeCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;
  final bool isRatingRow;
  const RecipeCard({
    Key? key,
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
    required this.isRatingRow,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isRatingRow
          ? const EdgeInsets.symmetric(horizontal: 22, vertical: 10)
          : const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.multiply,
          ),
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
          if (isRatingRow)
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          rating,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          cookTime,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              alignment: Alignment.bottomLeft,
            )
        ],
      ),
    );
  }
}

class HeaderWithSearchBox extends StatelessWidget {
  final bool navigatorSearch;
  const HeaderWithSearchBox({
    Key? key,
    this.navigatorSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RecipeCubit.get(context);
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: size.height * 0.25,
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.25,
                child: CarouselSlider(
                  items: RecipeCubit.get(context)
                      .recipeList
                      .map(
                        (e) => RecipeCard(
                          isRatingRow: false,
                          title: e.name!,
                          cookTime: e.totalTime!,
                          rating: e.rating.toString(),
                          thumbnailUrl: e.images!,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 200.0,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 15,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding),
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(
                              0,
                              10,
                            ),
                            color: kPrimaryColor.withOpacity(0.23),
                            blurRadius: 50),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  height: 54,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: const Color(0xFF0C9869)
                                      .withOpacity(0.5))),
                          controller: searchController,
                          onSubmitted: (value) {
                            cubit.getDataSearch(value: value);
                            if (navigatorSearch) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()));
                            }
                          },
                        ),
                      ),
                      const Icon(Icons.search)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

//CarouselSlider(
//                   items: RecipeCubit.get(context)
//                       .recipeList
//                       .map(
//                         (e) => Image(
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                               '${e.images}',
//                             )),
//                       ).toList(),
//                   options: CarouselOptions(
//                     height: 200.0,
//                     initialPage: 0,
//                     viewportFraction: 1.0,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     autoPlayInterval: Duration(seconds: 3),
//                     autoPlayAnimationDuration: Duration(seconds: 1),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     scrollDirection: Axis.horizontal,
//                   ),
//                 ),
