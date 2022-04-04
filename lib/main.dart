import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/cubit/cubit.dart';
import 'package:food_recipe/shared/dio.dart';

import 'modules/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit()..getData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Recipe',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
        home: const HomePage(),
      ),
    );
  }
}
