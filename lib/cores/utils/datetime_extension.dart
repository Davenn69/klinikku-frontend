extension DateTimeExtension on DateTime {
  static const List<String> _days = <String>[
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  static const List<String> _months = <String>[
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  /// Returns a formatted date like: "Selasa, 7 April 2026"
  String toIndonesianDayDateString() {
    final dayName = _days[weekday % 7];
    final monthName = _months[month - 1];
    return '$dayName, $day $monthName $year';
  }
}
