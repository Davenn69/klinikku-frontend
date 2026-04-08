class BookingModel {
  final String id;
  final String bookingCode;
  final String userId;
  final String doctorId;
  final String regionId;
  final String appointmentSlotId;
  final String complaint;
  final String status;
  final String? cancelledReason;

  const BookingModel({
    required this.id,
    required this.bookingCode,
    required this.userId,
    required this.doctorId,
    required this.regionId,
    required this.appointmentSlotId,
    required this.complaint,
    required this.status,
    required this.cancelledReason,
  });

  factory BookingModel.fromResponseBody(Map<String, dynamic> json) =>
      BookingModel(
        id: json['id'],
        bookingCode: json['bookingCode'],
        userId: json['userId'],
        doctorId: json['doctorId'],
        regionId: json['regionId'],
        appointmentSlotId: json['appointmentSlotId'],
        complaint: json['complaint'],
        status: json['status'],
        cancelledReason: json['cancelledReason'],
      );
}
