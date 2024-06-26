import '../../../models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterPasswordVisibilityState extends ShopRegisterStates {}
