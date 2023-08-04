class ValidateClass {
  bool isValid(value) {
    return (value != null || value != '' || value != value?.trim())
        ? true
        : false;
  }
}
