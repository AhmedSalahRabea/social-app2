// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/models/shop_models/category_model.dart';
import 'package:social_app/modules/shop_modules/category_product_screen/category_product_screen.dart';
import 'package:social_app/shared/components/components.dart';

class CategoryItemDetails extends StatelessWidget {
  final DataModel model;

  const CategoryItemDetails({required this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          ShopCubit.get(context).getCategoryProducts(model.id);
          navigateTo(
              context: context,
              screen: CategoryProductScreen(
                title: model.name,
              ));
        },
        child: Row(
          children: [
            Image(
              image: CachedNetworkImageProvider(model.image),
              //   NetworkImage( model.image),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
