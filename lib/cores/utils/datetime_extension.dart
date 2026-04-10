extension DateTimeExtension on DateTime {
  static const List<String> _shortDays = <String>[
    'Min',
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
  ];

  static const List<String> _longDays = <String>[
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  static const List<String> _shortMonths = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static const List<String> _longMonths = <String>[
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

  /// Returns a short formatted date like: "Sel, 7 Apr"
  String toIndonesianShortDayDateString() {
    final dayName = _shortDays[weekday % 7];
    final monthName = _shortMonths[month - 1];
    return '$dayName, $day $monthName';
  }

  /// Returns a long formatted date like: "Selasa, 7 April 2026"
  String toIndonesianDayDateString() {
    final dayName = _longDays[weekday % 7];
    final monthName = _longMonths[month - 1];
    return '$dayName, $day $monthName $year';
  }
}
