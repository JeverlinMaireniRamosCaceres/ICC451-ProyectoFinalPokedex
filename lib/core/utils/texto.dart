// La API manda los nombres en minúscula
String capitalizar(String s) {
  return s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}
// Los nombres de la API vienen en minúscula y con guiones, como solar-power
String nombreLegible(String s) => capitalizar(s.replaceAll('-', ' '));