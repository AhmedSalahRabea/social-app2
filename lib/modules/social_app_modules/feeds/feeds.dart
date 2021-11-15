// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/widgets/social_app_widgets/post_item.dart';
import 'package:social_app/social_layout/cubit/social_cubit.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return BuildCondition(
          condition: cubit.posts.isNotEmpty && cubit.userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 7,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: CachedNetworkImageProvider(
                          'https://image.freepik.com/free-photo/outside-shot-sporty-dark-skinned-man-casual-clothing-runs-quickly-covers-long-distance-models-mountain-landscape-wants-reach-finish-first-athletic-ethnic-male-poses-outdoor_273609-29402.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 210,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('coummunicate with friends'),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PostItem(
                    postModel: cubit.posts[index],
                    userModel: cubit.userModel!,
                    postIndex: index,
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: cubit.posts.length,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
