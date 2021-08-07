import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_data_flutter/remote_data_error.dart';
import 'package:remote_data_flutter/remote_data_progress.dart';

class RemoteDataThemeData {
  // can't compare this builders and this call rebuild every time it changes
  final Widget Function(
    BuildContext context,
    void Function() reloadCb,
    dynamic error,
  ) errorBuilder;

  final Widget Function(BuildContext context) loadingBuilder;

  final String errorButtonText;

  RemoteDataThemeData([
    errorBuilder,
    loadingBuilder,
    String? errorText,
  ])  : this.errorButtonText = errorText ?? 'Loading error retry?',
        this.loadingBuilder = loadingBuilder ?? ((_) => RemoteDataProgress()),
        this.errorBuilder = errorBuilder ??
            ((_, cb, err) => RemoteDataErrorWidget(onReload: cb));
}

class _ThemeCubit extends Cubit<RemoteDataThemeData> {
  _ThemeCubit(RemoteDataThemeData initialState) : super(initialState);
}

class RemoteDataTheme extends BlocProvider<_ThemeCubit> {
  RemoteDataTheme({
    Key? key,
    required Widget child,
    Widget Function(BuildContext context, dynamic error)? errorBuilder,
    Widget Function(BuildContext context)? loadingBuilder,
    String? defaultErrorButtonText,
  }) : super(
          create: (ctx) => _ThemeCubit(RemoteDataThemeData(
            errorBuilder,
            loadingBuilder,
            defaultErrorButtonText,
          )),
          child: child,
        );

  static RemoteDataThemeData of(BuildContext context) {
    try {
      return context.watch<_ThemeCubit>().state;
    } catch (err) {
      return RemoteDataThemeData();
    }
  }
}
