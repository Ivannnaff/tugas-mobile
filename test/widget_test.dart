import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_pendaftaran/main.dart';

void main() {
  testWidgets('Form screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Pendaftaran Kegiatan'), findsOneWidget);
    expect(find.text('SIMPAN'), findsOneWidget);
  });
}
