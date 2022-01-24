import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/companents/widgets/field_bonus.dart';
import 'package:hse/core/model/risks/risks.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/status_widget.dart';
import 'package:hse/pageviews/risks/widgets/files_widget.dart';
import 'package:hse/pageviews/risks/widgets/risks_condition.dart';
import 'package:hse/pageviews/risks/widgets/risks_probabilities.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';
import 'package:provider/provider.dart';
import 'package:hse/generated/l10n.dart';

class RisksManagementFormView extends StatefulWidget {
  const RisksManagementFormView({Key key}) : super(key: key);

  @override
  _RisksManagementFormViewState createState() =>
      _RisksManagementFormViewState();
}

class _RisksManagementFormViewState extends State<RisksManagementFormView> {
  RisksManagement risk;
  RisksModel model;

  // '-' +
  // '${model.entity?.regDateTime == null ? ' Не зарегистрирован ' : formatFullRestNotMilSec(model.entity.regDateTime)}' +
  // '${model.entity.regNumber == null ? '' : '№ ${model.entity.regNumber}'}'),

  @override
  Widget build(BuildContext context) {
    model = Provider.of<RisksModel>(context);
    risk = model.entity;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'RAS-PR - '
          '${model.entity.regDate == null ? ' Не зарегистрирован ' : formatFullRestNotMilSec(model.entity.regDate)}'
          '${model.entity.regNumber == null ? '' : ', №${model.entity.regNumber}'}',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
         children: [
          BsaStatusWidget(model.entity.status),
          info(),
          probability(),
          riskManageability(),
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
          textValue: model.entity.organization.organizationName ?? '',),
        FieldBones(
          placeholder: S.current.department,
          textValue: model.entity?.department?.departmentName ?? ''),
        FieldBones(
          placeholder: S.current.workplace,
          textValue: model.entity?.objectName?.langValue ?? '',),
        FieldBones(
          placeholder: S.current.operationType,
          textValue: model.entity?.actionType?.langValue ?? '',),
        FieldBones(
          placeholder: S.current.dangerSourceCategory,
          textValue: model.entity?.dangerousCategory?.langValue ?? '',),
        FieldBones(
          placeholder: S.current.dangerSource,
          textValue: model.entity?.dangerousSource?.langValue ?? '',),
        FieldBones(
          placeholder: S.current.consequenceRisk,
          textValue: model.entity?.consequences?.langValue ?? '',),
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
          children: model.riskProbabilities
              .map((e) => RisksProbabilitiesItem(e, model, false))
              .toList(),
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
        Column(
            children: model.riskManageabilities
                .map((e) => RisksConditionCategoryItem(e, model, false))
                .toList()),
        SizedBox(height: 15.0),
        FieldBones(
            placeholder: S.current.comment,
            textValue: model.entity?.comment ?? '',),
      ],);
  }

  Widget photos() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(S.current.photoFixation),
      children: [
        RisksFilesWidgetSlider(model, false),
      ],
    );
  }
}