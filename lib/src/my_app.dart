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
          backgroundColor: Color(0xff1b78b1),
          foregroundColor: Color(0xfff2f9fd),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(0xff1b78b1)),
          ),
        ),

        colorScheme: ColorScheme.light(
          surface: Color(0xfff2f9fd),
          onSurface: Color(0xff102b41),
          primary: Color(0xff1b78b1),
          onPrimary: Color(0xfff2f9fd),
          secondary: Color(0xff1b78b1),
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
