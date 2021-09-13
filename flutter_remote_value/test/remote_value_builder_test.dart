import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remote_value/flutter_remote_value.dart';
import 'package:flutter_remote_value/remote_value_builder.dart';
import 'package:flutter_remote_value/remote_value_theme.dart';
import 'package:flutter_test/flutter_test.dart';

class TestProvider extends RemoteValueBlop<String> {
  TestProvider() : super.staticLoader(() => 'reload', reloadOnCreate: false);
}

class TestWidget extends StatelessWidget {
  const TestWidget(this.provider, {Key? key}) : super(key: key);

  final TestProvider provider;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider.value(
          value: provider,
          child: RemoteValueTheme(
            loadingBuilder: (_, ctx) => Text('progress'),
            errorBuilder: (_, ctx, cb, text) => ElevatedButton(
              onPressed: cb,
              child: Text('error: $text'),
            ),
            child: RemoteValueBuilder<TestProvider, String>(
              builder: (ctx, data) => Text('data: $data'),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Display progress on initial', (WidgetTester tester) async {
    final provider = TestProvider();

    await tester.pumpWidget(TestWidget(provider));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);
    await tester.pump(Duration(milliseconds: 30));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);
  });

  testWidgets('Display progress on loading', (WidgetTester tester) async {
    final provider = TestProvider();
    provider.emit(RemoteModel.loading());

    await tester.pumpWidget(TestWidget(provider));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);
    await tester.pump(Duration(milliseconds: 30));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);
  });

  testWidgets('Display error', (WidgetTester tester) async {
    final provider = TestProvider();

    await tester.pumpWidget(TestWidget(provider));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);

    final error = Random().nextInt(1 << 30).toString();
    provider.emit(RemoteModel.error(error));
    await tester.pump(Duration(milliseconds: 30));

    expect(find.text('progress'), findsNothing);
    expect(find.text('data: value'), findsNothing);
    expect(find.text('error: ${error}'), findsOneWidget);
  });

  testWidgets('Display value', (WidgetTester tester) async {
    final provider = TestProvider();

    await tester.pumpWidget(TestWidget(provider));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);

    final value = Random().nextInt(1 << 30).toString();
    provider.emit(RemoteModel.data(value));
    await tester.pump(Duration(milliseconds: 30));

    expect(find.text('progress'), findsNothing);
    expect(find.text('data: ${value}'), findsOneWidget);
    expect(find.text('error: ${value}'), findsNothing);
  });

  testWidgets('Reload from error', (WidgetTester tester) async {
    final provider = TestProvider();

    await tester.pumpWidget(TestWidget(provider));
    expect(find.text('progress'), findsOneWidget);
    expect(find.text('data: value'), findsNothing);

    final error = Random().nextInt(1 << 30).toString();
    provider.emit(RemoteModel.error(error));
    await tester.pump(Duration(milliseconds: 30));

    expect(find.text('progress'), findsNothing);
    expect(find.text('data: value'), findsNothing);
    expect(find.text('error: ${error}'), findsOneWidget);

    await tester.tap(find.text('error: ${error}'));

    await tester.pumpAndSettle();

    expect(find.text('progress'), findsNothing);
    expect(find.text('error: ${error}'), findsNothing);
    expect(find.text('data: reload'), findsOneWidget);
  });
}
