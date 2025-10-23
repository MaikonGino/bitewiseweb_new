import 'package:flutter_test/flutter_test.dart';
import 'package:bitewise_app/main.dart';

void main() {
  testWidgets('StartScreen shows key elements smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BiteWiseApp());

    expect(find.text('BiteWise'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
    expect(find.text('Já tem conta? Fazer login'), findsOneWidget);
  });
}