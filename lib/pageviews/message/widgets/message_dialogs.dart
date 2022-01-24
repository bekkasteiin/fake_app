//
// import 'package:flutter/material.dart';
// import 'package:hse/core/utils/UI_Helpers.dart';
// import 'package:hse/core/utils/globals.dart';
// import 'package:hse/core/utils/local_icon_data.dart';
// import 'package:hse/viewmodels/bpm_models/message_model.dart';
//
// import 'object_item.dart';
//
// class MessageDialogs {
//
//   static void objects(MessageModel model, BuildContext context, size) {
//     var hasData = model.entity.department.objectName != null &&
//         model.entity.department.objectName.isNotEmpty;
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         elevation: 0.6,
//         isDismissible: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         backgroundColor: Colors.white,
//         builder: (context) {
//           return Container(
//             color: Colors.transparent,
//             height: size.height * (hasData ? 0.7 : 0.3),
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 10),
//                   child: Container(
//                     height: 5,
//                     width: size.width / 5,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: appBlueColor.withOpacity(0.4),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     'Выберите департамент из список',
//                     style: generalFontStyle.copyWith(
//                         fontWeight: FontWeight.bold,
//                         fontSize: defaultFontSize + 2),
//                     textAlign: TextAlign.center,
//                   ),
//                   decoration: BoxDecoration(
//                     color: appWhiteColor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 1,
//                         offset: Offset(0, 2), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                     child: hasData
//                         ? Scrollbar(
//                       child: ListView.separated(
//                         // controller: _scrollController,
//                           shrinkWrap: true,
//                           physics: ScrollPhysics(),
//                           itemBuilder: (context, i) {
//                             var current = false;
//                             if (model.entity.department != null &&
//                                 model.entity.objectName != null) {
//                               current = model.entity.department
//                                   .objectName[i].id ==
//                                   model.entity.objectName.id;
//                             }
//                             return InkWell(
//                               child: ObjectItem(
//                                   model.entity.department.objectName[i],
//                                   current),
//                               onTap: () => setState(() {
//                                 model.entity.objectName =
//                                 model.entity.department.objectName[i];
//                                 Get.back();
//                               }),
//                             );
//                           },
//                           separatorBuilder: (context, index) => Divider(
//                             height: 1,
//                           ),
//                           itemCount: model
//                               .entity.department.objectName?.length ??
//                               0),
//                     )
//                         : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           LocalIconData.noData,
//                           height: size.width / 8,
//                           width: size.width / 8,
//                         ),
//                         Text(
//                           'нет данных',
//                           style: generalFontStyle.copyWith(
//                               color: appDarkGrayColor,
//                               fontSize: defaultFontSize),
//                         ),
//                       ],
//                     ))
//               ],
//             ),
//           );
//         });
//   }
// }