abstract class ShopSearchStates {}

class ShopSearchInitState extends ShopSearchStates {}

class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {}

class ShopSearchErrorState extends ShopSearchStates {
  final String error;

  ShopSearchErrorState(this.error);
}
