import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/companents/widgets/no_data.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/service/file_service.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/pageviews/message/widgets/dangerous_action_item.dart';
import 'package:hse/pageviews/message/widgets/dangerous_condition.dart';
import 'package:hse/pageviews/message/widgets/department_item.dart';
import 'package:hse/pageviews/message/widgets/files_widget.dart';
import 'package:hse/pageviews/message/widgets/message_category_item.dart';
import 'package:hse/pageviews/message/widgets/object_item.dart';
import 'package:hse/pageviews/message/widgets/violated_employee_item.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';

class MessageFormEdit extends StatefulWidget {
  final bool update;

  const MessageFormEdit({this.update = false});

  @override
  _MessageFormEditState createState() => _MessageFormEditState();
}

class _MessageFormEditState extends State<MessageFormEdit> {
  MessageModel model;
  UserInfoModel userModel;
  var size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    model = Provider.of<MessageModel>(context);
    userModel = Provider.of<UserInfoModel>(context);
    //model.entity.organization ??= userModel.assign.organization;
    // model.entity.department ??= userModel.assign.department;
    var category = model.entity?.category?.langValue != null
        ? ' (${model.entity.category.langValue})'
        : '';
    var title =
        '${widget.update ? S.current.changeMessages : S.current.newMessage} ' +
            category;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(title),
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
                           S.current.deleteMessage,
                            style: generalFontStyle.copyWith(
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                           S.current.confirmDeleteMessage,
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
          child: Column(
        children: [
          info(),
          categoryElement(),
          pdList(),
          dopsv(),
          photos(),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: GFButton(
              onPressed: () => model.saveEntity(update: widget.update),
              text: S.current.register.toUpperCase(),
              textStyle: generalFontStyle.copyWith(
                  color: Colors.white,
                  fontSize: defaultFontSize + 10,
                  fontWeight: FontWeight.bold),
              color: appGreenColor,
              size: 52,
              blockButton: true,
            ),
          ))
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
          textValue: model.entity?.organization?.organizationName ?? 'ТОО "Корпорация Казахмыс"',
          icon: Icons.arrow_drop_down_circle_outlined,
          isRequired: true,
          iconColor: appBlueColor,
        ),
        FieldBones(
          placeholder: S.current.department,
          textValue: model.entity?.department?.departmentName ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          isRequired: true,
          selector: () => getDepartments(),
        ),
        FieldBones(
          placeholder: S.current.workplace,
          textValue: model.entity?.objectName?.langValue ?? '',
          icon: Icons.arrow_drop_down_circle_outlined,
          iconColor: appBlueColor,
          isRequired: true,
          selector: () => objects(),
        ),
        //категорий
        Container(
          height: 60,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: model.categoryList.length,
              itemBuilder: (_, i) {
                return MessageCategoryItem(model, i, () {
                  setState(() {
                    model.entity.category = model.categoryList[i];
                  });
                });
              }),
        )
      ],
    );
  }

  Widget categoryElement() {
    return model.entity?.category?.code == 'DC'
        ? dcList()
        : model.entity?.category?.code == 'OTHER'
            ? otherCategory()
            : model.entity?.category?.code == 'DA'
                ? Column(
                    children: [
                      peopleList(),
                      daList(),
                    ],
                  )
                : SizedBox();
  }

  Widget dcList() {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(S.current.dangerousCondition),
      children: model.conditionCategoryList
          .map((e) => DangerousConditionCategoryItem(e, model))
          .toList(),
    );
  }

  Widget peopleList() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.offenders),
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
        model.entity.violatedEmployees != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: model.entity.violatedEmployees
                    .map((e) => ViolatedEmployeeItem(
                          person: e,
                          remove: () => setState(() {
                            model.entity.violatedEmployees.remove(e);
                          }),
                        ))
                    .toList(),
              )
            : SizedBox(),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget daList() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.dangerousAction),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        ...model.dangerousActionList.map((e) => DangerousActionItem(e, model))
      ],
    );
  }

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
          textValue: model.entity.otherViolationComment ?? '',
          isTextField: true,
          onChanged: (val) {
            model.entity.otherViolationComment = val;
          },
          maxLines: 3,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(S.current.anonymously),
          value: model.entity.initiatorPrivacy ?? false,
          onChanged: (bool value) {
            model.entity.initiatorPrivacy = value;
            model.notifyListeners();
          },
          // secondary: const Icon(Icons.lightbulb_outline),
        )
      ],
    );
  }

  Widget pdList() {
    return ExpansionTile(
      initiallyExpanded: true,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(S.current.intendedActions),
      children: model.takenActionList.map((e) => takens(e)).toList(),
    );
  }

  Widget takens(AbstractDictionary messageDictionary) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(messageDictionary.langValue),
      value: model.entity?.takenAction?.id == messageDictionary.id,
      onChanged: (bool value) {
        if (value) {
          setState(() {
            model.entity.takenAction = messageDictionary;
            // model.notifyListeners();
          });
        }
      },
      // secondary: const Icon(Icons.lightbulb_outline),
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
            textValue: model.entity?.comment ?? '',
            isTextField: true,
            maxLines: 3,
            onChanged: (val) {
              model.entity.comment = val;
            }),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(S.current.anonymously),
          value: model.entity?.initiatorPrivacy ?? false,
          onChanged: (bool value) {
            setState(() {
              model.entity.initiatorPrivacy = value;
            });
          },
          // secondary: const Icon(Icons.lightbulb_outline),
        )
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
        FilesWidgetSlider(model),
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
                      // controller: _scrollController,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, i) {
                        var current = false;
                        if (model.entity.department != null) {
                          current = userModel.organization.departments[i].id ==
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
                              model.entity.violatedEmployees = [];
                            }
                            Get.back();
                          }),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            height: 1,
                          ),
                      itemCount: userModel.organization.departments.length),
                ))
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
                                // controller: _scrollController,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  var current = false;
                                  if (model.entity.department != null &&
                                      model.entity.objectName != null) {
                                    current = model.entity.department
                                            .objectName[i].id ==
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
                                itemCount: model
                                        .entity.department.objectName?.length ??
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
                          ))
              ],
            ),
          );
        });
  }

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
                    'Выберите сотрудник из список',
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
                                // controller: _scrollController,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  var current = false;
                                  if (model
                                      .entity.violatedEmployees.isNotEmpty) {
                                    current = model.entity.violatedEmployees
                                        .contains(model
                                            .entity.department.employees[i]);
                                    // for(var employee in model.entity.violatedEmployees) {
                                    //   current = model.entity.violatedEmployees
                                    //       .contains(model
                                    //       .entity.department.employees[i].id);
                                    // }
                                  }
                                  return ViolatedEmployeeItem(
                                    person:
                                        model.entity.department.employees[i],
                                    current: current,
                                    isPop: true,
                                    editable: false,
                                    onTapPop: () => setState(() {
                                      if (!current) {
                                        model.entity.violatedEmployees.add(model
                                            .entity.department.employees[i]);
                                      }
                                      Get.back();
                                    }),
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                      height: 1,
                                    ),
                                itemCount:
                                    model.entity.department.employees?.length ??
                                        0),
                          )
                        : NoDataWidget(size))
              ],
            ),
          );
        });
  }
}
