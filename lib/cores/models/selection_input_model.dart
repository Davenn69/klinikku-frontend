class SelectionInputModel<T> {
  final String? Function(T?)? validator;
  T? _selectedValue;
  String? errorMessage;
  final String? label;

  SelectionInputModel({this.validator, this.label});

  bool validate() {
    errorMessage = validator?.call(_selectedValue);
    return errorMessage == null;
  }

  T? get selectedValue => _selectedValue;
  set selectedValue(T? value) {
    errorMessage = null;
    _selectedValue = value;
  }

  void clear() {
    selectedValue = null;
  }
}
