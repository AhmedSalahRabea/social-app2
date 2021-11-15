// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/shop_models/search_model.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/network/remote/doi_helper.dart';
import 'package:social_app/shared/network/remote/end_points.dart';


part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

//===== to get searched product =====
  SearchModel? searchModel;
  void searchProduct(String text) {
    emit(SearchLoading());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SearchError());
    });
  }

 
}
