import 'package:flutter/material.dart';

class Archive {
  Widget developer(){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(children: [
        Image.asset('assets/images/konkah.jpg',
            height: 120, fit: BoxFit.fitHeight),
        Text("\n" "Karlos Helton Braga" "\n"),
        Text("Estou cursando TADS e espero ser este o meu último"
            " ano de graduação (se tudo der certo, hahaha)."
            " Estagio na Unicamp (GGTE) onde analiso dados usando Python"
            " e trabalho como trainee na empresa Inmetrics como DevOps."
            "\n"
            "\n"
            "Meu hobby (antes da pandemia e espero ser depois também)"
            " é visitar museus, sebos, espaços culturais, teatros,"
            "  bibliotecas, etc... Atualmente tenho a companhia de dois gatos,"
            " ainda farei deles grandes programadores!"),
      ]),
    );
  }

  Widget interns(){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Whisky.jpeg',
                height: 120, fit: BoxFit.fitHeight),
            Image.asset('assets/images/Guts.jpeg',
                height: 120, fit: BoxFit.fitHeight)
          ],
        ),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Estagiários de Desenvolvimento" "\n"),
                Text(
                    "Formados em Programação pela plataforma Scratch,"
                        " especialistas em AutoCat, trabalham 7 horas e"
                        " dormem outras 17 horas.\n\nSoube que seus ancestrais"
                        " criaram o comando cat do Linux... Esses estagiários"
                        " são o Bicho!"),
              ],
            )),
      ]),
    );
  }
}
