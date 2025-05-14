import 'package:flutter/widgets.dart';
import 'package:gestao_de_notas/src/domain/domain.dart';

class CrudDisciplinasViewModel {
  final domain = Domain();
  ValueNotifier<List<String>> listaDeDisciplinas = ValueNotifier([]);

  getDisciplinas() async {
    List<String> lista = await domain.getDisciplinas();
    listaDeDisciplinas.value = lista;
  }

  Future<void> cadastrarDisciplina(String disciplina) async {
    List<String> lista = [];
    lista.addAll(listaDeDisciplinas.value);
    lista.add(disciplina);
    listaDeDisciplinas.value.clear();
    listaDeDisciplinas.value = lista;

    await domain.setDisciplinas(lista);
  }

  Future<void> removeDisciplina(int index) async {
    List<String> lista = [];
    lista.addAll(listaDeDisciplinas.value);
    listaDeDisciplinas.value.clear();
    lista.removeAt(index);
    listaDeDisciplinas.value = lista;

    await domain.setDisciplinas(listaDeDisciplinas.value);
  }
}
