// ignore_for_file: prefer_const_constructors,, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/modules/shop_modules/search/search.dart';
import 'package:social_app/shared/components/components.dart';


class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dareen'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context: context, screen: SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
             
            ],
          ),
          body: cubit.screens[cubit.currebIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currebIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
          ),
        );
      },
    );
  }
}
