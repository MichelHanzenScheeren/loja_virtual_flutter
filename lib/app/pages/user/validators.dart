class Validator {
  static String emailValidator(String text) {
    if (text.isEmpty) {
      return "Preenchimento obrigatório!";
    } else if (!text.contains("@")) {
      return "Formato de Email inválido!";
    } else if (!(text.contains(".com") ||
        text.contains(".br") ||
        text.contains(".net"))) {
      return "Formato de Email inválido!";
    } else {
      return null;
    }
  }

  static String passwordValidator(String text) {
    if (text.length < 8) {
      return "A senha deve ter pelo menos 8 caracters.";
    } else {
      return null;
    }
  }

  static String basicValidator(String text) {
    if (text.isEmpty) {
      return "Preenchimento Obrigatório";
    } else {
      return null;
    }
  }
}