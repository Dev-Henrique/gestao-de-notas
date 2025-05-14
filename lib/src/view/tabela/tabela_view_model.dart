import 'package:flutter/widgets.dart';
import 'package:gestao_de_notas/src/domain/domain.dart';
import 'package:gestao_de_notas/src/models/aluno_model.dart';
import 'package:gestao_de_notas/src/models/turma_model.dart';

class TabelaViewModel {
  final domain = Domain();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  List<String> bimestres = [
    '1º Bimestre',
    '2º Bimestre',
    '3º Bimestre',
    '4º Bimestre',
  ];
  String bimestreSelecionado = '_value';
  List<AlunoModel> listaDeAlunos = [];
  List<String> listaDeAtividades = [];
  String atividadeSelecionada = '';
  String nomeDaTurma = '';

  getTurma(TurmaModel turma) async {
    isLoading.value = true;
    bimestreSelecionado = bimestres.first;
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
      listaDeAtividades = turmaLocal.alunos[0].bimestre1.keys.toList();
      if (listaDeAtividades.isNotEmpty) {
        atividadeSelecionada = listaDeAtividades.first;
      }
    }

    // await Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
  }

  alterarBimestre(String input) async {
    isLoading.value = true;
    if (input == 'direita') {
      if (bimestres.indexWhere((bi) => bimestreSelecionado == bi) <
          bimestres.length - 1) {
        bimestreSelecionado =
            bimestres[bimestres.indexWhere((bi) => bimestreSelecionado == bi) +
                1];
      }
    } else {
      if (bimestres.indexWhere((bi) => bimestreSelecionado == bi) > 0) {
        bimestreSelecionado =
            bimestres[bimestres.indexWhere((bi) => bimestreSelecionado == bi) -
                1];
      }
    }
    await getAtividadesPorBimestre();
    isLoading.value = false;
  }

  Future<void> cadastrarAtividade(String newValue) async {
    isLoading.value = true;
    for (var aluno in listaDeAlunos) {
      if (bimestreSelecionado == '1º Bimestre') {
        aluno.bimestre1[newValue] = 0.0;
      } else if (bimestreSelecionado == '2º Bimestre') {
        aluno.bimestre2[newValue] = 0.0;
      } else if (bimestreSelecionado == '3º Bimestre') {
        aluno.bimestre3[newValue] = 0.0;
      } else if (bimestreSelecionado == '4º Bimestre') {
        aluno.bimestre4[newValue] = 0.0;
      }
    }
    await getAtividadesPorBimestre();
    if (listaDeAtividades.isNotEmpty) {
      atividadeSelecionada = listaDeAtividades.first;
    }

    isLoading.value = false;
  }

  Future<void> getAtividadesPorBimestre() async {
    if (bimestreSelecionado == '1º Bimestre') {
      listaDeAtividades = listaDeAlunos[0].bimestre1.keys.toList();
    } else if (bimestreSelecionado == '2º Bimestre') {
      listaDeAtividades = listaDeAlunos[0].bimestre2.keys.toList();
    } else if (bimestreSelecionado == '3º Bimestre') {
      listaDeAtividades = listaDeAlunos[0].bimestre3.keys.toList();
    } else if (bimestreSelecionado == '4º Bimestre') {
      listaDeAtividades = listaDeAlunos[0].bimestre4.keys.toList();
    }
    atividadeSelecionada =
        listaDeAtividades.isNotEmpty ? listaDeAtividades.first : '';
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
    if (bimestreSelecionado == '1º Bimestre') {
      listaDeAlunos[indexAluno].bimestre1[atividadeSelecionada] = novaNota;
      listaDeAlunos[indexAluno].notaBimestre1 = alterarNotaBimestral(
        indexAluno,
        listaDeAlunos[indexAluno].bimestre1.values.toList(),
      );
    } else if (bimestreSelecionado == '2º Bimestre') {
      listaDeAlunos[indexAluno].bimestre2[atividadeSelecionada] = novaNota;
      listaDeAlunos[indexAluno].notaBimestre2 = alterarNotaBimestral(
        indexAluno,
        listaDeAlunos[indexAluno].bimestre2.values.toList(),
      );
    } else if (bimestreSelecionado == '3º Bimestre') {
      listaDeAlunos[indexAluno].bimestre3[atividadeSelecionada] = novaNota;
      listaDeAlunos[indexAluno].notaBimestre3 = alterarNotaBimestral(
        indexAluno,
        listaDeAlunos[indexAluno].bimestre3.values.toList(),
      );
    } else if (bimestreSelecionado == '4º Bimestre') {
      listaDeAlunos[indexAluno].bimestre4[atividadeSelecionada] = novaNota;
      listaDeAlunos[indexAluno].notaBimestre4 = alterarNotaBimestral(
        indexAluno,
        listaDeAlunos[indexAluno].bimestre4.values.toList(),
      );
    }
    alterarMedia(indexAluno);
    isLoading.value = false;
  }

  double alterarNotaBimestral(int indexAluno, List notas) {
    double soma = 0.0;
    for (double nota in notas) {
      soma += nota;
    }
    return soma;
  }

  alterarMedia(int indexAluno) {
    List<double> notas = [
      listaDeAlunos[indexAluno].notaBimestre1 * 2,
      listaDeAlunos[indexAluno].notaBimestre2 * 3,
      listaDeAlunos[indexAluno].notaBimestre3 * 2,
      listaDeAlunos[indexAluno].notaBimestre4 * 3,
    ];
    double media = 0.0;
    for (double nota in notas) {
      media += nota;
    }
    media = media / 10;
    listaDeAlunos[indexAluno].media = media;
  }

  double getNotaDoAluno(int index) {
    if (bimestreSelecionado == '1º Bimestre') {
      return listaDeAlunos[index].bimestre1[atividadeSelecionada] ?? 0.0;
    } else if (bimestreSelecionado == '2º Bimestre') {
      return listaDeAlunos[index].bimestre2[atividadeSelecionada] ?? 0.0;
    } else if (bimestreSelecionado == '3º Bimestre') {
      return listaDeAlunos[index].bimestre3[atividadeSelecionada] ?? 0.0;
    } else if (bimestreSelecionado == '4º Bimestre') {
      return listaDeAlunos[index].bimestre4[atividadeSelecionada] ?? 0.0;
    } else {
      return 0.0;
    }
  }

  getNotaBimestral(int index) {
    if (bimestreSelecionado == '1º Bimestre') {
      return listaDeAlunos[index].notaBimestre1;
    } else if (bimestreSelecionado == '2º Bimestre') {
      return listaDeAlunos[index].notaBimestre2;
    } else if (bimestreSelecionado == '3º Bimestre') {
      return listaDeAlunos[index].notaBimestre3;
    } else if (bimestreSelecionado == '4º Bimestre') {
      return listaDeAlunos[index].notaBimestre4;
    } else {
      return 0.0;
    }
  }

  Future<void> salvar(TurmaModel turma) async {
    List<TurmaModel> turmas = await domain.getTurmas();
    turmas[turmas.indexWhere(
          (turmaIndex) =>
              turma.nome == turmaIndex.nome &&
              turma.ano == turmaIndex.ano &&
              turma.disciplina == turmaIndex.disciplina &&
              turma.escola == turmaIndex.escola,
        )]
        .alunos = listaDeAlunos;

    await domain.setTurmas(turmas);
  }
}
