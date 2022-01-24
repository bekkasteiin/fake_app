import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/service/file_service.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_observations_edit.dart';
import 'package:hse/pageviews/bsa/widgets/files_widget.dart';
import 'package:hse/pageviews/bsa/widgets/violated_employee_item.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

class BsaPlanedForm extends StatefulWidget {
  final bool update;

  const BsaPlanedForm({
    this.update = false,
  });

  @override
  _BsaPlanedFormState createState() => _BsaPlanedFormState();
}

class _BsaPlanedFormState extends State<BsaPlanedForm> {
  UserInfoModel userModel;
  var size;
  BsaModel model;
  // ScrollController scrollController;
  //
  // @override
  // void initState() {
  //   scrollController = ScrollController();
  //   scrollController.addListener(hideKeyboard);
  //   super.initState();
  // }
  //
  // hideKeyboard() {
  //   FocusScope.of(context).requestFocus(FocusNode());
  // }
  //
  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    model = Provider.of<BsaModel>(context);
    userModel = Provider.of<UserInfoModel>(context);
    model.entity.organization ??= userModel.assign.organization;
    model.entity.department ??= userModel.assign.department;
    var isAfter = model.entity.planDate.isAfter(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.update
                ? '${S.current.plannedBsa} ${model.entity.regNumber}'
                : ''
            //semanticsLabel: '${model.entity?.category?.langValue != null ? "(${model.entity.category.langValue})" : ''}'
            ),
      ),
      body: SingleChildScrollView(
        // controller: scrollController,
        child: Column(
          children: [
            isAfter
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration:
                        BoxDecoration(color: appDarkGrayColor.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.availableFrom,
                          style: generalFontStyle,
                        ),
                        Text(
                          formatFullRestNotMilSec(model.entity.planDate),
                          style: generalFontStyle.copyWith(
                              fontSize: 16,
                              height: 2,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            info(),
            auditList(),
            isAfter
                ? Padding(
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
                : Column(
                    children: [
                      //description(),
                      SizedBox(height: 10),
                      photos(),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: GFButton(
                            onPressed: () {
                              model.entity.filled = true;
                              model.entity.isDone = false;
                              model.saveEntity(update: true);
                            },
                            text: S.current.register.toUpperCase(),
                            textStyle: generalFontStyle.copyWith(
                                color: Colors.white,
                                fontSize: defaultFontSize + 10,
                                fontWeight: FontWeight.bold),
                            color: appGreenColor,
                            size: 52,
                            blockButton: true,
                          ),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
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
          textValue: model.entity?.organization?.organizationName ?? '',
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
      ],
    );
  }

  Widget auditList() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.auditors),
      children: [
        model.entity.responsibles != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: model.entity.responsibles
                    .map(
                      (e) => ViolatedEmployeeBsaItem(
                        person: e,
                        editable: false,
                      ),
                    )
                    .toList(),
              )
            : SizedBox(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget description() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.observationDescription),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        FieldBones(
            placeholder: S.current.workType,
            textValue: model.entity?.workType ?? '',
            isTextField: true,
            maxLines: 1,
            onChanged: (val) {
              model.entity.workType = val;
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.auditDuration,
              style: generalFontStyle,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(right: 5, bottom: 5),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: appDarkGrayColor, width: 0.5)),
              child: TextField(
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: model.entity?.duration?.toString() ?? '',
                      contentPadding: EdgeInsets.all(8.0),
                      hintStyle:
                          generalFontStyle.copyWith(color: appBlackColor)),
                  maxLines: 1,
                  onChanged: (val) {
                    var value = int.parse(val);
                    model.entity.duration = value;
                  },
                  style: generalFontStyle.copyWith(color: appBlackColor)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.observed,
              style: generalFontStyle,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(right: 5, bottom: 5),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: appDarkGrayColor, width: 0.5)),
              child: TextFormField(
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: model.entity?.watchedQuantity != null
                        ? model.entity?.watchedQuantity.toString()
                        : '',
                    contentPadding: EdgeInsets.all(8.0),
                    hintStyle: generalFontStyle.copyWith(color: appBlackColor)),
                maxLines: 1,
                onChanged: (val) {
                  var value = int.parse(val);
                  model.entity.watchedQuantity = value;
                },
                style: generalFontStyle.copyWith(color: appBlackColor),
              ),
            ),
          ],
        ),
        Column(
          children: model.observationsList.map(
            (e) {
              return Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () async {
                        await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BsaObservationsEdit(model, e)))
                            .then((value) => setState(() {}));
                      },
                      leading: Text(e.langValue,
                          style:
                              generalFontStyle.copyWith(color: appBlackColor)),
                      trailing: model.chekObservation(e)
                          ? Icon(Icons.check_box_outlined,
                              color: appGreenColor, size: 35)
                          : Icon(
                              Icons.check_box_outline_blank_outlined,
                              size: 35,
                            )),
                  Divider(
                    height: 1,
                  )
                ],
              );
              // ObservationItemCreate(model, index);
            },
          ).toList(),
        ),
        SizedBox(height: 15.0),
        FieldBones(
            placeholder: S.current.correctiveAction,
            hintText: '${S.current.comment}...',
            isRequired: true,
            textValue: model.entity?.actionDescription ?? '',
            isTextField: true,
            maxLines: 3,
            onChanged: (val) {
              model.entity.actionDescription = val;
            }),
        FieldBones(
            placeholder: S.current.employeesOffer,
            hintText: '${S.current.comment}...',
            textValue: model.entity?.empComment ?? '',
            isTextField: true,
            maxLines: 3,
            onChanged: (val) {
              model.entity.empComment = val;
            }),
      ],
    );
  }

  Widget photos() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.photoFixation),
      childrenPadding: EdgeInsets.symmetric(horizontal: 0),
      children: [
        InkWell(
          child: Icon(
            Icons.add_circle_outline_outlined,
            size: 40,
            color: appBlueColor.withOpacity(0.7),
          ),
          onTap: () => pickerFileDialog(),
        ),
        SizedBox(height: 8),
        BsaFilesWidgetSlider(model),
      ],
    );
  }

  // ignore: always_declare_return_types
  pickerFileDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Get.back();
                    var file = await FileService.getImageCamera();
                    if (file != null) {
                      await model.saveFile(file);
                    }
                    setState(() {});
                  },
                  child: Text(S.current.camera)),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    Get.back();
                    var file = await FileService.getImage();
                    if (file != null) {
                      await model.saveFile(file);
                    }
                    setState(() {});
                  },
                  child: Text(S.current.photo)),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                S.current.canceling,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          );
        });
  }
}
