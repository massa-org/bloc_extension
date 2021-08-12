import 'package:flutter/material.dart';

import 'remote_value_theme.dart';

class DefaultRemoteValueErrorWidget extends StatelessWidget {
  final void Function() onReload;

  const DefaultRemoteValueErrorWidget({Key? key, required this.onReload})
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
