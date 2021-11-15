// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print
// ignore: prefer_const_literals_to_create_immutables

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app_modules/register_screen/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/widgets/general_widgets/my_default_button.dart';
import 'package:social_app/shared/widgets/general_widgets/my_text_field.dart';
import 'package:social_app/shared/widgets/general_widgets/my_textbutton.dart';
import 'package:social_app/social_layout/social_layout.dart';

import 'cubit/login_cubit.dart';

class SocialLoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginSocialCubit(),
      child: BlocConsumer<LoginSocialCubit, LoginSocialState>(
        listener: (context, state) {
          if (state is LoginSocialSuccess) {
            CacheHelper.saveDataInSharedPrefrences(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              buildToast(message: 'login successfully', context: context);
              navigateAndFinish(context: context, screen: SocialLayout());
            }).catchError((error) {
              print(error.toString());
            });
          }
        },
        builder: (context, state) {
          LoginSocialCubit cubit = LoginSocialCubit.get(context);
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
                          'صفحة تسجيل الدخول',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 25),
                        ),
                        Text(
                          '  للتواصل مع اصدقائك قم بتسجيل الدخول لتستمتع بجميع خدمات تطبيق دارين',
                          maxLines: 3,
                          textAlign: TextAlign.right,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                        ),
                        SizedBox(height: 30),
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
                        SizedBox(height: 30),
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
                          onsubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              );
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
                        SizedBox(height: 30),
                        BuildCondition(
                          condition: state is! LoginSocialLoading,
                          builder: (context) => MyDefaultButton(
                            text: 'تسجيل الدخول',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
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
                              'لا يوجد لديك حساب ؟ ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            MyTextButton(
                              text: 'إنشاء حساب جديد ',
                              fontSize: 16,
                              onpressed: () {
                                navigateTo(
                                    context: context,
                                    screen: SocialRegisterScreen());
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
    );
  }
}
