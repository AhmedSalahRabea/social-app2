// ignore_for_file: override_on_non_overriding_member, sized_box_for_whitespace, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/models/shop_models/favourite_model.dart';

class FavourotiesItem extends StatelessWidget {
  final DataModel model;

  FavourotiesItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: CachedNetworkImageProvider(
                      model.favouriteProductData!.image),
                  // NetworkImage(model.favouriteProductData!.image,

                  width: 150,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
                if (model.favouriteProductData!.discount != 0)
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      model.favouriteProductData!.name,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${model.favouriteProductData!.price.toString()} EGP',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.deepOrange, fontSize: 12),
                      ),
                      if (model.favouriteProductData!.discount != 0)
                        Text(
                          '${model.favouriteProductData!.oldPrice.toString()} EGP',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourite(
                                model.favouriteProductData!.id, context);
                          },
                          icon: Icon(
                            Icons.favorite_sharp,
                            size: 18,
                            color: ShopCubit.get(context).heartColor(model.favouriteProductData!.id),
                            //  ShopCubit.get(context)
                            //         .favourites[model.favouriteProductData!.id]!
                            //     ? Colors.red
                            //     : Colors.grey,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

