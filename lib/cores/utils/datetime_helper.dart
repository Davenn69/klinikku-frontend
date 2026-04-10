class DateTimeHelper {
  const DateTimeHelper._();

  /// Parses date string in `yyyy-MM-dd` format, for example `2026-04-09`.
  /// If the value includes time, `DateTime.parse` will still handle it.
  static DateTime parse(String value) {
    return DateTime.parse(value);
  }

  /// Parses `yyyy-MM-dd` safely and returns null if the format is invalid.
  static DateTime? tryParse(String value) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
}
