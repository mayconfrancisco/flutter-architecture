import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_architecture/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    final loginPage = MaterialApp(home: LoginPage(presenter));
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    await tester.pumpWidget(loginPage);
  }

  // metodo que executa ao final dos testes
  tearDown(() {
    emailErrorController.close();
  });

  testWidgets('Should load with correct initial status',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            'Quando o TextFormField com label de Email tiver apenas UM filho, esse não contém erros, já que o único filho Text é o próprio Label');

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validade with corrects values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validadePassword(password));
  });

  testWidgets('Should present error if email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');
    
    // para atualizar a tela ja que atualizamos a stream - o teste renderizou a tela estaticamente, 
    // temos que atualizar manualemnte;
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });
}
