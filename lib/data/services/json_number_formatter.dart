class JsonNumberFormatter {
  final double _value;

  JsonNumberFormatter(this._value);

  String getFormattedValue() {
    return _value.toString();
  }
}
