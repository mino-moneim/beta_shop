import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/change_favorites_model.dart';
import '/models/models.dart';
import '/screens/screens.dart';
import '/screens/shop/cubit/state.dart';
import '/shared/components/token.dart';
import '/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomSheetState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopHomeLoadingDataState());

    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }

      emit(ShopHomeSuccessDataState());
    }).catchError((error) {
      emit(ShopHomeErrorDataState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int id) {
    favorites[id] = !favorites[id]!;

    emit(ShopFavoritesState());

    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[id] = !favorites[id]!;
      } else {
        getFavoritesData();
      }

      emit(ShopFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[id] = !favorites[id]!;

      emit(ShopFavoritesErrorState(error));
    });
  }

  FavoritesModel? favoritesModel;

  Future<void> getFavoritesData() async {
    emit(ShopGetFavoritesLoadingState());

    await DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopGetFavoritesErrorState(error));
    });
  }
}
