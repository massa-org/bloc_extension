import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'remote_value_error.dart';
import 'remote_value_progress.dart';

Widget _wrap(bool isSliver, Widget child) {
  if (isSliver) return SliverToBoxAdapter(child: child);
  return child;
}

Widget _defaultLoadingBuilder(
  bool inSliver,
  BuildContext context,
) =>
    _wrap(inSliver, DefaultRemoteValueProgress());

Widget _defaultErrorBuilder(
  bool inSliver,
  BuildContext _,
  void Function() cb,
  dynamic err,
) =>
    _wrap(inSliver, DefaultRemoteValueErrorWidget(onReload: cb));

Widget _emptyBuilder(bool inSliver, [_1, _2, _3]) =>
    _wrap(inSliver, SizedBox.shrink());

class RemoteValueThemeData {
  // can't compare this builders and this call rebuild every time it changes
  final Widget Function(
    bool inSliver,
    BuildContext context,
    void Function() reloadCb,
    dynamic error,
  ) errorBuilder;

  final Widget Function(
    bool inSliver,
    BuildContext context,
  ) loadingBuilder;

  final String errorButtonText;

  const RemoteValueThemeData([
    this.errorBuilder = _defaultErrorBuilder,
    this.loadingBuilder = _defaultLoadingBuilder,
    this.errorButtonText = 'Loading error retry?',
  ]);

  const RemoteValueThemeData.onlyData()
      : errorBuilder = _emptyBuilder,
        loadingBuilder = _emptyBuilder,
        errorButtonText = '';
}

class _ThemeCubit extends Cubit<RemoteValueThemeData> {
  _ThemeCubit(RemoteValueThemeData initialState) : super(initialState);
}

class RemoteValueTheme extends BlocProvider<_ThemeCubit> {
  // loader and error replaced by SizedBox.shrink()
  RemoteValueTheme.onlyData(Widget child)
      : super(
          create: (ctx) => _ThemeCubit(RemoteValueThemeData.onlyData()),
          child: child,
        );

  RemoteValueTheme({
    Key? key,
    required Widget child,
    Widget Function(
      bool inSliver,
      BuildContext context,
      void Function() reloadCb,
      dynamic error,
    )?
        errorBuilder,
    Widget Function(
      bool inSliver,
      BuildContext context,
    )?
        loadingBuilder,
    String? defaultErrorButtonText,
  }) : super(
          create: (ctx) => _ThemeCubit(
            RemoteValueThemeData(
              errorBuilder ?? _defaultErrorBuilder,
              loadingBuilder ?? _defaultLoadingBuilder,
              defaultErrorButtonText ?? 'Loading error retry?',
            ),
          ),
          child: child,
        );

  static RemoteValueThemeData of(BuildContext context) {
    try {
      return context.watch<_ThemeCubit>().state;
    } catch (err) {
      return const RemoteValueThemeData();
    }
  }
}
