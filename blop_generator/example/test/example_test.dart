import 'package:example/remote_model.dart';

// void main() async {
//   final proc = BlopTestClass('');
//   proc.stream.listen(print);
//   await proc.wtf(['1', '2', '3']);

// }

void main() {
  final err = RemoteDataModel<num>.data(123);
  final errWhen = err.cast<int>();

  print('$err , $errWhen ${err == errWhen}');
}
