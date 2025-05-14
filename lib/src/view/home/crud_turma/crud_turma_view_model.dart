import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/domain/domain.dart';
import 'package:gestao_de_notas/src/models/aluno_model.dart';
import 'package:gestao_de_notas/src/models/turma_model.dart';

class CrudTurmaViewModel {
  final domain = Domain();
  ValueNotifier<List<TurmaModel>> listaDeTurmas =
      ValueNotifier<List<TurmaModel>>([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  getTurmas() async {
    List<TurmaModel> lista = await domain.getTurmas();
    listaDeTurmas.value = lista;
  }

  Future<void> removeTurma(int index) async {
    List<TurmaModel> lista = [];
    lista.addAll(listaDeTurmas.value);
    listaDeTurmas.value.clear();
    lista.removeAt(index);
    listaDeTurmas.value = lista;
    await domain.setTurmas(listaDeTurmas.value);
  }

  cadastrarTurma() async {
    isLoading.value = true;
    List<TurmaModel> lista = [];
    lista.addAll(await domain.getTurmas());
    TurmaModel turma = TurmaModel(
      nome: nomeDaTurma.value.text,
      escola: escolaSelecionada.value,
      ano: anoSelecionado.value,
      disciplina: disciplinaSelecionado.value,
      alunos: listaDeAlunos.value,
    );

    lista.add(turma);
    listaDeTurmas.value = lista;
    await domain.setTurmas(lista);
    isLoading.value = false;
  }

  //EDITOR
  ValueNotifier<List<AlunoModel>> listaDeAlunos =
      ValueNotifier<List<AlunoModel>>([]);

  ValueNotifier<TextEditingController> nomeDaTurma =
      ValueNotifier<TextEditingController>(TextEditingController(text: ''));

  ValueNotifier<String> escolaSelecionada = ValueNotifier('');
  List<String> listaDeEscolas = [];

  ValueNotifier<String> anoSelecionado = ValueNotifier('');
  List<String> listaDeAnos = [];

  ValueNotifier<String> disciplinaSelecionado = ValueNotifier('');
  List<String> listaDeDisciplinas = [];

  getAll() async {
    listaDeEscolas = await domain.getEscolas();
    listaDeAnos = [
      DateTime.now().year.toString(),
      (DateTime.now().year + 1).toString(),
    ];
    listaDeDisciplinas = await domain.getDisciplinas();

    if (listaDeEscolas.isNotEmpty) {
      escolaSelecionada.value = listaDeEscolas.first;
    }
    if (listaDeAnos.isNotEmpty) {
      anoSelecionado.value = listaDeAnos.first;
    }
    if (listaDeDisciplinas.isNotEmpty) {
      disciplinaSelecionado.value = listaDeDisciplinas.first;
    }
  }

  void removeAluno(int index) {
    List<AlunoModel> lista = [];
    lista.addAll(listaDeAlunos.value);
    listaDeAlunos.value.clear();

    lista.removeAt(index);
    listaDeAlunos.value = lista;
  }

  void cadastrarAluno(String newValue) {
    List<AlunoModel> lista = [];
    lista.addAll(listaDeAlunos.value);
    AlunoModel aluno = AlunoModel(name: newValue, notas: {}, media: 0.0);
    lista.add(aluno);
    listaDeAlunos.value.clear();
    listaDeAlunos.value = lista;
  }

  Future<void> editarAluno(int index, String newValue) async {
    List<AlunoModel> lista = [];
    lista.addAll(listaDeAlunos.value);
    lista[index].name = newValue;
    listaDeAlunos.value.clear();
    listaDeAlunos.value = lista;
  }

  void setDropdownEscola(String? value) {
    if (value != null) {
      escolaSelecionada.value = value;
    }
  }

  void setDropdownAno(String? value) {
    if (value != null) {
      anoSelecionado.value = value;
    }
  }

  void setDropdownDisciplina(String? value) {
    if (value != null) {
      disciplinaSelecionado.value = value;
    }
  }

  void setNomeTurma(String? newValue) {
    if (newValue != null) {
      nomeDaTurma.value.text = newValue;
    }
  }
}
