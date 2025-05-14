import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/data/services/prefs_service.dart';
import 'package:gestao_de_notas/src/domain/domain.dart';
import 'package:gestao_de_notas/src/models/turma_model.dart';

class HomeViewModel {
  final domain = Domain();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueNotifier<List<String>> listaDeAnos = ValueNotifier([]);
  ValueNotifier<String> anoSelecionado = ValueNotifier('');

  ValueNotifier<List<String>> listaDeDisciplina = ValueNotifier([]);
  ValueNotifier<String> disciplinaSelecionada = ValueNotifier('');

  ValueNotifier<List<String>> listaDeEscolas = ValueNotifier([]);
  ValueNotifier<String> escolaSelecionada = ValueNotifier('');

  ValueNotifier<List<TurmaModel>> listaDeTurmas = ValueNotifier([]);

  //TURMAS
  Future<List<TurmaModel>> obterListaDeTurmas() async {
    List<TurmaModel> lista = await domain.getTurmas();

    return lista;
  }

  removerTurma(int index) async {
    List<TurmaModel> lista = [];
    lista.addAll(listaDeTurmas.value);
    listaDeTurmas.value.clear();

    List<TurmaModel> listaLocal = [];
    listaLocal =
        (await obterListaDeTurmas())
            .where(
              (turma) =>
                  lista[index].nome != turma.nome ||
                  lista[index].ano != turma.ano ||
                  lista[index].disciplina != turma.disciplina ||
                  lista[index].escola != turma.escola,
            )
            .toList();
    await domain.setTurmas(listaLocal);
    lista.removeAt(index);
    listaDeTurmas.value = lista;
    await iniciar();
  }

  atualizarListaDeTurmas() async {
    List<TurmaModel> lista = [];
    lista.addAll(await obterListaDeTurmas());

    lista =
        lista
            .where(
              (turma) =>
                  turma.ano.toUpperCase() ==
                      anoSelecionado.value.toUpperCase() &&
                  (disciplinaSelecionada.value.isNotEmpty
                      ? turma.disciplina.toUpperCase() ==
                          disciplinaSelecionada.value.toUpperCase()
                      : true) &&
                  (escolaSelecionada.value.isNotEmpty
                      ? turma.escola.toUpperCase() ==
                          escolaSelecionada.value.toUpperCase()
                      : true),
            )
            .toList();
    listaDeTurmas.value = lista;
  }

  //DROPDOWNS

  iniciarDropdowns() async {
    isLoading.value = true;
    List<TurmaModel> lista = await obterListaDeTurmas();
    listaDeAnos.value = lista.map((turma) => turma.ano).toSet().toList();
    if (listaDeAnos.value.isNotEmpty) {
      setDropdownAno(listaDeAnos.value.first);
    } else {
      anoSelecionado.value = '';
    }
    listaDeDisciplina.value = [];
    disciplinaSelecionada.value = '';
    listaDeEscolas.value = [];
    escolaSelecionada.value = '';
    isLoading.value = false;
  }

  Future<void> setDropdownAno(String newValue) async {
    isLoading.value = true;
    List<TurmaModel> listaLocalDeTurmas = await domain.getTurmas();
    anoSelecionado.value = newValue;

    listaLocalDeTurmas =
        listaLocalDeTurmas
            .where((turma) => turma.ano == anoSelecionado.value)
            .toList();
    escolaSelecionada.value = '';
    listaDeDisciplina.value = [];
    disciplinaSelecionada.value = '';
    listaDeEscolas.value =
        listaLocalDeTurmas.map((turma) => turma.escola).toSet().toList();

    atualizarListaDeTurmas();
    isLoading.value = false;
  }

  Future<void> setDropdownEscola(String escola) async {
    isLoading.value = true;
    escolaSelecionada.value = escola;
    List<TurmaModel> listaLocalDeTurmas = [];

    listaLocalDeTurmas = await obterListaDeTurmas();

    listaLocalDeTurmas =
        listaLocalDeTurmas
            .where(
              (turma) =>
                  turma.escola == escolaSelecionada.value &&
                  turma.ano == anoSelecionado.value,
            )
            .toList();

    disciplinaSelecionada.value = '';
    listaDeDisciplina.value =
        listaLocalDeTurmas.map((turma) => turma.disciplina).toSet().toList();

    atualizarListaDeTurmas();
    isLoading.value = false;
  }

  void setDropdownDisciplina(String disciplina) {
    isLoading.value = true;
    disciplinaSelecionada.value = disciplina;
    atualizarListaDeTurmas();
    isLoading.value = false;
  }

  Future<void> iniciar() async {
    await iniciarDropdowns();
    await atualizarListaDeTurmas();
  }

  Future<void> clearAll() async {
    await PrefsService().clearAll();
    iniciar();
  }
}
