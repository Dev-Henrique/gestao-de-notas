import 'package:flutter/widgets.dart';
import 'package:gestao_de_notas/src/domain/domain.dart';
import 'package:gestao_de_notas/src/models/aluno_model.dart';
import 'package:gestao_de_notas/src/models/turma_model.dart';

class TabelaViewModel {
  final domain = Domain();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  List<AlunoModel> listaDeAlunos = [];
  List<String> listaDeAtividades = [];
  String atividadeSelecionada = '';
  String nomeDaTurma = '';

  getTurma(TurmaModel turma) async {
    isLoading.value = true;
    List<TurmaModel> listaDeTurmas = await domain.getTurmas();
    TurmaModel turmaLocal =
        listaDeTurmas[listaDeTurmas.indexWhere(
          (turmaIndex) =>
              turma.nome == turmaIndex.nome &&
              turma.ano == turmaIndex.ano &&
              turma.disciplina == turmaIndex.disciplina &&
              turma.escola == turmaIndex.escola,
        )];
    //altera nome da turma
    nomeDaTurma = turmaLocal.nome;
    //altera lista de alunos
    listaDeAlunos = turmaLocal.alunos;
    //altera lista de atividades
    if (turmaLocal.alunos.isNotEmpty) {
      listaDeAtividades = turmaLocal.alunos[0].notas.keys.toList();
      if (listaDeAtividades.isNotEmpty) {
        atividadeSelecionada = listaDeAtividades.first;
      }
    }

    // await Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
  }

  alterarAtividade(String direcao) {
    isLoading.value = true;
    if (direcao == 'direita') {
      if (listaDeAtividades.indexWhere(
            (atividade) => atividadeSelecionada == atividade,
          ) <
          listaDeAtividades.length - 1) {
        atividadeSelecionada =
            listaDeAtividades[listaDeAtividades.indexWhere(
                  (atividade) => atividadeSelecionada == atividade,
                ) +
                1];
      }
    } else {
      if (listaDeAtividades.indexWhere(
            (atividade) => atividadeSelecionada == atividade,
          ) >
          0) {
        atividadeSelecionada =
            listaDeAtividades[listaDeAtividades.indexWhere(
                  (atividade) => atividadeSelecionada == atividade,
                ) -
                1];
      }
    }
    isLoading.value = false;
  }

  alterarNota(double novaNota, int indexAluno) {
    isLoading.value = true;
    listaDeAlunos[indexAluno].notas[atividadeSelecionada] = novaNota;
    isLoading.value = false;
  }

  double getNotaDoAluno(int index) {
    return listaDeAlunos[index].notas[atividadeSelecionada] ?? 0.0;
  }

  void cadastrarAtividade(String newValue) {
    isLoading.value = true;
    for (var aluno in listaDeAlunos) {
      aluno.notas[newValue] = 0.0;
    }
    listaDeAtividades.add(newValue);
    if (listaDeAtividades.isNotEmpty) {
      atividadeSelecionada = listaDeAtividades.first;
    }

    isLoading.value = false;
  }
}
