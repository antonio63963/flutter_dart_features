class Validators {
  static String? name(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length <3) {
      return 'Must be at least 3 characters length';
    }
    return null;
  }
}
