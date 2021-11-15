// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, avoid_print

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/models/shop_models/user_data.dart';
import 'package:social_app/modules/shop_modules/profile_data/profile_data.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';


class SettingsScreen extends StatelessWidget {
  //bool value = true;
  UserData? model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(
              children: [
                // User card
                SizedBox(height: 30),
                SmallUserCard(
                  onTap: () {
                    navigateTo(context: context, screen: ProfileDataScreen());
                  },
                  cardColor: Colors.deepOrange,
                  userName: ShopCubit.get(context).userData!.data!.name,
                  userMoreInfo: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          ShopCubit.get(context).userData!.data!.phone,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          ShopCubit.get(context).userData!.data!.email,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  userProfilePic: AssetImage("assets/images/dareen.jpg"),
                ),
                SettingsGroup(
                  settingsGroupTitle: 'Mode',
                  settingsGroupTitleStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 22, color: Colors.deepOrange),
                  //  iconItemSize: 20,
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.deepOrange,
                      ),
                      title: 'Dark mode',
                      titleStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black, fontSize: 20),
                      subtitle: "Your Mode",
                      subtitleStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15, color: Colors.grey),
                      trailing: Switch.adaptive(
                        value: AppCubit.get(context).isDark,
                        onChanged: (value) {
                          AppCubit.get(context).changeAppMode();
                        },
                      ),
                    ),
                  ],
                ),
                SettingsGroup(
                  settingsGroupTitle: 'Update Profile',
                  settingsGroupTitleStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 22, color: Colors.deepOrange),
                  items: [
                    SettingsItem(
                      onTap: () {
                        navigateTo(
                            context: context, screen: ProfileDataScreen());
                      },
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'My information',
                      subtitle: "Update your data",
                      subtitleStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {
                        print('from about');
                      },
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about Dareen App",
                      subtitleStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                // You can add a settings title
                SettingsGroup(
                  settingsGroupTitle: 'Sign Out',
                  settingsGroupTitleStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 22, color: Colors.deepOrange),
                  items: [
                    SettingsItem(
                      onTap: () {
                        signOut(context);
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
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
