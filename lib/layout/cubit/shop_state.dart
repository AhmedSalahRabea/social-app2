part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

//======when change in bottom navigation bar=====
class ShopChangeBottomNavBar extends ShopState {}

//=========Home Data Loadded or no =======

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

//=========Category Data Loadded or no =======

class ShopLoadingCategoryDataState extends ShopState {}

class ShopSuccessCategoryDataState extends ShopState {}

class ShopErrorCategoryDataState extends ShopState {}

//========= add or delete product from favourites =======

class ShopLoadingChangeFavouriteDataState extends ShopState {}

class ShopSuccessChangeFavouriteDataState extends ShopState {}

class ShopErrorChangeFavouriteDataState extends ShopState {}

//========= GET favourites from api =======

class ShopLoadingFavouritesDataState extends ShopState {}

class ShopSuccessFavouritesDataState extends ShopState {}

class ShopErrorFavouritesDataState extends ShopState {}

//========= GET user Profile data from api =======

class ShopLoadingProfileDataState extends ShopState {}

class ShopSuccessProfileDataState extends ShopState {}

class ShopErrorProfileDataState extends ShopState {}

//========= UPDATE user Profile data from api =======

class ShopLoadingUpdateProfileDataState extends ShopState {}

class ShopSuccessUpdateProfileDataState extends ShopState {}

class ShopErrorUpdateProfileDataState extends ShopState {}
//=======to change favourite button in searvh items
class ChangeFavourite extends ShopState {}

//========= get category products  from api =======

class ShopLoadingCategoryProductsDataState extends ShopState {}

class ShopSuccessCategoryProductsDataState extends ShopState {}

class ShopErrorCategoryProductsDataState extends ShopState {}

//========= change herat color =======

class ShopSuccessChangeHeartColorState extends ShopState {}

class ShopErrorChangeHeartColorState extends ShopState {}
