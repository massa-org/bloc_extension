import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_data_flutter/remote_data_error.dart';
import 'package:remote_data_flutter/remote_data_progress.dart';

Widget _wrap(bool isSliver, Widget child) {
  if (isSliver) return SliverToBoxAdapter(child: child);
  return child;
}

Widget _defaultLoadingBuilder(
  bool inSliver,
  BuildContext context,
) =>
    _wrap(inSliver, RemoteDataProgress());

Widget _defaultErrorBuilder(
  bool inSliver,
  BuildContext _,
  void Function() cb,
  dynamic err,
) =>
    _wrap(inSliver, RemoteDataErrorWidget(onReload: cb));

// ignore: unused_element
Widget _emptyBuilder(bool inSliver, [_1, _2, _3]) =>
    _wrap(inSliver, SizedBox.shrink());

class RemoteDataThemeData {
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

  const RemoteDataThemeData([
    this.errorBuilder = _defaultErrorBuilder,
    this.loadingBuilder = _defaultLoadingBuilder,
    this.errorButtonText = 'Loading error retry?',
  ]);

  const RemoteDataThemeData.onlyData()
      : errorBuilder = _emptyBuilder,
        loadingBuilder = _emptyBuilder,
        errorButtonText = '';
}

class _ThemeCubit extends Cubit<RemoteDataThemeData> {
  _ThemeCubit(RemoteDataThemeData initialState) : super(initialState);
}

class RemoteDataTheme extends BlocProvider<_ThemeCubit> {
  // loader and error replaced by SizedBox.shrink()
  RemoteDataTheme.onlyData(Widget child)
      : super(
          create: (ctx) => _ThemeCubit(RemoteDataThemeData.onlyData()),
          child: child,
        );

  RemoteDataTheme({
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
            RemoteDataThemeData(
              errorBuilder ?? _defaultErrorBuilder,
              loadingBuilder ?? _defaultLoadingBuilder,
              defaultErrorButtonText ?? 'Loading error retry?',
            ),
          ),
          child: child,
        );

  static RemoteDataThemeData of(BuildContext context) {
    try {
      return context.watch<_ThemeCubit>().state;
    } catch (err) {
      return const RemoteDataThemeData();
    }
  }
}
