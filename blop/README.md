# blop

Business Logic Process

Reimagination of BLOC architecture with main goal to decrease code size and add ability to detect while complicated process is end.

## Install
add to  pubspec.yaml
```yaml

dependencies:
    blop: any

dev_dependencies:
    blop_generator: any
```
## Usage

For create `processor` just extends `SimpleBlop<State>` or `Blop<Event,State>` if you need the ability to extend event.
All method calls add to queue and process in it's order like event in bloc
All methods return `Future<State>`

Ex. we can define processor to control user state
```dart
@blopProcessor
class UserProcessor extends SimpleBlop<UserModel>{
    // method can has name
    @BlopProcess(name: "logout")
    UserModel exit() => UserModel.unauthorized();

    // if name is not specified that get from function name without first underscore
    @blopProcess
    Stream<UserModel> _login(String phone,String pass) async * {
        yield UserModel.unauthorized(); // remove old user data
        // fetch data from network
        yield UserNetwork.login(phone,pass);
    }
}

// ... somewhere in code
// this code await method. If error hapens it's throw that error
final user = await context.read<UserProcessor>().login('phone','pass');
```

TODO add to readme
- [x] basic usage
- [ ] Event transform
- [ ] Method complete strategy
    - [ ] cancel with data
    - [ ] cancel with error
    - [ ] cancel on close
- [ ] Method different return types
- [ ] Await method
- [ ] mapEventToState override (based on remote_value)