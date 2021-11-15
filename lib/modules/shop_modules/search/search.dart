// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/widgets/general_widgets/my_divider.dart';
import 'package:social_app/shared/widgets/general_widgets/my_text_field.dart';

import 'package:social_app/shared/widgets/shop_app_widgets/searched_item.dart';

import 'cubit/search_cubit.dart';


class SearchScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MyTextFormField(
                      controller: textController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter your own search';
                        }
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onsubmit: (String text) {
                        cubit.searchProduct(text);
                      },
                      onchange: (text) {
                        cubit.searchProduct(text);
                      },
                    ),
                    SizedBox(height: 20),
                    if (state is SearchLoading) LinearProgressIndicator(),
                    BuildCondition(
                      condition: cubit.searchModel != null,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => SearchedItem(
                            model: cubit.searchModel!.data!.data[index],
                            index: index,
                          ),
                          separatorBuilder: (context, index) => MyDivider(),
                          itemCount: cubit.searchModel!.data!.data.length,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Please Enter your own search',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
