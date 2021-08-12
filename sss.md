SSS - Some Stupid ideaS
- [ ] Component configuration system aka theme generator that helps easely define and manage component theme
```dart
@freezed
class _RemoteDataBuilderTheme{
    _RemoteDataBuilderTheme(
        Color color,
        Color textColor,
        String Function() someText, 
    )
}
```
- [ ] Pure cubit generator provide ability to write function that map some cubits to single cubit and generate cubit from this function
```dart
// Function must be sync if it implemented as cubit, because async function can rewrite launched after updates, this behavior can be solved in bloc
@PureCubit(initial: null)
Shop? _userSelectedShop(
    Shop? state,
    UserSelectedShop id, 
    ShopsCubit shops,
    LocationCubit location,
){
    // vscode action after function defination
    final shops = shops.state;
    final location = location.state;
    final id = id.state;

    if(
        state == null //user does't select shop
        && id.state.isData // and data from persistent storage loaded
        && shops.state.isData // and shops loaded
    ){
        final shop = shops.state.find(id.state);
        if(shop != null)return Shop.selected(shop);
    }
    if(
        state == null //user does't select shop
        && location.state != null // and we have location
        && shops.state.isData // and shops loaded
    ){
        final nearestShop = shops.state.sort(location.state.distance).first;
        return Shop.suggested(nearestShop);
    }
    //find nearest and return
    return state;
}

/// Somewhere in *.g.dart
class UserSelectedShop extends Cubit<Shop?>{
    UserSelectedShop(
        UserSelectedShop id, 
        ShopsCubit shops,
        LocationCubit location,
    ):super(null){
        listenBlocs([id,shops,location],rebuild); // listen to rebuild
    }

    UserSelectedShop.of(BuildContext context); // auto init dependencies from context

    rebuild(){
        emit(
            _userSelectedShop(
                state,
                id,
                shops,
                location,
            ),
        )
    }
}
```
- [ ] remote data streaming 
    - [ ] rewrited sliver_stream_builder
    - [ ] http pagination to stream
        - [ ] x-next pagination
        - [ ] offset pagination
        - [ ] page pagination
        - [ ] result exractor
        - [ ] bitrix pagination (start)