

class Validations {
  static String? validateName(String value) {
    if (value.isEmpty) return 'Name is Required.';
    final RegExp nameExp = new RegExp(r'^(?=[a-zA-Z0-9._]{2,20}$)(?!.*[_.]{2})[^_.].*[^_.]$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) return 'Please enter an Email Address.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,2"
        r"53}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-z"
        r"A-Z0-9])?)*$");
    if (!nameExp.hasMatch(value)) return 'Invalid email address';
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty || value.length < 6) return 'Please enter a valid password.';
    return null;
  }

  static String? validateForm(String value) {
    return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
  }

  static String? validateNumber(String value) {

    if(value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if(n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  static String? validateInt(String value) {

    if(value == null) {
      return null;
    }
    final n = int.tryParse(value);
    if(n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }


  static String? validateEmpty(String value){
    return null;
  }



}
