import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  // Usando a classe DateFormat para formatar o DateTime
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(dateTime);
}
