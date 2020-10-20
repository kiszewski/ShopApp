class GeneralFormFieldValidator {
  static String passwordValidator(String value) {
    if (value == null || value == '') {
      return 'Preencha o campo';
    } else
      return null;
  }

  static String emailValidator(String value) {
    if (value == null || value == '') {
      return 'Preencha o campo';
    }
    if (!value.contains('@')) {
      return 'Email inválido';
    } else
      return null;
  }
}
