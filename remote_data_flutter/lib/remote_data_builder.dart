import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_data/remote_blop.dart';
import 'package:remote_data_flutter/remote_data_theme.dart';

class RemoteDataBuilder<T extends RemoteDataBlop<E>, E>
    extends StatelessWidget {
  RemoteDataBuilder({Key? key, required this.builder, this.isSliver = false})
      : super(key: key);

  final bool isSliver;
  final Widget Function(BuildContext context, E data) builder;

  Widget _wrap(Widget child) {
    if (isSliver) return SliverToBoxAdapter(child: child);
    return child;
  }

  @override
  Widget build(BuildContext context) {
    final theme = RemoteDataTheme.of(context);
    return context.select(
      (T value) => value.state.maybeWhen(
        data: (data) => builder(context, data),
        error: (e) => _wrap(
          theme.errorBuilder(context, () => context.read<T>().reload(), e),
        ),
        orElse: () => _wrap(theme.loadingBuilder(context)),
      ),
    );
  }
}
