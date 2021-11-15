// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, must_be_immutable, sized_box_for_whitespace

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app_modules/login/social_login_screen.dart';
import 'package:social_app/modules/social_app_modules/register_screen/cubit/register_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/widgets/general_widgets/my_default_button.dart';
import 'package:social_app/shared/widgets/general_widgets/my_text_field.dart';
import 'package:social_app/shared/widgets/general_widgets/my_textbutton.dart';
import 'package:social_app/social_layout/social_layout.dart';

class SocialRegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterSocialCubit(),
        child: BlocConsumer<RegisterSocialCubit, RegisterSocialState>(
          listener: (context, state) {
            if (state is CreateAccountSocialSuccess) {
              navigateTo(context: context, screen: SocialLayout());
            }
          },
          builder: (context, state) {
            RegisterSocialCubit cubit = RegisterSocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 170,
                              width: double.infinity,
                              child: Image.asset('assets/images/login.png')),
                          Text(
                            'صفحة الإشتراك بالتطبيق',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 25),
                          ),
                          Text(
                            'قم بالتسجيل لتستمتع بجميع خدمات تطبيق دارين',
                            maxLines: 3,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                          ),
                          SizedBox(height: 10),
                          MyTextFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'من فضلك أدخل الإسم بشكل صحيح';
                                } else {
                                  return null;
                                }
                              },
                              label: 'الإسم',
                              prefix: Icons.person),
                          SizedBox(height: 20),
                          MyTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'من فضلك أدخل الايميل بشكل صحيح';
                              } else {
                                return null;
                              }
                            },
                            label: 'البريد اللإلكتروني',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(height: 20),
                          MyTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'من فضلك أدخل رفم سري صحيح';
                              } else {
                                return null;
                              }
                            },
                            label: 'الرقم السري',
                            prefix: Icons.lock_outline,
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changePasswordVisibilty();
                            },
                          ),
                          SizedBox(height: 20),
                          MyTextFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'من فضلك رقم الهاتف بشكل صحيح';
                                } else {
                                  return null;
                                }
                              },
                              label: 'رقم الهاتف',
                              onsubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    context: context,
                                  );
                                }
                              },
                              prefix: Icons.phone),
                          SizedBox(height: 20),
                          BuildCondition(
                            condition: state is! RegisterSocialLoading,
                            builder: (context) => MyDefaultButton(
                              text: 'التسجيل',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    context: context,
                                  );
                                }
                              },
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'لديك حساب بالفعل ؟',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              MyTextButton(
                                text: 'تسجيل الدخول',
                                fontSize: 16,
                                onpressed: () {
                                  navigateAndFinish(
                                      context: context,
                                      screen: SocialLoginScreen());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
