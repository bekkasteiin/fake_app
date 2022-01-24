import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';

class FieldBones extends StatelessWidget {
  final String placeholder;
  final String textValue;
  final bool isTextField;
  final bool isRequired;
  final selector;
  final bool needMaxLines;
  final IconData icon;
  final Color iconColor;
  final bool iconAlignEnd;
  final bool isMinWidthTiles;
  final int maxLinesSubTitle;
  final iconTap;
  final onChanged;
  final onSaved;
  final onFieldSubmitted;
  final onEditingComplete;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final double height;
  final bool showCounterText;
  final validate;
  final bool dateField;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget leading;
  final TextEditingController textController;

  const FieldBones(
      {Key key,
        @required this.placeholder,
        this.isTextField = false,
        this.textValue,
        this.icon,
        this.iconColor,
        this.iconTap,
        this.controller,
        this.onChanged,
        this.onSaved,
        this.onFieldSubmitted,
        this.onEditingComplete,
        this.needMaxLines = false,
        this.textController,
        this.selector,
        this.isRequired = false,
        this.showCounterText = false,
        this.isMinWidthTiles = false,
        this.maxLinesSubTitle,
        this.keyboardType,
        this.validate,
        this.hintText,
        this.maxLines,
        this.leading,
        this.maxLength,
        this.dateField = false,
        this.height,
        this.iconAlignEnd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var secondChild;
    var needToShowDialog = needMaxLines && !isTextField && icon == null;
    if (needToShowDialog) {
      secondChild = buildIconButton(context, needToShowDialog);
    }
    secondChild ??= icon == null
        ? SizedBox(
      width: 30,
    )
        : buildIconButton(context, false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Container(
            padding: EdgeInsets.only(bottom: 7.0),
            child: Text.rich(TextSpan(
                text: isRequired ? "* " : "",
                style: generalFontStyle.copyWith(
                  // fontSize: 12,
                  color: appRedColor,
                ),
                children: [
                  TextSpan(
                    text: placeholder ?? '',
                    style:
                    generalFontStyle.copyWith(color: appDarkGrayColor),
                  )
                ])),
          ),
          //field
          InkWell(
            onTap: selector,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: appFiledBorderColor,
                  width: 0.5,
                ),
                borderRadius:
                BorderRadius.circular(4),
                // color: isTextField ? appWhiteColor : appGrayColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading != null
                      ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Center(child: leading),
                  )
                      : dateField
                      ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Center(child: Icon(
                      Icons.calendar_today_outlined,
                      color: appBlueColor,
                      size: 20,
                    )),
                  )
                      : Column(),
                  Expanded(
                    // width:
                    // !isMinWidthTiles ? MediaQuery.of(context).size.width-110 : 130,
                    child: !isTextField
                        ? buildTile()
                        : buildTextFormField(context),
                  ),
                  secondChild,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTile() {
    var text2 = Text(
      textValue != null
          ? textValue
          : hintText != null
          ? hintText
          : dateField
          ? '__ ___, _____'
          : '',
      style: generalFontStyle.copyWith(
          fontSize: 15,
          color: textValue == null
              ? appDarkGrayColor
              : appBlackColor),
      maxLines: maxLinesSubTitle ?? 2,
    );
    return Container(
      child: text2,
      height: height != null ? height : null,
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(
            vertical: 0,
          ),
          fillColor: isTextField
              ? CupertinoColors.systemBackground
              : Theme.of(context).scaffoldBackgroundColor,
          hintText: hintText ?? "",
          isDense: true,
          // counterText: !showCounterText ? "" : null,
          border: InputBorder.none),
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      maxLines: maxLines ?? null,
      validator: validate,
      autovalidateMode: AutovalidateMode.always,
      initialValue: textValue,
      style: TextStyle(fontSize: 15),
      controller: textValue != null && controller == null && !isTextField
          ? null
          : controller,
      enabled: isTextField,
      maxLength: maxLength ?? null,
      buildCounter: (BuildContext context,
          {int currentLength, int maxLength, bool isFocused}) =>
      (showCounterText && maxLength != null)
          ? Text("$currentLength/$maxLength")
          : null,
      readOnly: false,
    );
  }

  InkWell buildIconButton(BuildContext context, bool needToShowDialog) {
    return InkWell(
        onTap: iconTap,
        child: Container(
          decoration: iconTap == null
              ? BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(10),
          )
              : BoxDecoration(),
          child: Icon(
            needToShowDialog ? Icons.message : icon ?? Icons.arrow_forward_ios,
            color: iconColor,
            size: 20,
          ),
        ));
  }
}
