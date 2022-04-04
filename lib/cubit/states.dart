abstract class RecipeState {}

class InitialState extends RecipeState {}

class GetDataSuccessState extends RecipeState {}

class GetDataErrorState extends RecipeState {
  final String error;

  GetDataErrorState(this.error);
}

class GetDataSearchSuccessState extends RecipeState {}

class GetDataSearchLoadingState extends RecipeState {}

class GetDataSearchErrorState extends RecipeState {
  final String error;

  GetDataSearchErrorState(this.error);
}
