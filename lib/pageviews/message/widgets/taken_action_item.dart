import 'package:flutter/material.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';

class TakenActionItem extends StatefulWidget {
  final AbstractDictionary messageDictionary;
  final MessageModel model;
  final bool editable;

  const TakenActionItem(this.messageDictionary, this.model,
      [this.editable = true]);

  @override
  _TakenActionItemState createState() => _TakenActionItemState();
}

class _TakenActionItemState extends State<TakenActionItem> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.messageDictionary.langValue),
      value: widget.model.entity?.takenAction?.id == widget.messageDictionary.id,
      onChanged: (bool value) {
        if (value && widget.editable) {
          setState(() {
            widget.model.entity.takenAction = widget.messageDictionary;
            widget.model.notifyListeners();
          });
        }
      },
      // secondary: const Icon(Icons.lightbulb_outline),
    );
  }
}
