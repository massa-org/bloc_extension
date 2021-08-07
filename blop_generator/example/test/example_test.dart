import 'package:example/example.dart';

void main() async {
  final proc = BlopTestClass('');
  proc.stream.listen(print);
  await proc.wtf(['1', '2', '3']);
}
