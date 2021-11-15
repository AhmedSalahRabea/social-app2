import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import '../../login/shop_login_screen.dart';
import '../on_boarding_item.dart';


part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  static OnboardingCubit get(context) => BlocProvider.of(context);

  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding/onboarding1.png',
      title: 'أهلا بك في تطبيق دارين',
      body: 'هذا التطبيق هو تطبيق متكامل لكل متاجر صفط الخمار',
    ),
    BoardingModel(
      image: 'assets/images/onboarding/onboarding2.png',
      title: 'قريتنا تستحق دائما الأفضل',
      body:
          'وعلشان كده كان لازم يكون في طريقة تسهل علينا وعلي أهلنا شراء جميع المنتجات بضغطة زر واحدة',
    ),
    BoardingModel(
      image: 'assets/images/onboarding/onboarding3.png',
      title: 'صفط الخمار كلها بين ايديك',
      body:
          'من خلال تطبيق دارين تقدر تطلب أي حاجة ف اي وقت ومن أكتر من مكان وتجيلك لغاية البيت في دقايق ',
    ),
  ];

//this method to set the variable onBoarding in shared pref
  void checkOnBoardingState({required BuildContext context, bool? fromShared}) {
    if (fromShared == false) {
      CacheHelper.saveDataInSharedPrefrences(
              key: 'isSeeOnBoarding', value: true)
          .then((value) {
        if (value) {
          navigateTo(context: context, screen: ShopLoginScreen());
          emit(OnboardingChange());
        }
      });
    }
  }
}
