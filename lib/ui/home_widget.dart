import 'package:flutter/material.dart';

import 'authentification_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splash.png"), fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Image.asset(
                  "assets/agir-logo.png",
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
                          child: Image.asset(
                            "assets/ic-info.png",
                            alignment: Alignment.topCenter,
                            width: 24,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            softWrap: true,
                            textAlign: TextAlign.start,
                            text: const TextSpan(
                              text: 'Agir oui ! Mais comment ?\n',
                              style: TextStyle(
                                fontFamily: 'Marianne',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.5,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Des informations et des recommandations personnalisées pour choisir les gestes les mieux adaptés à chacun et les plus efficaces pour la préservation de l\'environnement.',
                                    style: TextStyle(
                                      fontFamily: 'Marianne',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Material(
                shape: const LinearBorder(),
                color: Colors.black,
                child: InkWell(
                  onTap: () => {
                    Navigator.pushNamed(context, "login")
                  },
                  child: const Center(
                    child: Text(
                      "Agir maintenant !",
                      style: TextStyle(
                          fontFamily: 'Marianne',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
