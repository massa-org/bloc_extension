part of 'blop_complete_strategy.dart';

class _CancelCubit extends Cubit<CompleteReason> {
  _CancelCubit() : super(CompleteReason.done(-1));

  @override
  void emit(CompleteReason state) => super.emit(state);
}

abstract class _CancelCubitCompleterStrategy
    implements MethodCompleterStrategy {
  _CancelCubit cancelCubit(BlopEvent event);

  @override
  Future<void> waitComplete(BlopEvent event) async {
    final _blocker = Completer<void>();

    final cancelCubit = this.cancelCubit(event);

    // listen event complete
    // ignore: unawaited_futures
    event.completeFuture.then(
      (e) {
        //then call event to cancel other process
        e.maybeWhen(
          done: (id) {
            if (!_blocker.isCompleted) _blocker.complete();
            cancelCubit.emit(CompleteReason.cancel(event.id));
          },
          error: (id, error, stackTrace) {
            if (!_blocker.isCompleted) _blocker.completeError(error);
            cancelCubit.emit(
              CompleteReason.cancelWithError(event.id, error, stackTrace),
            );
          },
          orElse: () {},
        );
      },
    );

    // listen cancel event
    final cSub = cancelCubit.stream.listen((cevent) {
      // BUG on very large event count (more than 1<<53) we have int overflow and incorect work

      // prevent earlier started process from drop later process
      if (cevent.id > event.id && !_blocker.isCompleted) {
        cevent.maybeWhen(
          cancelWithError: (id, error, stackTrace) =>
              _blocker.completeError(error, stackTrace),
          orElse: () => _blocker.complete(),
        );
      }
    });

    return _blocker.future.whenComplete(() => cSub.cancel());
  }
}
