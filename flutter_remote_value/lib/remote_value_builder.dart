import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:remote_data/remote_blop.dart';
import 'package:remote_value/remote_value.dart';

import 'remote_value_theme.dart';

class RemoteValueBuilder<T extends RemoteValueBlop<E>, E>
    extends StatelessWidget {
  RemoteValueBuilder({Key? key, required this.builder, this.isSliver = false})
      : super(key: key);

  final bool isSliver;
  final Widget Function(BuildContext context, E data) builder;

  @override
  Widget build(BuildContext context) {
    final theme = RemoteDataTheme.of(context);
    return context.select(
      (T value) => value.state.maybeWhen(
        data: (data) => builder(context, data),
        error: (e) => theme.errorBuilder(
          isSliver,
          context,
          context.read<T>().reload,
          e,
        ),
        orElse: () => theme.loadingBuilder(isSliver, context),
      ),
    );
  }
}
