import 'package:klinikku/cores/utils/datetime_helper.dart';

class AppointmentSlotItem {
  final String id;
  final String doctorId;
  final String regionId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int maxCapacity;
  final int bookedCount;
  final bool isAvailable;
  final int remainingCapacity;

  const AppointmentSlotItem({
    required this.id,
    required this.doctorId,
    required this.regionId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.maxCapacity,
    required this.bookedCount,
    required this.remainingCapacity,
    required this.isAvailable,
  });

  factory AppointmentSlotItem.fromResponseBody(Map<String, dynamic> json) =>
      AppointmentSlotItem(
        id: json['id'],
        doctorId: json['doctorId'],
        regionId: json['regionId'],
        date: DateTimeHelper.tryParse(json['date']) ?? DateTime.now(),
        startTime: json['startTime'],
        endTime: json['endTime'],
        maxCapacity: json['maxCapacity'],
        bookedCount: json['bookedCount'],
        remainingCapacity: json['remainingCapacity'],
        isAvailable: json['isAvailable'],
      );

  String get timeRangeText =>
      '${_formatTime(startTime)} - ${_formatTime(endTime)}';

  String get durationText => formatTimeDuration(startTime, endTime);
}

String formatTimeDuration(String startTime, String endTime) {
  final start = _parseTime(startTime);
  final end = _parseTime(endTime);

  final diff = end.difference(start);
  if (diff.isNegative) return '0 menit';

  final hours = diff.inHours;
  final minutes = diff.inMinutes.remainder(60);
  final seconds = diff.inSeconds.remainder(60);

  final parts = <String>[];
  if (hours > 0) parts.add('${hours} jam');
  if (minutes > 0) parts.add('${minutes} menit');
  if (hours == 0 && minutes == 0 && seconds > 0) parts.add('${seconds} detik');

  return parts.isEmpty ? '0 menit' : parts.join(' ');
}

DateTime _parseTime(String value) {
  final parts = value.split(':');
  final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
  final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
  final second = parts.length > 2 ? int.tryParse(parts[2]) ?? 0 : 0;

  return DateTime(2000, 1, 1, hour, minute, second);
}

String _formatTime(String value) {
  final parts = value.split(':');
  if (parts.length < 2) return value;
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}
