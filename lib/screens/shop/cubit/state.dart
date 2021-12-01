import '/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomSheetState extends ShopStates {}

class ShopHomeLoadingDataState extends ShopStates {}

class ShopHomeSuccessDataState extends ShopStates {}

class ShopHomeErrorDataState extends ShopStates {
  final dynamic error;

  ShopHomeErrorDataState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {
  final dynamic error;

  ShopCategoriesErrorState(this.error);
}

class ShopFavoritesState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopFavoritesSuccessState(this.model);
}

class ShopFavoritesErrorState extends ShopStates {
  final dynamic error;

  ShopFavoritesErrorState(this.error);
}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopStates {
  final dynamic error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopGetUserDataSuccessState extends ShopStates {}

class ShopGetUserDataErrorState extends ShopStates {
  final dynamic error;

  ShopGetUserDataErrorState(this.error);
}
