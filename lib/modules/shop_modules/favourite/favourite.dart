// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/shared/widgets/general_widgets/my_divider.dart';
import 'package:social_app/shared/widgets/shop_app_widgets/favourite_item.dart';


class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return BuildCondition(
          condition: state is! ShopLoadingFavouritesDataState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                FavourotiesItem(model: cubit.favouriteModel!.data!.data[index]),
            separatorBuilder: (context, index) => MyDivider(),
            itemCount: cubit.favouriteModel!.data!.data.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
