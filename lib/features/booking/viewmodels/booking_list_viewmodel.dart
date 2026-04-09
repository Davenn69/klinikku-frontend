import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/features/booking/models/booking_model.dart';
import 'package:klinikku/features/booking/services/booking_list_services.dart';

final bookingListVM = ChangeNotifierProvider.autoDispose<BookingListVM>(
  BookingListVM.new,
);

class BookingListVM extends BaseNotifier with ToastMixin {
  late List<BookingModel> bookings;
  late List<String> filterLabels;

  int selectedFilterIndex = 0;

  final BookingListServices _services = BookingListServices();

  BookingListVM(super.ref);

  @override
  FutureOr<void> init() async {
    filterLabels = const ['Semua', 'Aktif', 'Selesai', 'Dibatalkan'];

    await getBookingList();
  }

  List<BookingModel> get filteredBookings {
    switch (selectedFilterIndex) {
      case 1:
        return bookings
            .where(
              (item) =>
                  item.status == BookingListStatus.booked ||
                  item.status == BookingListStatus.confirmed,
            )
            .toList();
      case 2:
        return bookings
            .where((item) => item.status == BookingListStatus.done)
            .toList();
      case 3:
        return bookings
            .where((item) => item.status == BookingListStatus.cancelled)
            .toList();
      default:
        return bookings;
    }
  }

  String get totalBookingLabel => '${bookings.length} total booking';

  void selectFilter(int index) {
    selectedFilterIndex = index;
    notifyListeners();
  }

  getBookingList() async {
    final response = await _services.getBookingList();

    if (response is DioException) {
      String errorMsg =
          response.response == null
              ? "Internal server error."
              : response.response!.data['error']['message'];
      showErrorToast(errorMsg);
      return;
    }

    final data = response.data['encounter'];
    bookings =
        (data as List<dynamic>)
            .map((item) => BookingModel.fromResponseBody(item))
            .toList();
  }
}
