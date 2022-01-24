import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/model/message/message.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/message/widgets/dangerous_action_item.dart';
import 'package:hse/pageviews/message/widgets/dangerous_condition.dart';
import 'package:hse/pageviews/message/widgets/files_widget.dart';
import 'package:hse/pageviews/message/widgets/message_category_item.dart';
import 'package:hse/pageviews/message/widgets/status_widget.dart';
import 'package:hse/pageviews/message/widgets/taken_action_item.dart';
import 'package:hse/pageviews/message/widgets/violated_employee_item.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';

class MessageFormView extends StatefulWidget {
  const MessageFormView({Key key}) : super(key: key);

  @override
  _MessageFormViewState createState() => _MessageFormViewState();
}

class _MessageFormViewState extends State<MessageFormView> {
  Message message;
  MessageModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<MessageModel>(context);
    var category = model.entity?.category?.langValue != null
        ? ' (${model.entity.category.langValue})'
        : '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
            '${model.entity.requestNumber == ' ' ? 'Не зарегистрирован' + category : model.entity?.requestNumber ?? '' + category}'),
        // actions: [
        //   model.entity.status?.code == 'NEW'
        //       ? IconButton(
        //           icon: Icon(
        //             Icons.delete_forever,
        //             color: appWhiteColor,
        //           ),
        //           onPressed: () {
        //             showDialog(
        //               context: context,
        //               builder: (context) {
        //                 return AlertDialog(
        //                   title: Text('Отменение сообщение',
        //                       style: generalFontStyle.copyWith(
        //                           fontSize: defaultFontSize,
        //                           fontWeight: FontWeight.bold)),
        //                   content:
        //                       Text('Вы действительно хотите оменить сообщение?',
        //                           style: generalFontStyle.copyWith(
        //                             fontSize: defaultFontSize,
        //                           )),
        //                   actions: [
        //                     FlatButton(
        //                         onPressed: () => Navigator.pop(context, false),
        //                         child: Text(
        //                           'Отмена',
        //                           style: generalFontStyle.copyWith(
        //                               color: appBlueColor),
        //                         )),
        //                     FlatButton(
        //                       onPressed: () => Navigator.pop(context, true),
        //                       child: Text('Да'),
        //                       color: appRedColor,
        //                     )
        //                   ],
        //                   elevation: 24,
        //                 );
        //               },
        //             ).then((exit) async {
        //               if (exit == null || !exit) return;
        //               if (exit) {
        //                 //yes
        //                 print('deleted');
        //                 await model.cancelMessage(model.entity.id, true);
        //               }
        //               ;
        //             });
        //           },
        //         )
        //       : SizedBox()
        // ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          MessageStatusWidget(model.entity.status),
          info(),
          // model.entity.category.code == 'DC'
          //     ? dcList()
          //     : model.entity.category.code == 'OTHER'
          //         ? otherCategory()
          //         : model.entity.category.code == 'DA'
          //             ? Column(
          //                 children: [
          //                   peopleList(),
          //                   daList(),
          //                 ],
          //               )
          //             : SizedBox(),
         // pdList(),
          dopsv(),
          photos(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: GFButton(
              onPressed: () => Get.back(),
              text: S.current.back.toUpperCase(),
              textStyle: generalFontStyle.copyWith(
                  color: Colors.white,
                  fontSize: defaultFontSize + 10,
                  fontWeight: FontWeight.bold),
              color: appGreenColor,
              size: 52,
              blockButton: true,
            ),
          )
        ],
      )),
    );
  }

  Widget info() {
    return ExpansionTile(
      title: Text(S.current.generalInformation),
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        FieldBones(
          placeholder: S.current.legalEntity,
          textValue: model.entity.organization.organizationName ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
        ),
        FieldBones(
          placeholder: S.current.department,
          textValue: model.entity?.department?.departmentName ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
        ),
        FieldBones(
          placeholder: S.current.workplace,
          textValue: model.entity?.objectName?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
        ),
        //категорий
        // Container(
        //   height: 60,
        //   child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: model.categoryList.length,
        //       itemBuilder: (_, i) {
        //         return MessageCategoryItem(model, i);
        //       }),
        // )
      ],
    );
  }

  Widget dcList() {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(S.current.dangerousCondition),
      children: model.conditionCategoryList
          .map((e) => DangerousConditionCategoryItem(e, model, false))
          .toList(),
    );
  }

  Widget peopleList() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.offenders),
      children: [
        SizedBox(
          height: 8,
        ),
        ...model.entity.violatedEmployees
            .map((e) => ViolatedEmployeeItem(
                  person: e,
                  editable: false,
                ))
            .toList(),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  // Widget daList() {
  //   return ExpansionTile(
  //     initiallyExpanded: true,
  //     title: Text(S.current.dangerousAction),
  //     childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  //     children: [
  //       ...model.dangerousActionList
  //           .map((e) => DangerousActionItem(e, model, false))
  //     ],
  //   );
  // }

  Widget otherCategory() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.violationType),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        FieldBones(
          isRequired: true,
          placeholder: S.current.revealedDescription,
          hintText: S.current.commentRequired,
          textValue: model.entity.otherViolationComment,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(S.current.anonymously),
          value: model.entity.initiatorPrivacy,
          onChanged: (bool value) {},
        )
      ],
    );
  }

  Widget pdList() {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(S.current.intendedActions),
      children: model.takenActionList
          .map((e) => TakenActionItem(e, model, false))
          .toList(),
    );
  }

  Widget dopsv() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.additionalInfo),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        FieldBones(
          placeholder: S.current.comment,
          hintText: S.current.optional,
          textValue: model.entity.comment,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(S.current.anonymously),
          value: model.entity.initiatorPrivacy,
          onChanged: (bool value) {},
          // secondary: const Icon(Icons.lightbulb_outline),
        )
      ],
    );
  }

  Widget photos() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.photoFixation),
      // childrenPadding: EdgeInsets.only(left: 16),
      children: [
        FilesWidgetSlider(model, false),
      ],
    );
  }
}
