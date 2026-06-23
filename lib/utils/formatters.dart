// lib/utils/formatters.dart
import 'package:intl/intl.dart';

/// Formatea un precio (double) con el símbolo '$' y separador de miles (punto).
/// Ejemplo: 899000 -> "$899.000"
/// Si [withSymbol] es false, devuelve solo el número formateado sin el '$'.
String formatPrice(double price, {bool withSymbol = true}) {
  // Creamos un formateador de moneda para Colombia (es_CO)
  // con 0 decimales porque tus precios son enteros.
  final formatter = NumberFormat.currency(
    locale: 'es_CO',        // Para usar punto como separador de miles
    symbol: withSymbol ? '\ COP' : '',   // Símbolo de moneda o vacío
    decimalDigits: 0,       // Sin decimales
  );
  return formatter.format(price);
} 