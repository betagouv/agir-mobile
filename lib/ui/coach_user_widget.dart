import 'package:agir/agir_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CoachUserViewModel {
  final String userName;

  const CoachUserViewModel._internal(this.userName);

  factory CoachUserViewModel(AgirState state) {
    return CoachUserViewModel._internal(state.utilisateurState.nom);
  }
}

class CoachUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AgirState, CoachUserViewModel>(
        builder: (BuildContext context, CoachUserViewModel vm) => RichText(
          softWrap: true,
          textAlign: TextAlign.start,
          text: TextSpan(
            text: "Salut ${vm.userName},\n",
            style: const TextStyle(
              fontFamily: 'Marianne',
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: Colors.black,
              height: 1.5,
            ),
            children: const <TextSpan>[
              TextSpan(
                  text:
                  'On se lance ?',
                  style: TextStyle(
                    fontFamily: 'Marianne',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Color(0xFF3A3A3A),
                  )),
            ],
          ),
        ),
        converter: (store) => CoachUserViewModel(store.state));
  }
}
