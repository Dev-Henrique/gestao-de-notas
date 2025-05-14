// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gestao_de_notas/src/models/aluno_model.dart';

class TurmaModel {
  String nome;
  String escola;
  String ano;
  String disciplina;
  List<AlunoModel> alunos;
  TurmaModel({
    required this.nome,
    required this.escola,
    required this.ano,
    required this.disciplina,
    required this.alunos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'escola': escola,
      'ano': ano,
      'disciplina': disciplina,
      'alunos': alunos.map((x) => x.toMap()).toList(),
    };
  }

  factory TurmaModel.fromMap(Map<String, dynamic> map) {
    return TurmaModel(
      nome: map['nome'] as String,
      escola: map['escola'] as String,
      ano: map['ano'] as String,
      disciplina: map['disciplina'] as String,
      alunos: List<AlunoModel>.from(
        (map['alunos'] as List).map<AlunoModel>(
          (x) => AlunoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TurmaModel.fromJson(String source) =>
      TurmaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
