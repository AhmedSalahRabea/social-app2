// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/shop_models/category_details_model.dart';
import 'package:social_app/models/shop_models/category_model.dart';
import 'package:social_app/models/shop_models/change_favourites_model.dart';
import 'package:social_app/models/shop_models/favourite_model.dart';
import 'package:social_app/models/shop_models/home_model.dart';
import 'package:social_app/models/shop_models/login_model.dart';

import 'package:social_app/modules/shop_modules/categries/categories_screen.dart';
import 'package:social_app/modules/shop_modules/favourite/favourite.dart';
import 'package:social_app/modules/shop_modules/products/products_screen.dart';
import 'package:social_app/modules/shop_modules/settings_screen/settings_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/network/remote/doi_helper.dart';
import 'package:social_app/shared/network/remote/end_points.dart';


part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  //========Bottom navigation bar logic==========

  int currebIndex = 0;
  void changeBottomNavIndex(int index) {
    currebIndex = index;
    emit(ShopChangeBottomNavBar());
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favourites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  //=========method to get home data from api=====
  HomeModel? homeModel;
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.dataModel.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavourite,
        });
      });
      // print(favourites.toString());
      // print(homeModel!.dataModel.products[10].name);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  //=========method to get Catageories from api=====
  CategoryModel? categoryModel;
  void getCategoryData() {
    emit(ShopLoadingCategoryDataState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }

  //========methos to add or delete a product to favourites====
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourite(int productId, BuildContext context) {
    if (favourites[productId] != null) {
      favourites[productId] = !favourites[productId]!;
    }

    emit(ShopLoadingChangeFavouriteDataState());
    DioHelper.postData(
      url: Favourites,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      //  print(changeFavouritesModel!.message);
      if (!changeFavouritesModel!.status) {
        favourites[productId] = !favourites[productId]!;
        buildToast(
          message: 'لم يتم الاضافة او الحذف من المفضلة يرجي المحاولة لاحقا',
          context: context,
          color: Colors.red,
        );
      } else {
        getFavouritesData();
      }
      emit(ShopSuccessChangeFavouriteDataState());
    }).catchError((error) {
      print(error.toString());
      favourites[productId] = !favourites[productId]!;
      buildToast(
        message: 'لم يتم الاضافة او الحذف من المفضلة يرجي المحاولة لاحقا',
        context: context,
        color: Colors.red,
      );

      emit(ShopErrorChangeFavouriteDataState());
    });
  }

  //=========method to get Favourite from api=====
  FavouriteModel? favouriteModel;
  void getFavouritesData() {
    emit(ShopLoadingFavouritesDataState());
    DioHelper.getData(
      url: Favourites,
      token: token,
    ).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(ShopSuccessFavouritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavouritesDataState());
    });
  }

//=======get profile data==========

  LoginModel? userData;

  void getProfileData() {
    emit(ShopLoadingProfileDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data!.name);
      emit(ShopSuccessProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProfileDataState());
    });
  }

  //=======update profile data==========

  void updateProfileData({
    required String name,
    required String email,
    required String phone,
    required BuildContext context,
  }) {
    emit(ShopLoadingUpdateProfileDataState());
    DioHelper.updateData(
      url: UPDATEPROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data!.name);
      buildToast(message: 'Updated Successfully', context: context);
      emit(ShopSuccessUpdateProfileDataState());
    }).catchError((error) {
      print(error.toString());
      buildToast(
          message: 'something went wrong ',
          color: Colors.red,
          context: context);

      emit(ShopErrorUpdateProfileDataState());
    });
  }

  //=====get category products===
  CategoryDetail? categoryDetail;
  void getCategoryProducts(int categoryId) {
    emit(ShopLoadingCategoryProductsDataState());
    DioHelper.getData(
      url: CATEGORIES + '/' + '$categoryId',
      token: token,
    ).then((value) {
      categoryDetail = CategoryDetail.fromJson(value.data);
      categoryDetail!.data!.data.forEach((element) {
        favourites.addAll({
          element.id: element.inFavourite,
        });
      });
      emit(ShopSuccessCategoryProductsDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryProductsDataState());
    });
  }

//=======change color of the heart=====
  Color heartColor(int id) {
    if (favourites[id] != null) {
      if (favourites[id]!) {
        return Colors.red;  
      } else {
        return Colors.grey;
      } 
    } else {
      return Colors.grey;
    }
  }

}
