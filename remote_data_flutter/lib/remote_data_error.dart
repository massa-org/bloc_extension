import 'package:flutter/material.dart';
import 'package:remote_data_flutter/remote_data_theme.dart';

class RemoteDataErrorWidget extends StatelessWidget {
  final void Function() onReload;

  const RemoteDataErrorWidget({Key? key, required this.onReload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
      child: Center(
        child: TextButton(
          onPressed: onReload,
          child: Text(RemoteDataTheme.of(context).errorButtonText),
        ),
      ),
    );
  }
}
