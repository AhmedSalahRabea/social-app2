// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/shared/widgets/general_widgets/my_divider.dart';
import 'package:social_app/shared/widgets/shop_app_widgets/category_product_item.dart';


class CategoryProductScreen extends StatelessWidget {
  final String title;

   CategoryProductScreen({required this.title}) ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
      body: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return BuildCondition(
            condition: state is! ShopLoadingCategoryProductsDataState &&
                cubit.categoryDetail!.data!.data.isNotEmpty,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => CategoryProductsItem(
                  model: cubit.categoryDetail!.data!.data[index]),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: cubit.categoryDetail!.data!.data.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
