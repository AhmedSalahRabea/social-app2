// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/shop_cubit.dart';
import 'package:social_app/shared/widgets/general_widgets/my_default_button.dart';
import 'package:social_app/shared/widgets/general_widgets/my_text_field.dart';



class ProfileDataScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ShopCubit.get(context);
            emailController.text = cubit.userData!.data!.email;
            nameController.text = cubit.userData!.data!.name!;
            PhoneController.text = cubit.userData!.data!.phone;
            return BuildCondition(
              condition: cubit.userData != null,
              builder: (context) => SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is ShopLoadingUpdateProfileDataState)
                        LinearProgressIndicator(),
                      SizedBox(height: 20),
                      MyTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Name should not be empty';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(height: 20),
                      MyTextFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Email should not be empty';
                          }
                        },
                        label: 'Email',
                        prefix: Icons.email,
                      ),
                      SizedBox(height: 20),
                      MyTextFormField(
                        controller: PhoneController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Phone should not be empty';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.call,
                      ),
                      SizedBox(height: 20),
                      MyDefaultButton(
                        text: 'Update Data',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateProfileData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: PhoneController.text,
                              context: context,
                            );
                          }
                          // navigateTo(
                          //     context: context, screen: SettingsScreen());
                          //cubit.getProfileData();
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
