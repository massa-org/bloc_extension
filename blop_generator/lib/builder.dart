import 'package:analyzer/dart/element/element.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:blop_generator/process_generator.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

class BlopGenerator extends GeneratorForAnnotation<BlopProcessor> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw 'not class element annotated as BlopProcessor';
    }

    final checker = TypeChecker.fromRuntime(Blop);
    if (element.supertype == null || !checker.isSuperOf(element)) {
      throw 'BlopProcessor must extend Blop';
    }

    final _generator = ProcessorGenerator(element);

    return _generator.generate();
  }
}

Builder generateBlop(BuilderOptions options) =>
    SharedPartBuilder([BlopGenerator()], 'blop_generator');
