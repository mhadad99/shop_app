
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required email,
    required password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        },
    ).then((value){
      print(value);
          emit(ShopLoginSuccessState());
    }).catchError((onError){
      emit(ShopLoginErrorState(onError.toString()));
    });
  }

}