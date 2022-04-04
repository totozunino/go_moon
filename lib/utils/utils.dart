String toSnakeCase(String text) {
  RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
  return text
      .replaceAll(' ', '')
      .replaceAllMapped(exp, (Match m) => "'_' + ${m.group(0)}")
      .toLowerCase();
}
