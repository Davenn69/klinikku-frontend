import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_notifier.dart';

final dashboardVM = ChangeNotifierProvider.autoDispose(DashboardVM.new);

class DashboardVM extends BaseNotifier {
  DashboardVM(super.ref);

  @override
  FutureOr<void> init() {}
}
