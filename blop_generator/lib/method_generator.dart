import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:blop_generator/return_type_switch.dart';

class MethodGenerator {
  final String? processName;
  final String? originalName;
  final MethodElement element;

  final DartType stateType;

  bool get generate => processName != null;

  MethodGenerator(this.element, this.stateType)
      : processName = _getProcessName(element),
        originalName = element.name;

  static String? _getProcessName(Element element) {
    final name = element.name;
    if (name == null) throw 'Method has no name';

    final nameFromAnnotation = element.metadata[0]
        .computeConstantValue()
        ?.getField('name')
        ?.toStringValue();

    if (nameFromAnnotation == null && !name.startsWith('_')) {
      return null;
    }
    return nameFromAnnotation ?? name.substring(1);
  }

  String _genFullParams() {
    final typeParams = element.typeParameters.isNotEmpty
        ? '<${element.typeParameters.join(',')}>'
        : '';
    return '$typeParams(${_genParams()})';
  }

  String _genParams() {
    final params = element.parameters;
    final buffer = StringBuffer();

    final req = params.where((e) => e.isRequiredPositional);
    final opt = params.where((e) => e.isOptionalPositional);
    final nam = params.where((e) => e.isNamed);

    if (req.isNotEmpty) buffer.write(req.join(',') + ',');
    if (opt.isNotEmpty)
      buffer.write(
        '[' +
            opt
                .map((e) => e.toString())
                .map((e) => e.substring(1, e.length - 1))
                .join(',') +
            ',]',
      );
    if (nam.isNotEmpty)
      buffer.write(
        '{' +
            nam
                .map((e) => e.toString())
                .map((e) => e.substring(1, e.length - 1))
                .join(',') +
            ',}',
      );
    return buffer.toString();
  }

  String get implString => '$processName${_genFullParams()}';

  String get defString {
    var returnString = returnTypeSwitch(
      stateType,
      element,
      same: () => '$stateType',
      future: () => 'Future<$stateType>',
      futureOr: () => 'FutureOr<$stateType>',
      stream: () => 'Stream<$stateType>',
      orElse: () => null,
    );

    return '$returnString $originalName${_genFullParams()};\n';
  }

  String get callString {
    final callParams = element.parameters
        .map((e) => (e.isNamed ? e.name + ':' : '') + e.name)
        .join(',');
    return '$originalName($callParams)';
  }
}
