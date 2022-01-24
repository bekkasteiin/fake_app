import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/companents/widgets/no_data.dart';
import 'package:hse/core/service/file_service.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_observations_edit.dart';
import 'package:hse/pageviews/bsa/widgets/files_widget.dart';
import 'package:hse/pageviews/message/widgets/department_item.dart';
import 'package:hse/pageviews/message/widgets/object_item.dart';
import 'package:hse/pageviews/bsa/widgets/violated_employee_item.dart';
import 'package:hse/pageviews/message/widgets/violated_employee_item.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

class BsaFormEdit extends StatefulWidget {
  final bool update;

  const BsaFormEdit({
    this.update = false,
  });

  @override
  _BsaFormEditState createState() => _BsaFormEditState();
}

class _BsaFormEditState extends State<BsaFormEdit> {
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
    // model.entity.department ??= userModel.assign.department;
    model.entity.watchedQuantity = model.entity.responsibles.length.toInt();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.update
                ? S.current.changeBsa
                : S.current.newBsa
            //semanticsLabel: '${model.entity?.category?.langValue != null ? "(${model.entity.category.langValue})" : ''}'
            ),
        actions: [
          widget.update
              ? IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: appWhiteColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      S.current.deleteBsa,
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      S.current.confirmDeleteBsa,
                      style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize,
                      ),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(
                            'Отмена',
                            style: generalFontStyle.copyWith(
                                color: appBlueColor),
                          )),
                      FlatButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(S.current.delete),
                        color: appRedColor,
                      )
                    ],
                    elevation: 24,
                  );
                },
              ).then((exit) async {
                if (exit == null || !exit) return;
                if (exit) {
                  //yes
                  print('deleted');
                  await model.delete();
                }
              });
            },
          )
              : SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        // controller: scrollController,
        child: Column(
          children: [
            info(),
            auditList(),
            description(),
            SizedBox(height: 10),
            photos(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: GFButton(
                onPressed: () {
                  model.saveEntity(update: widget.update);
                },
                text: 'Зарегистрировать'.toUpperCase(),
                textStyle: generalFontStyle.copyWith(
                    color: Colors.white,
                    fontSize: defaultFontSize + 10,
                    fontWeight: FontWeight.bold),
                color: appGreenColor,
                size: 52,
                blockButton: true,
              ),
            ),
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
          isRequired: true,
          placeholder: S.current.department,
          textValue: model.entity?.department?.departmentName ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => getDepartments(),
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.workplace,
          textValue: model.entity?.objectName?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => objects(),
        ),
      ],
    );
  }

  Widget auditList() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.auditors),
      children: [
        InkWell(
          child: Icon(
            Icons.add_circle_outline_outlined,
            size: 40,
            color: appBlueColor.withOpacity(0.7),
          ),
          onTap: () => violatedEmployess(),
        ),
        SizedBox(
          height: 16,
        ),
        model.entity.responsibles != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: model.entity.responsibles
                    .map(
                      (e) => ViolatedEmployeeBsaItem(
                        person: e,
                        remove: () => setState(() {
                          model.entity.responsibles.remove(e);
                        }),
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
              padding: EdgeInsets.all(8),
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: appDarkGrayColor, width: 0.5)),
              child: Text(
                model.entity.responsibles.length.toString(),
                textAlign: TextAlign.end,
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
                          style: generalFontStyle.copyWith(color: appBlackColor)),
                      trailing: model.chekObservation(e)
                          ? Icon(Icons.check_box_outlined,
                          color: appGreenColor, size: 35)
                          : Icon(
                        Icons.check_box_outline_blank_outlined,
                        size: 35,
                      )),
                  Divider(height: 2,)
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
          textValue: model.entity?.actionDescription ?? '',
          isTextField: true,
          maxLines: 3,
          onChanged: (val) {
            model.entity.actionDescription = val;
          },
          isRequired: true,
        ),
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

  // ignore: always_declare_return_types
  getDepartments() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * 0.7,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 5,
                    width: size.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appBlueColor.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    S.current.chooseDepartment,
                    style: generalFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultFontSize + 2),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          var current = false;
                          if (model.entity.department != null) {
                            current =
                                userModel.organization.departments[i].id ==
                                    model.entity.department.id;
                          }
                          return InkWell(
                            child: DepartmentItem(
                                userModel.organization.departments[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.department =
                                    userModel.organization.departments[i];
                                model.entity.objectName = null;
                                model.entity.responsibles = [];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              height: 1,
                            ),
                        itemCount: userModel.organization.departments.length),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // ignore: always_declare_return_types
  objects() {
    var hasData = model.entity.department.objectName != null &&
        model.entity.department.objectName.isNotEmpty;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * (hasData ? 0.7 : 0.3),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 5,
                    width: size.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appBlueColor.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.current.chooseDepartment,
                    style: generalFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultFontSize + 2),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: hasData
                      ? Scrollbar(
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, i) {
                                var current = false;
                                if (model.entity.department != null &&
                                    model.entity.objectName != null) {
                                  current = model
                                          .entity.department.objectName[i].id ==
                                      model.entity.objectName.id;
                                }
                                return InkWell(
                                  child: ObjectItem(
                                      model.entity.department.objectName[i],
                                      current),
                                  onTap: () => setState(() {
                                    model.entity.objectName =
                                        model.entity.department.objectName[i];
                                    Get.back();
                                  }),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                    height: 1,
                                  ),
                              itemCount:
                                  model.entity.department.objectName?.length ??
                                      0),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              LocalIconData.noData,
                              height: size.width / 8,
                              width: size.width / 8,
                            ),
                            Text(
                              'нет данных',
                              style: generalFontStyle.copyWith(
                                  color: appDarkGrayColor,
                                  fontSize: defaultFontSize),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        });
  }

  // ignore: always_declare_return_types
  violatedEmployess() {
    var hasData = model.entity?.department?.employees != null &&
        model.entity.department.employees.isNotEmpty;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * (hasData ? 0.7 : 0.3),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 5,
                    width: size.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appBlueColor.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.current.chooseAuditors,
                    style: generalFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultFontSize + 2),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: hasData
                        ? Scrollbar(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  var current = false;
                                  if (model.entity.responsibles.isNotEmpty) {
                                    current = model.entity.responsibles
                                        .contains(model
                                            .entity.department.employees[i]);
                                  }
                                  return ViolatedEmployeeItem(
                                    person:
                                        model.entity.department.employees[i],
                                    current: current,
                                    isPop: true,
                                    editable: false,
                                    onTapPop: () => setState(() {
                                      if (!current) {
                                        model.entity.responsibles.add(model
                                            .entity.department.employees[i]);
                                      }
                                      Get.back();
                                    }),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    Divider(height: 1),
                                itemCount:
                                    model.entity.department.employees?.length ??
                                        0),
                          )
                        : NoDataWidget(size)),
              ],
            ),
          );
        });
  }
}
