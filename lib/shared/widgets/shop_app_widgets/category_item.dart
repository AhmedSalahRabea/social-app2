// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/models/shop_models/category_model.dart';
import 'package:social_app/modules/shop_modules/category_product_screen/category_product_screen.dart';
import 'package:social_app/shared/components/components.dart';

class CategoryItem extends StatelessWidget {
  final DataModel model;

  const CategoryItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getCategoryProducts(model.id);
          navigateTo(context: context, screen: CategoryProductScreen(title:model.name));
      },
      child: Container(
        height: 100,
        width: 120,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image:CachedNetworkImageProvider(model.image),
              // NetworkImage(model.image),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(.8),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
