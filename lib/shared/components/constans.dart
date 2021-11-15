import 'package:social_app/modules/shop_modules/on_boarding/on_boarding_screen.dart';

import 'components.dart';
import '../network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeDataFromSharedPrefrence(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context: context, screen: OnBoardingScreen());
    }
  });
}

String? token = '';
//if find any error act like token above
String? uId ;
