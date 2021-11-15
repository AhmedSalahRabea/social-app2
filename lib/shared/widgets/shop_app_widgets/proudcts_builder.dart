// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/shop_models/category_model.dart';
import 'package:social_app/models/shop_models/home_model.dart';

import 'package:social_app/shared/widgets/shop_app_widgets/category_item.dart';
import 'package:social_app/shared/widgets/shop_app_widgets/product_item.dart';


class ProuductsBuilder extends StatelessWidget {
  final HomeModel model;
  final CategoryModel categoryModel;
  ProuductsBuilder({required this.model, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.dataModel.banners.map((banner) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: FadeInImage(
                      height: double.minPositive,
                      placeholder: AssetImage('assets/images/imageloading.gif'),
                      image: CachedNetworkImageProvider(banner.image),
                      // NetworkImage(banner.image),
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                //autoPlayInterval: Duration(seconds: 1),
                // autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
                enlargeCenterPage: false,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Categories',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22),
              ),
            ),
            Container(
              height: 120,
              child: ListView.separated(
                itemBuilder: (context, index) => CategoryItem(
                  model: categoryModel.data.data[index],
                ),
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemCount: categoryModel.data.data.length,
                physics: BouncingScrollPhysics(),
                //  shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'New Products',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22),
              ),
            ),
            Container(
              // color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 12.0,
                childAspectRatio: 1 / 1.7,
                children: List.generate(
                  model.dataModel.products.length,
                  (index) =>
                      ProductItem(model: model.dataModel.products[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
