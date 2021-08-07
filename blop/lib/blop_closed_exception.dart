class BlopClosedException implements Exception {
  final String _blopType;

  BlopClosedException(Type? blopType) : _blopType = blopType.toString();
  @override
  String toString() {
    return 'BlopHasBeenClosedEception type: $_blopType';
  }
}
