// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:tbib_toast/tbib_toast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  required String text,
  required VoidCallback function,
}) {
  return Container(
    width: width,
    //padding: EdgeInsets.symmetric(vertical: 40),
    // color: backgroundColor,
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      onPressed: function,
      color: backgroundColor,
      elevation: 10,

      // color: Colors.blue,
    ),
  );
}

Widget defaulFormField({
  required TextEditingController controller,
  required TextInputType type,
  // Function? onSubmit,
  // Function? onChange,
  //Function? ontap,
  onSubmit,
  ValueChanged? onchange,
  ontap,
  bool isPassword = false,
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    //(s) {
    // onSubmit== null ? (){} : onSubmit(s);
    //onSubmit!(s);
    // },
    onChanged: onchange,
    // (s) {
    // onChange == null ? (){} : onChange(s);
    //onChange!(s);
    // },
    onTap: ontap,
    //  () {
    //   ontap == null ? (){} : ontap();
    // },
    validator: validate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      border: OutlineInputBorder(),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: Icon(suffix))
          : null,
    ),
  );
}

// Widget buildTaskItem(Map model, context) {
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Dismissible(
//       key: Key(model['id'].toString()),
//       onDismissed: (DismissDirection direction) {
//         AppCubit.get(context).deleteData(
//           id: model['id'],
//         );
//       },
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 37,
//             child: Text('${model['time']}'),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   '${model['title']}',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   '${model['date']}',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 20),
//           IconButton(
//               onPressed: () {
//                 print(model['id']);
//                 AppCubit.get(context).updateData(
//                   status: 'done',
//                   id: model['id'],
//                 );
//               },
//               icon: Icon(
//                 Icons.check_box,
//                 color: Colors.green,
//               )),
//           IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData(
//                   status: 'archive',
//                   id: model['id'],
//                 );
//               },
//               icon: Icon(
//                 Icons.archive,
//                 color: Colors.black45,
//               )),
//         ],
//       ),
//     ),
//   );
// }

// Widget tasksBuilder({
//   required List<Map> tasks,
// }) {
//   return BuildCondition(
//     condition: tasks.isNotEmpty,
//     builder: (context) => ListView.separated(
//       itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//       separatorBuilder: (context, index) => Divider(
//         color: Colors.blue,
//         endIndent: 20,
//         indent: 20,
//         thickness: 1.5,
//         // height: 200,
//       ),
//       //  Container(
//       //   // width: 5,
//       //   height: 3.0,
//       //   color: Colors.blue[300],
//       // ),
//       itemCount: tasks.length,
//     ),
//     fallback: (context) => Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const [
//           Icon(
//             Icons.menu,
//             size: 100,
//             color: Colors.grey,
//           ),
//           Text(
//             'No tasks added yet , please add tasks',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget myDivider() {
  return Divider(
    color: Colors.deepOrange,
    endIndent: 20,
    indent: 20,
    thickness: 1.5,
    // height: 200,
  );
}

//  Widget buildArticleItem(Map<String, dynamic> article, BuildContext context) {
//   return InkWell(
//     onTap: () {
//       navigateTo(
//         context: context,
//         screen: WebViewScreen(
//           url: article['url'],
//         ),
//       );
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(
//                 image: NetworkImage(
//                     '${article['urlToImage'] ?? 'https://t3.ftcdn.net/jpg/00/36/94/26/360_F_36942622_9SUXpSuE5JlfxLFKB1jHu5Z07eVIWQ2W.jpg'}'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Expanded(
//             child: Container(
//               height: 120,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '${article['title']}',
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                   ),
//                   Text(
//                     '${article['publishedAt']}',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       //fontSize: 18.0,
//                       //fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//  Widget aricleBuilder(list, context, {bool isSearch = false}) {
//   return BuildCondition(
//     condition: list.isNotEmpty,
//     builder: (context) => ListView.separated(
//       physics: BouncingScrollPhysics(),
//       itemBuilder: (context, index) => buildArticleItem(list[index], context),
//       separatorBuilder: (context, index) => myDivider(),
//       itemCount: list.length,
//     ),
//     fallback: (context) {
//       return Center(
//         child: isSearch ? Container() : CircularProgressIndicator(),
//       );
//     },
//   );
// }

//this method to navigate between screens
void navigateTo({required context, required screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void navigateAndFinish({required context, required screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (Route<dynamic> route) => false,
  );
}

void buildToast({
  required String? message,
  required BuildContext context,
  Color color = Colors.green,
  int position = 1,
}) {
  return Toast.show(
    message??'',
    context,
    duration: Toast.lengthLong,
    gravity: position,
    backgroundColor: color,
    backgroundRadius: 25,
  );
  //  Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: color,
  //     textColor: Colors.white,
  //     fontSize: 16.0);
}
