# massa_utils

Utilities to work with bloc

# How to use
## Subscription manager

```dart
// add mixin to class
class SumCubit extends Cubit<int> with BlocSubscriptionManager{
    final List<BlocBase<int>> blocs;
    MulByTwo(this.blocs):super(0){
        // subscribe to updates
        listenBlocs(blocs,recalc);
    }

    // do some action when any of blocs update
    void recalc(){
        emit(blocs.map((v) => v.state).fold(0,(a,b) => a + b));
    }

    @override
    Future<void> close() async {
        // close sub
        await closeManager();
        return super.close();
    }
}

```

## Cubits

Add helper to create cubits, from stream, future and value. Usable for testing.
b
```dart
// create cubit with fixed value
final valueCubit = Cubits.fromValue(42);
// create cubit that emit all data events from stream
// transform stream to simple behaviorSubject, aka. cubit
final streamCubit = Cubits.fromStream(0, Stream.periodic(duration, (id) => id));
// create cubit that emit single event when future complete
final futureCubit = Cubits.fromFuture(0, Future.delayed(duration, () => 42));)
```