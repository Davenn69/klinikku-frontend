import 'dart:async';

import 'package:klinikku/cores/bases/base_notifier.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';

class BookingDetailVM extends BaseNotifier {
  final String bookingId;
  late BookingModel detail;

  BookingDetailVM(super.ref, {required this.bookingId});

  @override
  FutureOr<void> init() {}
}
