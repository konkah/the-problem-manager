import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:the_problem_manager/menstruationList.dart';

import 'datesForm.dart';
import 'nameForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Problem Manager',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              children: [
                register(),
                dates(),
                menstruations(),
                project(),
              ],
            ),
            appBar: AppBar(
              title: Text("Apresentação"),
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.app_registration)),
                Tab(icon: Icon(Icons.calendar_today_outlined)),
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.report_rounded))
              ]),
            ),
          )),
    );
  }

  Widget register() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: NameForm(),
    );
  }

  Widget dates() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: DatesForm(),
    );
  }

  Widget menstruations() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: MenstruationList(),
    );
  }

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

  Widget project(){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(children: [
        Text("The Problem Manager" "\n"),
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
                " e confiável para ambos os lados."),
      ]),
    );
  }
}
