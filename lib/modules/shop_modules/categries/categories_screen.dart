// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/shared/widgets/general_widgets/my_divider.dart';
import 'package:social_app/shared/widgets/shop_app_widgets/category_item_details.dart';


class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) =>
              CategoryItemDetails(model: cubit.categoryModel!.data.data[index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: cubit.categoryModel!.data.data.length,
        );
      },
    );
  }
}
