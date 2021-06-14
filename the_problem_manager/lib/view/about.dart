import 'package:flutter/material.dart';

import 'common.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Common.title("Sobre"),
      Common.divider(),
      Text(
        "A ideia do aplicativo é criar um calendário para cadastrar as datas"
        " das menstruações, porém seu foco é para as pessoas sem útero."
        "\n"
        "\n"
        "Assim, os usuários do app ficam sabendo das datas mais críticas"
        " e recebem lembretes/dicas para ajudar quem está com dificuldades"
        " durante este período."
        "\n"
        "\n"
        "A ideia é ser útil para se relacionar entre namorados, familiares"
        " e pessoas próximas. Tornando a relação mais saudável, estável"
        " e confiável para ambos os lados."
      ),
    ]);
  }
}