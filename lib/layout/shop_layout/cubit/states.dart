import 'package:shop_app/models/login_model.dart';

import '../../../models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {}

class ShopErrorCategoryState extends ShopStates {}

class ShopChangeFavoriteState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}

class ShopErrorChangeFavoriteState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingUserSettingsState extends ShopStates {}

class ShopSuccessUserSettingsState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessUserSettingsState(this.userModel);
}

class ShopErrorUserSettingsState extends ShopStates {}
