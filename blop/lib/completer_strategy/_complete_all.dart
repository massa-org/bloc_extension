part of 'blop_complete_strategy.dart';

class _OlderCompleteStrategy extends _CancelCubitCompleterStrategy {
  // contains only Proccess count cubits
  final _cancelCubit = _CancelCubit();
  @override
  _CancelCubit cancelCubit(BlopEvent event) {
    return _cancelCubit;
  }

  @override
  Future<void> close([Type? blopType]) {
    _cancelCubit.emit(
      CompleteReason.cancelWithError(
        1 << 53,
        BlopClosedException(blopType),
        StackTrace.current,
      ),
    );
    return _cancelCubit.close();
  }
}
