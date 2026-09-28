import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:att_flut/main.dart';

void main() {
  testWidgets('Verifica renderizacao do catalogo e adicao de item (Desafio 1)', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    expect(find.text('Catálogo de Produtos'), findsOneWidget);
    expect(find.text('Itens: 5'), findsOneWidget);
    expect(find.text('Smartphone Galaxy S24'), findsOneWidget);

    // Toca no FloatingActionButton para adicionar produto
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que o contador incrementou para 6
    expect(find.text('Itens: 6'), findsOneWidget);
  });

  testWidgets('Verifica remocao de item por gesto Dismissible (Desafio 2)', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    expect(find.text('Smartphone Galaxy S24'), findsOneWidget);

    // Desliza da direita para esquerda para remover o primeiro item
    await tester.drag(find.text('Smartphone Galaxy S24'), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    // Verifica que o item foi removido da lista
    expect(find.text('Smartphone Galaxy S24'), findsNothing);
    expect(find.text('Itens: 4'), findsOneWidget);
    expect(find.text('Produto "Smartphone Galaxy S24" foi removido.'), findsOneWidget);
  });

  testWidgets('Verifica navegacao para tela de detalhes do produto (Desafio 3)', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // Toca no primeiro produto
    await tester.tap(find.text('Smartphone Galaxy S24'));
    await tester.pumpAndSettle();

    // Verifica que navegou para DetalhesProdutoScreen
    expect(find.text('Detalhes do Produto'), findsOneWidget);
    expect(find.text('#1'), findsOneWidget);
    expect(find.text('Eletrônicos'), findsOneWidget);
    expect(find.text('R\$ 4500.00'), findsOneWidget);
  });
}
