import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/home/crud_diciplina/crud_disciplina_page.dart';
import 'package:gestao_de_notas/src/view/home/crud_escola/crud_escola_page.dart';
import 'package:gestao_de_notas/src/view/home/crud_turma/crud_turma_page.dart';
import 'package:gestao_de_notas/src/view/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Notas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.green),
          ),
        ),

        colorScheme: ColorScheme.light(
          primary: Colors.blueGrey,
          secondary: Colors.green,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/disciplinas': (context) => const CrudDisciplinaPage(),
        '/escolas': (context) => const CrudEscolaPage(),
        '/turmas': (context) => const CrudTurmaPage(),
      },
    );
  }
}
