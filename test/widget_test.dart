import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bitewise_front/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Constrói o app e dispara um frame.
    await tester.pumpWidget(const BiteWiseApp());

    // Verifica se o título (que está na AppBar ou Home) aparece.
    // Como a tela inicial pode ser Onboarding ou Home, procuramos por algo genérico.
    // Mas como é só um smoke test, apenas garantir que pumpWidget não deu erro já é um bom começo.

    // Aguarda animações (Lottie, etc)
    await tester.pumpAndSettle();

    // Se chegou aqui sem crashar, o teste passou.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}