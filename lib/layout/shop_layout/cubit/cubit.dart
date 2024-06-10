import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourite/favourite_screen.dart';
import 'package:shop_app/modules/product/product_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((onValue) {
      homeModel = HomeModel.fromJson(onValue.data);
      homeModel?.data?.products.forEach(
        (element) {
          favorites.addAll({
            element.id: element.inFavourites,
          });
        },
      );
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoryModel? categoryModel;

  void getCatData() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((onValue) {
      categoryModel = CategoryModel.fromJson(onValue.data);
      emit(ShopSuccessCategoryState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoryState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((onValue) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(onValue.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavData();
      }
      emit(ShopSuccessChangeFavoriteState(changeFavoritesModel));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId]!;

      print(onError.toString());
      emit(ShopErrorChangeFavoriteState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavData() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((onValue) {
      favoritesModel = FavoritesModel.fromJson(onValue.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserSettingsState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((onValue) {
      userModel = ShopLoginModel.fromJson(onValue.data);
      print(userModel!.data.name.toString());
      emit(ShopSuccessUserSettingsState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUserSettingsState());
    });
  }
}
