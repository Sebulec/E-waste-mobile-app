class JsonNumberFormatter {
  final double _value;

  JsonNumberFormatter(this._value);

  String getFormattedValue() {
    return _value.toStringAsPrecision(9);
  }

  String getAsInteger() {
    return _value.toInt().toString();
  }
}
