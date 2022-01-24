
import 'package:flutter/material.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';

class MessageCategoryItem extends StatelessWidget {
  final MessageModel model;
  final int index;
  final Function onTap;
  const MessageCategoryItem(this.model, this.index, [this.onTap]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: model?.entity?.category != null &&
                  model.categoryList[index].code ==
                      model.entity.category.code
                  ? appBlueColor
                  : Colors.white,
              border: Border.all(color: appBlueColor, width: 2)),
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            '${model.categoryList[index].langValue}'.toUpperCase(),
            style: generalFontStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: model?.entity?.category != null &&
                    model.categoryList[index].code ==
                        model.entity.category.code
                    ? Colors.white
                    : appBlueColor),
          ),
        ),
        onTap: onTap,
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    );
  }
}
