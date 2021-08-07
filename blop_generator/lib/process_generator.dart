import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:blop/blop.dart';
import 'package:blop_generator/method_generator.dart';
import 'package:blop_generator/process_visitor.dart';
import 'package:blop_generator/return_type_switch.dart';
import 'package:source_gen/source_gen.dart';

class ProcessorGenerator {
  late final DartType stateType;
  late final DartType eventType;
  late final ProcessVisitor visitor;

  final ClassElement element;

  String get typeString {
    final _typeString = element.typeParameters.join(',');
    return _typeString.isNotEmpty ? '<$_typeString>' : '';
  }

  String get typeStringCall {
    final _typeString = element.typeParameters.map((v) => v.name).join(',');
    return _typeString.isNotEmpty ? '<$_typeString>' : '';
  }

  ProcessorGenerator(this.element) {
    final blopType = element.thisType.allSupertypes.firstWhere(
      TypeChecker.fromRuntime(Blop).isExactlyType,
    );
    eventType = blopType.typeArguments[0];
    stateType = blopType.typeArguments[1];
    visitor = ProcessVisitor(stateType);
    element.visitChildren(visitor);
  }

  String generateInterface() {
    final buffer = StringBuffer();
    buffer.writeln(
        'abstract class _BlopInterface${element.displayName}$typeString{');
    visitor.data.forEach(
      (e) => buffer.writeln(e.generate ? e.defString : ''),
    );
    buffer.writeln('}');
    return buffer.toString();
  }

  String _generateProcessImpl(MethodGenerator processElement) {
    final name = processElement.originalName;

    if (!processElement.generate) {
      return '// generation skipped for method: ${name} cause no process name provided and method name not starts with _\n';
    } else {
      final functionCall = processElement.callString;

      final processImplementation =
          (String toStream, String generatorType) => '''

// marked element ${name} generator: $generatorType
Future<${stateType}> ${processElement.implString} async {
  return addProcess($toStream,'$name',);
}

''';

      return returnTypeSwitch(
        stateType,
        processElement.element,
        same: () => processImplementation(
          '() => Future.value($functionCall).asStream()',
          'stateType',
        ),
        stream: () => processImplementation(
          '() => $functionCall',
          'Stream<stateType>',
        ),
        future: () => processImplementation(
          '() => $functionCall.asStream()',
          'Future<stateType>',
        ),
        futureOr: () => processImplementation(
          '() async *{yield (await $functionCall);}',
          'FutureOr<stateType>',
        ),
        orElse: () => throw 'unsuported return type',
      );
    }
  }

  String generateImplementation() {
    final buffer = StringBuffer();

    buffer.writeln(
      'mixin _\$${element.displayName}$typeString on Blop<$eventType,$stateType> implements _BlopInterface${element.displayName} $typeStringCall{',
    );
    visitor.data.forEach(
      (element) => buffer.writeln(_generateProcessImpl(element)),
    );
    buffer.writeln('}');
    return buffer.toString();
  }

  String generate() {
    return generateInterface() + '\n' + generateImplementation();
  }
}
