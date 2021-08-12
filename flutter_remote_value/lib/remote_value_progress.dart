import 'package:flutter/material.dart';

class DefaultRemoteValueProgress extends StatelessWidget {
  const DefaultRemoteValueProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
