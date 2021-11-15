// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  //==================change themeMode=================
  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeModeChange());
    } else {
      isDark = !isDark;
      CacheHelper.saveDataInSharedPrefrences(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(ThemeModeChange());
      });
    }
  }

 
}
