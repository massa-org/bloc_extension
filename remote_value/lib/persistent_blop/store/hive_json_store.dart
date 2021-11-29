import 'dart:convert';

import 'hive_string_store.dart';

class HiveJsonStore<T> extends HiveStringStore<T> {
  final dynamic Function(T object) toJson;
  final T Function(dynamic value) fromJson;

  HiveJsonStore(this.toJson, this.fromJson)
      : super(
          encode: (v) => jsonEncode(toJson(v)),
          decode: (v) => fromJson(jsonDecode(v)),
        );
}
