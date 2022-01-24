// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getflutter/components/button/gf_icon_button.dart';
// import 'package:getflutter/components/loader/gf_loader.dart';
// import 'package:getflutter/getflutter.dart';
// import 'package:hse/core/model/utils/ToDoList.dart';
// import 'package:hse/core/utils/globals.dart';
// import 'package:hse/generated/l10n.dart';
// import 'package:hse/core/utils/UI_Helpers.dart';
// import 'package:hse/pageviews/home/home_page_widgets.dart';
// import 'package:hse/viewmodels/home_model.dart';
// import 'package:provider/provider.dart';
//
// //Меню приложения
// class AppDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final counter = Provider.of<Home>(context);
//     return FutureProvider<ToDoList>(
//         initialData: null,
//         create: (BuildContext context) => counter.toDoList,
//         child: Consumer<ToDoList>(builder: (context, model, _) {
//           var cards = getCards(
//               todo: model, isDrawer: !isDesktop(context), context: context);
//           return model == null
//               ? GFLoader()
//               : Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Drawer(
//                     elevation: 10,
//                     child: Container(
//                       color: isDesktop(context)
//                           ? appWhiteColor
//                           : Theme.of(context).primaryColor,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black45,
//                                     blurRadius: 3,
//                                     offset: Offset(0.0, 1.0), //(x,y)
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 10.0, top: 10.0),
//                                     child: Text(
//                                       S().menu,
//                                       style: generalFontStyle.copyWith(
//                                           fontSize: defaultFontSize + 5,
//                                           color: appWhiteColor),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 10.0, top: 0.0),
//                                     child: GFIconButton(
//                                       onPressed: () => Get.back(),
//                                       color: Theme.of(context).primaryColor,
//                                       icon: Icon(
//                                         Icons.clear,
//                                         size: GFSize.MEDIUM,
//                                       ),
//                                       size: GFSize.MEDIUM,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SingleChildScrollView(
//                               child: isDesktop(context)
//                                   ? Wrap(
//                                       children: cards,
//                                     )
//                                   : Column(
//                                       children: cards,
//                                     ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//         }));
//   }
// }
