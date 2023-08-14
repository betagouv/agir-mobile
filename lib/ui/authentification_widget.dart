import 'package:agir/authentification/redux/authentification_actions.dart';
import 'package:agir/ui/landing_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../agir_state.dart';

enum LoginViewState { LOGGED, NOT_LOGGED }

class LoginViewModel extends Equatable {
  final LoginViewState loginViewState;

  const LoginViewModel._internal(this.loginViewState);

  factory LoginViewModel(AgirState agirState) {
    if (agirState.utilisateurState.id.isEmpty) {
      return const LoginViewModel._internal(LoginViewState.NOT_LOGGED);
    } else {
      return const LoginViewModel._internal(LoginViewState.LOGGED);
    }
  }

  @override
  List<Object?> get props => [loginViewState];
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AgirState, LoginViewModel>(
      converter: (store) => LoginViewModel(store.state),
      distinct: true,
      onWillChange: (LoginViewModel? old, LoginViewModel? actual) {
        if (actual?.loginViewState == LoginViewState.LOGGED) {
          Navigator.pushReplacementNamed(context, "coach");
        }
      },
      onInitialBuild: (LoginViewModel vm) {
        if (vm.loginViewState == LoginViewState.LOGGED) {
          Navigator.pushReplacementNamed(context, "coach");
        }
      },
      builder: (BuildContext context, LoginViewModel vm) => Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.16),
                  blurRadius: 6,
                  offset: const Offset(0, 6),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  'Agir !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'L’accompagnement personnalisé pour réduire votre empreinte écologique',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('Mesurez les impacts de vos usages au quotidien \n'
                    'Simulez des aides pertinentes adaptées à votre situation \n'
                    'Testez vos connaissances'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Identifiant',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      doAuthentification(_usernameController.text, context),
                  child: const Text('Se connecter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void doAuthentification(String userName, BuildContext buildContext) {
    final store = StoreProvider.of<AgirState>(buildContext);
    store.dispatch(DoAuthentificationAction(userName));
  }
}

class HomeArgs {
  final String userName;

  HomeArgs(this.userName);
}
