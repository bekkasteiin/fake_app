import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_item.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:hse/generated/l10n.dart';

class BsaRegistry extends StatefulWidget {
  final BsaModel bsaModel;
  final UserInfoModel userModel;

  const BsaRegistry(this.bsaModel, this.userModel);

  @override
  _BsaRegistryState createState() => _BsaRegistryState();
}

class _BsaRegistryState extends State<BsaRegistry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scrollbar(
              child: ListView.separated(
                  itemBuilder: (_, i) => InkWell(
                    child: BsaItem(widget.bsaModel.entities[i]),
                    onTap: () async {
                      await widget.bsaModel
                          .openEntity(widget.bsaModel.entities[i])
                          .then((_) => setState(() {
                        print('back2');
                      }));
                    },
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(height: 1);
                  },
                  itemCount: widget.bsaModel.entities.length),
            )),
      ],
    );
  }
}