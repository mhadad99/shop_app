import '../../modules/login_screen/shop_login_screen.dart';
import '../network/local/cache.dart';
import 'components.dart';

String token = '';
void signOut(context) {
  CacheHelper.removeData(key: 'token').then((onValue) {
    token = '';
    navigateAndFinish(context, ShopLoginScreen());
  });
}
