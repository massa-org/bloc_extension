# remote_value

remote_value implements `remote data` abstraction and integrate it with bloc(based on blop)

Support technique that can be applied to bloc like event transform, Bloc.listener
and blop methods that add ability to extend behavior, used to implement `PersistentValueBlop`

[remote_data](https://pub.dev/packages/remote_data)

[triple](https://pub.dev/packages/triple)

# install

```yaml
dependency: 
    remote_value: any
```

# Features

## base usage
```dart
class CurrentUserData extends RemoteValueBlop<UserModel>{
    CurrentUserData(Cubit<Future<UserModel> Function()> loadUser):super(loadUser);

    @override
    Stream<Transition<BlopEvent<String>, String>> transformEvents(
        Stream<BlopEvent<String>> events,
        TransitionFunction<BlopEvent<String>, String> transitionFn,
    ) {
        return super.transformEvents(
            events.debounceTime(Duration(milliseconds: 100)),
            transitionFn,
        );
    }
}

final user = CurrentUserData(currentUserLoader);

// change loader
// emit new loader fn that trigger auto reload of user
currentUserLoader.changeId(newId); 

// manual reload
// triger reload and await result
await user.reload(); 

// events can be transformed 
// debounce all event and reload only once, all futures complete on reload
user.reload();
user.reload();
user.reload();

// add ability to await state loading
// return current loaded state or await next loaded event
await data.loadingFuture;


// static remote value can be only manual reloaded
class ShopList extends RemoteValueBlop<ShopModel>{
    ShopList():super.staticLoader(ShopRepositoty.load);
}
```


## Wotk with state 
```dart
late final RemoteValue<T> state = remoteValueBlop.state;

// concrete state check
state.isInitial;
state.isLoading;
state.isError;
state.isData;

// combined state
// return true if error or data
state.isLoaded;

// if data transform from T to E, in other cases cast to E
state.transformData<E>((T v) => transform(v));// return RemoteValue<E>

// cast data to E
state.cast<E>(); // return RemoteValue<E>
```

- [ ] Extend with typed event's
- [ ] Extend with blop method
