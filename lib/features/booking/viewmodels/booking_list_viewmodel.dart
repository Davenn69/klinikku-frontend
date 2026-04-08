import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klinikku/cores/bases/base_notifier.dart';
import 'package:klinikku/cores/mixins/toast_mixin.dart';
import 'package:klinikku/features/booking/models/booking_list_item_model.dart';
import 'package:klinikku/features/booking/services/booking_list_services.dart';

final bookingListVM = ChangeNotifierProvider.autoDispose<BookingListVM>(
  BookingListVM.new,
);

class BookingListVM extends BaseNotifier with ToastMixin {
  late List<BookingListItemModel> bookings;
  late List<String> filterLabels;

  int selectedFilterIndex = 0;

  final BookingListServices _services = BookingListServices();

  BookingListVM(super.ref);

  @override
  FutureOr<void> init() async {
    filterLabels = const ['Semua', 'Aktif', 'Selesai', 'Dibatalkan'];

    bookings = const [
      BookingListItemModel(
        bookingCode: 'BKG-20260407-001',
        doctorName: 'dr. Nina Kusuma, Sp.A',
        specialization: 'Anak',
        regionName: 'Surabaya',
        status: BookingListStatus.booked,
        dateTimeLabel: 'Sel, 7 Apr · 11:00',
      ),
      BookingListItemModel(
        bookingCode: 'BKG-20260407-002',
        doctorName: 'dr. Dewi Anggraeni, Sp.JP',
        specialization: 'Jantung',
        regionName: 'Jakarta',
        status: BookingListStatus.confirmed,
        dateTimeLabel: 'Sel, 7 Apr · 13:00',
      ),
      BookingListItemModel(
        bookingCode: 'BKG-20260301-001',
        doctorName: 'dr. Andi Wijaya, Sp.PD',
        specialization: 'Penyakit Dalam',
        regionName: 'Surabaya',
        status: BookingListStatus.selesai,
        dateTimeLabel: 'Min, 1 Mar · 08:00',
      ),
      BookingListItemModel(
        bookingCode: 'BKG-20260320-001',
        doctorName: 'dr. Ratna Sari, Sp.KK',
        specialization: 'Kulit dan Kelamin',
        regionName: 'Bandung',
        status: BookingListStatus.batal,
        dateTimeLabel: 'Kam, 20 Mar · 10:30',
      ),
    ];

    await getBookingList();
  }

  List<BookingListItemModel> get filteredBookings {
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
            .where((item) => item.status == BookingListStatus.selesai)
            .toList();
      case 3:
        return bookings
            .where((item) => item.status == BookingListStatus.batal)
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
  }
}
