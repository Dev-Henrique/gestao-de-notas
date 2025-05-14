import 'dart:convert';

import 'package:gestao_de_notas/src/data/services/prefs_service.dart';

import 'package:gestao_de_notas/src/models/turma_model.dart';

abstract class TurmasRepository {
  // Define the methods that will be implemented by the repository
  Future<List<TurmaModel>> getTurmas();
  Future<void> setTurmas(List<TurmaModel> turmas);
}

class TurmasRepositoryImpl implements TurmasRepository {
  PrefsService service;
  TurmasRepositoryImpl({required this.service});
  @override
  Future<void> setTurmas(List<TurmaModel> turmas) async {
    try {
      String json = jsonEncode(turmas.map((turma) => turma.toMap()).toList());
      await service.set('turmas', json);
    } catch (e) {
      throw Exception('Erro ao guardar turmas: $e');
    }
  }

  @override
  Future<List<TurmaModel>> getTurmas() async {
    try {
      String json = await service.get('turmas');

      if (json.isEmpty) {
        return [];
      }
      List list = jsonDecode(json);
      List<TurmaModel> turmas =
          list.map((turma) => TurmaModel.fromMap(turma)).toList();
      return turmas;
    } catch (e) {
      throw Exception('Erro ao obter turmas: $e');
    }
  }
}
