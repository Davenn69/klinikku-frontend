import 'package:klinikku/cores/models/selection_input_model.dart';
import 'package:klinikku/features/booking/models/region_model.dart';

class DashboardFormModel {
  final SelectionInputModel<RegionModel> region;

  const DashboardFormModel({required this.region});
}
