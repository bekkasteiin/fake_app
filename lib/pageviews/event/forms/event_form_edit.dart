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
import 'package:hse/pageviews/event/widgets/event_basic_doc_item.dart';
import 'package:hse/pageviews/event/widgets/event_calendar_widget.dart';
import 'package:hse/pageviews/event/widgets/files_widget.dart';
import 'package:hse/pageviews/event/widgets/observer_item.dart';
import 'package:hse/pageviews/message/widgets/department_item.dart';
import 'package:hse/pageviews/risks/widgets/risk_widget.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';

class EventFormEdit extends StatefulWidget {
  final bool update;

  const EventFormEdit({this.update = false});

  @override
  _EventFormEditState createState() => _EventFormEditState();
}

class _EventFormEditState extends State<EventFormEdit> {
  UserInfoModel userModel;
  var size;
  EventModel model;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    model = Provider.of<EventModel>(context);
    userModel = Provider.of<UserInfoModel>(context);
    model.entity.organization ??= userModel.assign.organization;
    // model.entity.department ??= userModel.assign.department;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:
        Text(widget.update ? S.current.changeEvents : S.current.newEvents),
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
                      S.current.deleteEvents,
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      S.current.confirmDeleteEvents,
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
                      ),
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
          isRequired: true,
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
          placeholder: S.current.basisDoc,
          textValue: model.entity?.supportDocument?.supportDocNumber ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: ()=> basisDoc(),
        ),
        FieldBones(
            isRequired: true,
            placeholder: S.current.planningPeriod,
            textValue:
            '${formatFullRestNotMilSec(model.entity?.planDateFrom) ?? "нет данных"} ${model.entity?.planDateFrom !=null ? "-" : ""} ${formatFullRestNotMilSec(model.entity?.planDateTo)?? ""}',
            icon: Icons.arrow_drop_down_circle_outlined,
            iconColor: appBlueColor,
            selector: ()=> plannedDate()),
        FieldBones(
            isRequired: true,
            placeholder: S.current.actualPeriod,
            textValue:  '${formatFullRestNotMilSec(model.entity?.actualDateFrom)?? "нет данных"} ${model.entity?.actualDateFrom !=null ? "-" : ""} ${formatFullRestNotMilSec(model.entity?.actualDateTo) ?? ''}',
            icon: Icons.arrow_drop_down_circle_outlined,
            iconColor: appBlueColor,
            selector: ()=>actualDate()
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.priority,
          textValue: model.entity?.sevirity?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => actionType(),
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.controlling,
          textValue:
          "${model.entity?.supervisor?.lastName ?? ""} ${model.entity?.supervisor?.firstName ?? ""} ${model.entity?.supervisor?.middleName ?? ""}",
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => supervisor(),
        ),
        FieldBones(
          isRequired: true,
          placeholder: S.current.observer,
          textValue:
          "${model.entity?.observer?.lastName ?? ""} ${model.entity?.observer?.firstName ?? ""} ${model.entity?.observer?.middleName ?? ""}",
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          selector: () => observer(),
        ),
        SizedBox(
          height: 10,
        ),
        FieldBones(
            placeholder: S.current.eventDescription,
            hintText: '${S.current.comment}...',
            textValue: model.entity?.eventDescription ?? '',
            isRequired: true,
            isTextField: true,
            maxLines: 3,
            onChanged: (val) {
              model.entity.eventDescription = val;
            }),
        FieldBones(
            placeholder: S.current.comment,
            hintText: S.current.arbitraryComment,
            textValue: model.entity?.comment ?? '',
            isTextField: true,
            maxLines: 3,
            onChanged: (val) {
              model.entity.comment = val;
            }),
      ],
    );
  }

  Widget probability() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.completionPercent),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        Row(children: [
          Text(
            '${model.entity?.finishPercent?.toInt() ?? 0}% завершено',
            style: generalFontStyle,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: appLightOrangeColor,
                inactiveTrackColor: Colors.black12,
                trackHeight: 30.0,
                tickMarkShape: RoundSliderTickMarkShape(),
                thumbColor: appLightPurpleColor,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 17.0),
              ),
              child: Slider(
                min: 0.0,
                max: 100.0,
                divisions: 100,
                value: model.entity?.finishPercent?.toDouble() ?? 0,
                onChanged: (newCommission) => setState(() {
                  model.entity.finishPercent = newCommission;
                }),
              ),
            ),
          ),
        ]),
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
        EventFilesWidgetSlider(model),
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
  plannedDate(){
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
      barrierColor: Color(0xFF647087).withOpacity(0.5),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: CalendarPopupView(
            initialEndDate: DateTime.now(),
            initialStartDate: DateTime.now(),
            onApplyClick: (DateTime startData, DateTime endData) {
              setState(() {
                if (startData != null && endData != null) {
                  model.entity.planDateFrom = startData;
                  model.entity.planDateTo  = endData;
                }
              });
            },
          ),
        ),
      ),
    );
  }


  // ignore: always_declare_return_types
  actualDate(){
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
      barrierColor: Color(0xFF647087).withOpacity(0.5),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: CalendarPopupView(
            initialEndDate: DateTime.now(),
            initialStartDate: DateTime.now(),
            onApplyClick: (DateTime startData, DateTime endData) {
              setState(() {
                if (startData != null && endData != null) {
                  model.entity.actualDateFrom = startData;
                  model.entity.actualDateTo  = endData;
                }
              });
            },
          ),
        ),
      ),
    );
  }


// ignore: always_declare_return_types
  actionType() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          if (model.entity.sevirity != null) {
                            current = model.sevirity[i].id ==
                                model.entity.sevirity.id;
                          }
                          return InkWell(
                            child: RiskSelectItem(model.sevirity[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.sevirity = model.sevirity[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemCount: model.sevirity?.length ?? 0),
                  ),
                ),
              ],
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
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemCount: userModel.organization.departments.length),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // ignore: always_declare_return_types
  basisDoc() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0.6,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: size.height * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          if (model.entity.supportDocument != null) {
                            current = model.supportDoc[i].id ==
                                model.entity.supportDocument.id;
                          }
                          return InkWell(
                            child: BasicDocSelectItem(model.supportDoc[i], current),
                            onTap: () => setState(() {
                              if (!current) {
                                model.entity.supportDocument = model.supportDoc[i];
                              }
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 1),
                        itemCount: model.supportDoc?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // ignore: always_declare_return_types
  supervisor() {
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
            height: size.height * 0.5,
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
                  child: Scrollbar(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          var current = false;
                          if (model.entity.supervisor != null) {
                            current = model.entity.department.employees[i].id ==
                                model.entity.supervisor.id;
                          }
                          return InkWell(
                            child: ObserverItem(
                                model.entity.department.employees[i], current),
                            onTap: () => setState(() {
                              model.entity.supervisor =
                              model.entity.department.employees[i];
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                        ),
                        itemCount:
                        model.entity.department.employees?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // ignore: always_declare_return_types
  observer() {
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
            height: size.height * 0.5,
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
                  child: Scrollbar(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          var current = false;
                          if (model.entity.observer != null) {
                            current = model.entity.department.employees[i].id ==
                                model.entity.observer.id;
                          }
                          return InkWell(
                            child: ObserverItem(
                                model.entity.department.employees[i], current),
                            onTap: () => setState(() {
                              model.entity.observer =
                              model.entity.department.employees[i];
                              Get.back();
                            }),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                        ),
                        itemCount:
                        model.entity.department.employees?.length ?? 0),
                  ),
                ),
              ],
            ),
          );
        });
  }
}