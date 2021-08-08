class MethodExecutionException implements Exception {
  final dynamic error;
  final void Function() _endHandle;

  bool _handled = false;

  // call when error fully processed and data updated
  void complete() {
    if (!_handled) _endHandle();
    _handled = true;
  }

  MethodExecutionException(this.error, this._endHandle);
}
