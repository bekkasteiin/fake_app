import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/service/file_service.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/pageviews/message/widgets/department_item.dart';
import 'package:hse/pageviews/message/widgets/object_item.dart';
import 'package:hse/pageviews/risks/widgets/files_widget.dart';
import 'package:hse/pageviews/risks/widgets/risk_widget.dart';
import 'package:hse/pageviews/risks/widgets/risks_condition.dart';
import 'package:hse/pageviews/risks/widgets/risks_probabilities.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';

class RisksManagementFormEdit extends StatefulWidget {
  final bool update;

  const RisksManagementFormEdit({this.update = false});

  @override
  _RisksManagementFormEditState createState() => _RisksManagementFormEditState();
}

class _RisksManagementFormEditState extends State<RisksManagementFormEdit> {
  UserInfoModel userModel;
  var size;
  RisksModel model;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    model = Provider.of<RisksModel>(context);
    userModel = Provider.of<UserInfoModel>(context);
    model.entity.organization ??= userModel.assign.organization;
    // model.entity.department ??= userModel.assign.department;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:  Text(widget.update
            ? S.current.changeAssessment
            : S.current.newAssessment),
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
                      S.current.deleteAssessment,
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      S.current.confirmDeleteAssessment,
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
                  await model.delete();
                }
              });
            },
          )
              : SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            info(),
            probability(),
            riskManageability(),
            SizedBox(height: 10),
            photos(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: GFButton(
                onPressed: () {
                  model.saveEntity(update: widget.update);
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
          ],),
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
          isRequired: true,
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
        FieldBones(
          isRequired: true,
          placeholder: S.current.operationType,
          textValue: model.entity?.actionType?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => actionType(),
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.dangerSourceCategory,
          textValue: model.entity?.dangerousCategory?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => dangerousCategories(),
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.dangerSource,
          textValue: model.entity?.dangerousSource?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => dangerousSources(),
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.consequenceRisk,
          textValue: model.entity?.consequences?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => consequences(),
        ),
      ],);
  }

  Widget probability() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.probabilityAssessment),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: model.riskProbabilities.map((e){
            var current = false;
            if (model.entity.probability != null) {
              current = e.id == model.entity.probability.id;
            }
            return InkWell(
              child: RisksProbabilitiesItem(e, model, current),
              onTap: () => setState(() {
                if (!current) {
                  model.entity.probability = e;
                }
              }),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget riskManageability() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.riskManagement),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        Column(children: model.riskManageabilities
              .map((e) => RisksConditionCategoryItem(e, model))
              .toList(),),
        FieldBones(
            placeholder: S.current.comment,
            hintText: '${S.current.comment}...',
            textValue: model.entity?.comment ?? '',
            isTextField: true,
            maxLines: 3,
            onChanged: (val) {
              model.entity.comment = val;
            }),
      ],);
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
        RisksFilesWidgetSlider(model),
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
                        offset: Offset(0, 2),
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
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(height: 1),
                        itemCount: userModel.organization.departments.length),
                  ),
                ),
              ],),
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
                        offset: Offset(0, 2),
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
                              S.current.noData,
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
  dangerousSources() {
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
            height: size.height * (0.7),
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
                    S.current.chooseDangerSource,
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
                        offset: Offset(0, 2),
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
                          if (model.entity.dangerousSource != null) {
                            current = model.riskDangerousSources[i].id ==
                                model.entity.dangerousSource.id;
                          }
                          return InkWell(
                            child: RiskSelectItem(
                                model.riskDangerousSources[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.dangerousSource =
                                    model.riskDangerousSources[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              height: 1,
                            ),
                        itemCount: model.riskDangerousSources?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

// ignore: always_declare_return_types
  dangerousCategories() {
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
            height: size.height * (0.7),
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
                    S.current.chooseDangerSourceCategory,
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
                        offset: Offset(0, 2),
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
                          if (model.entity.dangerousCategory != null) {
                            current = model.riskDangerousCategories[i].id ==
                                model.entity.dangerousCategory.id;
                          }
                          return InkWell(
                            child: RiskSelectItem(
                                model.riskDangerousCategories[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.dangerousCategory =
                                    model.riskDangerousCategories[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              height: 1,
                            ),
                        itemCount: model.riskDangerousCategories?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

// ignore: always_declare_return_types
  consequences() {
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
            height: size.height * (0.7),
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
                    S.current.chooseConsequence,
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
                        offset: Offset(0, 2),
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
                          if (model.entity.consequences != null) {
                            current = model.riskConsequences[i].id ==
                                model.entity.consequences.id;
                          }
                          return InkWell(
                            child: RiskSelectItem(
                                model.riskConsequences[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.consequences =
                                    model.riskConsequences[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(height: 1,),
                        itemCount: model.riskConsequences?.length ?? 0),
                  ),
                ),
              ],),
          );
        });
  }

// ignore: always_declare_return_types
  actionType() {
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
            height: size.height * (0.7),
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
                    S.current.chooseOperationType,
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
                        offset: Offset(0, 2),
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
                          if (model.entity.actionType != null) {
                            current = model.riskActionType[i].id ==
                                model.entity.actionType.id;
                          }
                          return InkWell(
                            child: RiskSelectItem(
                                model.riskActionType[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.actionType =
                                    model.riskActionType[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(height: 1),
                        itemCount: model.riskActionType?.length ?? 0),
                  ),
                ),
              ],),
          );
        });
  }
}