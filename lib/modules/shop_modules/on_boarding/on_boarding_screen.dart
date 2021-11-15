// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:social_app/modules/shop_modules/login/shop_login_screen.dart';
import 'package:social_app/modules/shop_modules/on_boarding/cubit/onboarding_cubit.dart';
import 'package:social_app/modules/shop_modules/on_boarding/on_boarding_item.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/widgets/general_widgets/my_textbutton.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OnboardingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: MyTextButton(
                  text: 'تخطي',
                  onpressed: () {
                    cubit.checkOnBoardingState(context: context);
                    navigateTo(context: context, screen: ShopLoginScreen());
                  },
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) =>
                        OnBoardingItem(model: cubit.boarding[index]),
                    itemCount: cubit.boarding.length,
                    physics: BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (index) {
                      if (index == cubit.boarding.length - 1) {
                        cubit.isLast = true;
                      } else {
                        cubit.isLast = false;
                      }
                    },
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: cubit.boarding.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 20,
                        activeDotColor: Colors.deepOrange,
                        radius: 10,
                        dotWidth: 20,
                      ),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (cubit.isLast) {
                          navigateTo(context: context, screen: ShopLoginScreen());
                        } else {
                          boardController.nextPage(
                              duration: Duration(milliseconds: 2000),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
