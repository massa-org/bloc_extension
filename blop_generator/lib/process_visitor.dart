import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:blop/annotations.dart';
import 'package:blop_generator/method_generator.dart';
import 'package:source_gen/source_gen.dart';

class ProcessVisitor extends SimpleElementVisitor<void> {
  final DartType stateType;
  List<MethodGenerator> data = [];

  ProcessVisitor(this.stateType);

  @override
  void visitMethodElement(MethodElement element) {
    final typeChecker = TypeChecker.fromRuntime(BlopProcess);
    if (typeChecker.hasAnnotationOf(element)) {
      data.add(MethodGenerator(element, stateType));
    }

    super.visitMethodElement(element);
  }
}
