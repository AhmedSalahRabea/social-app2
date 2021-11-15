// ignore_for_file: override_on_non_overriding_member, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/models/shop_models/home_model.dart';
import 'package:social_app/modules/shop_modules/product_screen/product_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ProductItem extends StatelessWidget {
  final ProductModel model;
  ProductItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context: context, screen: ProductScreen(model: model,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: CachedNetworkImageProvider(model.image),
                // NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
                // fit: BoxFit.fitWidth,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${model.price.round()} EGP',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.deepOrange, fontSize: 12),
                  ),
                  SizedBox(width: 5),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()} EGP',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                  IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavourite(model.id, context);
                      },
                      icon: Icon(
                        Icons.favorite_sharp,
                        size: 18,
                        color: ShopCubit.get(context).favourites[model.id]!
                            ? Colors.red
                            : Colors.grey,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
