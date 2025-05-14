import 'package:gestao_de_notas/src/models/turma_model.dart';

class OffService {
  static List<TurmaModel> turmas = [
    TurmaModel(
      nome: 'M1MR01',
      escola: 'Núbia Bentes Picanço',
      ano: '2025',
      disciplina: 'Inglês',
      alunos: [],
    ),
    TurmaModel(
      nome: 'M1TR01',
      escola: 'Núbia Bentes Picanço',
      ano: '2025',
      disciplina: 'Português',
      alunos: [],
    ),

    TurmaModel(
      nome: 'M1MR02',
      escola: 'Raimunda da Costa Bentes',
      ano: '2024',
      disciplina: 'Português',
      alunos: [],
    ),
    TurmaModel(
      nome: 'M1TR02',
      escola: 'Raimunda da Costa Bentes',
      ano: '2024',
      disciplina: 'Inglês',
      alunos: [],
    ),
  ];

  static List<String> escolas = [
    'Núbia Bentes Picanço',
    'Raimunda da Costa Bentes',
  ];

  static List<String> disciplinas = ['Português', 'Inglês', 'Artes'];

  Future<List> get(String key) async {
    Map<String, dynamic> map = {
      'turmas': turmas,
      'escolas': escolas,
      'disciplinas': disciplinas,
    };
    await Future.delayed(const Duration(milliseconds: 1));
    return map[key];
  }

  Future<void> set(String key, dynamic value) async {
    Map<String, dynamic> map = {
      'turmas': turmas,
      'escolas': escolas,
      'disciplinas': disciplinas,
    };
    await Future.delayed(const Duration(milliseconds: 1));
    map[key] = value;
  }
}
