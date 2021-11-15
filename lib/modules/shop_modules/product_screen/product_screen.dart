// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/shop_models/category_details_model.dart';
import 'package:social_app/models/shop_models/home_model.dart';

import 'package:social_app/modules/shop_modules/search/search.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/widgets/general_widgets/my_divider.dart';



class ProductScreen extends StatelessWidget {
  final ProductModel? model;
  final CategoryProductItem? modelDetails;

  ProductScreen({this.model, this.modelDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dareen'),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context: context, screen: SearchScreen());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image(
                image: CachedNetworkImageProvider(model!.image),
                // NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
                // fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    model!.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'Product Price',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  Spacer(),
                  Text(
                    '${model!.price} EGY',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'Product OldPrice',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  Spacer(),
                  Text(
                    '${model!.oldPrice} EGY',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Description',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Here we can put our product description',
                    style: Theme.of(context).textTheme.bodyText1,
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
