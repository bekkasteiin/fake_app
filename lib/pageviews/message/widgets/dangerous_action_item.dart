import 'package:flutter/material.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';

class DangerousActionItem extends StatefulWidget {
  final AbstractDictionary item;
  final MessageModel model;
  final bool editable;

  const DangerousActionItem(this.item, this.model, [this.editable = true]);

  @override
  _DangerousActionItemState createState() => _DangerousActionItemState();
}

class _DangerousActionItemState extends State<DangerousActionItem> {
  @override
  Widget build(BuildContext context) {
    var contains = false;
    if (widget.model.entity.dangerousActions != null) {
      for (var c in widget.model.entity.dangerousActions) {
        if (c.id == widget.item.id) {
          contains = true;
          break;
        } else {
          contains = false;
        }
      }
    }
    var content = Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/alert.png',
              width: 48,
              height: 48,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              widget.item.langValue.toUpperCase(),
              style:
                  generalFontStyle.copyWith(color: appBlackColor, fontSize: 16),
            )),
            Icon(
              contains
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              size: 32,
              color: contains ? appGreenColor : appDarkGrayColor,
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Divider(height: 1),
      ],
    );
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: widget.editable
            ? InkWell(
                child: content,
                onTap: () {
                  if (contains) {
                    setState(() {
                      widget.model.entity.dangerousActions.removeWhere(
                          (element) => element.id == widget.item.id);
                    });
                  } else if (!contains) {
                    setState(() {
                      widget.model.entity.dangerousActions.add(widget.item);
                    });
                  }
                },
              )
            : content);
  }
}
