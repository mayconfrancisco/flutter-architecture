import 'package:flutter/material.dart';
import 'package:flutter_architecture/ui/components/components.dart';

import '../../pages/pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(
    this.presenter, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            Headline1(title: 'Login'),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                  child: Column(
                children: [
                  StreamBuilder<String>(
                      stream: presenter.emailErrorStream,
                      builder: (context, emailErrorSnapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            errorText: emailErrorSnapshot.hasData &&
                                    emailErrorSnapshot.data.isNotEmpty
                                ? emailErrorSnapshot.data
                                : null,
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                          onChanged: presenter.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: StreamBuilder<String>(
                        stream: presenter.passwordErrorStream,
                        builder: (context, passwordErrorSnapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Senha',
                                errorText: passwordErrorSnapshot.hasData &&
                                        passwordErrorSnapshot.data.isNotEmpty
                                    ? passwordErrorSnapshot.data
                                    : null,
                                icon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            onChanged: presenter.validadePassword,
                          );
                        }),
                  ),
                  StreamBuilder<bool>(
                      stream: presenter.isFormValidStream,
                      builder: (context, isFormValidSnapshot) {
                        return RaisedButton(
                          onPressed:
                              isFormValidSnapshot.data == true ? () {} : null,
                          child: Text('Entrar'.toUpperCase()),
                        );
                      }),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar conta')),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
