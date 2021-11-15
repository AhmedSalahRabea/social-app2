// ignore_for_file: override_on_non_overriding_member, sized_box_for_whitespace, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/models/shop_models/search_model.dart';

class SearchedItem extends StatelessWidget {
  final SearchedProductData model;
  final int index;

  SearchedItem({required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Image(
              image: CachedNetworkImageProvider(model.image),
              width: 130,
              height: 200.0,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      model.name,
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
                        '${model.price.toString()} EGP',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.deepOrange, fontSize: 12),
                      ),
                      BlocConsumer<ShopCubit, ShopState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavourite(model.id, context);
                              print('====model id ${model.id}');
                            },
                            icon: Icon(
                              Icons.favorite_sharp,
                              size: 18,
                              color: (ShopCubit.get(context)
                                          .favourites[model.id] !=
                                      null)
                                  ? ShopCubit.get(context).favourites[model.id]!
                                      ? Colors.red
                                      : Colors.grey
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
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
