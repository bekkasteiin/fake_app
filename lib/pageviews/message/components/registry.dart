import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/message/widgets/message_item.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:hse/viewmodels/user_info.dart';

import '../../../core/utils/UI_Helpers.dart';

class MessageRegistry extends StatefulWidget {
  final MessageModel messageModel;
  final UserInfoModel userModel;

  const MessageRegistry(this.messageModel, this.userModel);

  @override
  _MessageRegistryState createState() => _MessageRegistryState();
}

class _MessageRegistryState extends State<MessageRegistry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scrollbar(
          child: ListView.separated(
              itemBuilder: (_, i) => InkWell(
                child: MessageItem(widget.messageModel.entities[i]),
                // MessageItem(model.entities[i], () => setState(() {})),
                onTap: () async {
                  await widget.messageModel
                      .openEntity(widget.messageModel.entities[i])
                      .then((_) {
                    setState(() {
                      print('back2');
                    });
                  });
                },
              ),
              separatorBuilder: (context, index) {
                return Divider(height: 1,);
              },
              itemCount: widget.messageModel.entities.length),
        )),

      ],
    );
  }
}
