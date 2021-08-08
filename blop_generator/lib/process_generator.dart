import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:blop/blop.dart';
import 'package:blop_generator/method_visitor.dart';
import 'package:source_gen/source_gen.dart';

class ProcessorGenerator {
  late final DartType stateType;
  late final DartType eventType;
  late final MethodVisitor visitor;

  final ClassElement element;

  ProcessorGenerator(this.element) {
    final blopType = element.thisType.allSupertypes.firstWhere(
      TypeChecker.fromRuntime(Blop).isExactlyType,
    );
    eventType = blopType.typeArguments[0];
    stateType = blopType.typeArguments[1];
    visitor = MethodVisitor(stateType);
    element.visitChildren(visitor);
  }

  String get typeString {
    final _typeString = element.typeParameters.join(',');
    return _typeString.isNotEmpty ? '<$_typeString>' : '';
  }

  String get typeStringCall {
    final _typeString = element.typeParameters.map((v) => v.name).join(',');
    return _typeString.isNotEmpty ? '<$_typeString>' : '';
  }

  String generateInterface() {
    final buffer = StringBuffer();
    buffer.writeln(
      'abstract class _BlopInterface${element.displayName}$typeString{',
    );
    visitor.data.forEach(
      (e) => buffer.writeln(e.generate ? e.methodSignatureString : ''),
    );
    buffer.writeln('}');
    return buffer.toString();
  }

  String generateImplementation() {
    final buffer = StringBuffer();

    buffer.writeln(
      'mixin _\$${element.displayName}$typeString on Blop<$eventType,$stateType> implements _BlopInterface${element.displayName} $typeStringCall{',
    );
    visitor.data.forEach(
      (e) => buffer.writeln(e.methodString),
    );
    buffer.writeln('}');
    return buffer.toString();
  }

  String generate() {
    return generateInterface() + '\n' + generateImplementation();
  }
}
