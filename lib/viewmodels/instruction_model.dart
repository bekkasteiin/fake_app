import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';

class InstructionModel extends BaseModel {
  get instructions async => await RestServices.getUserGuides();
}
