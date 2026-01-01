import 'package:intl/intl.dart';

String formatDate(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) return '';

  try {
    final parsed = DateTime.parse(dateTime);
    return DateFormat('dd-MM-yyyy').format(parsed);
  } catch (_) {
    return '';
  }
}
