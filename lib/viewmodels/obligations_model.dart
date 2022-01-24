import 'package:hse/core/model/material_obligations/MaterialObligations.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';

class ObligationsViewModel extends BaseModel {
  MaterialObligations matObs;

  Future<MaterialObligations> get mol async {
    matObs ??= await RestServices.getIssuedEquipment();
    return matObs;
  }
}
