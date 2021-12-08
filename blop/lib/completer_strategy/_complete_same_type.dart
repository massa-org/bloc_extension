part of 'blop_complete_strategy.dart';

class _TypeBasedCompleterStrategy extends _CancelCubitCompleterStrategy {
  // contains only Proccess count cubits
  final Map<String, _CancelCubit> _cancelCubits = {};

  @override
  _CancelCubit cancelCubit(BlopEvent event) {
    return _cancelCubits.putIfAbsent(event.type, () => _CancelCubit());
  }

  @override
  Future<void> close([Type? blopType]) {
    return Future.wait(
      _cancelCubits.entries.map(
        (item) {
          item.value.emit(
            CompleteReason.cancelWithError(
              1 << 53,
              BlopClosedException(blopType),
              StackTrace.current,
            ),
          );
          return item.value.close();
        },
      ),
    );
  }
}
