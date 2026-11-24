// La API manda los nombres en minúscula
String capitalizar(String s) {
  return s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}