// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gestao_de_notas/src/data/services/prefs_service.dart';

abstract class DisciplinasRepository {
  Future<List<String>> getDisciplinas();
  Future<void> setDisciplinas(List<String> disciplinas);
}

class DisciplinasRepositoryImpl implements DisciplinasRepository {
  PrefsService service;
  DisciplinasRepositoryImpl({required this.service});

  @override
  Future<List<String>> getDisciplinas() async {
    try {
      String json = await service.get('disciplinas');
      if (json.isEmpty) {
        return [];
      }
      List list = jsonDecode(json);
      return list.map((e) => e.toString()).toList();
    } catch (e) {
      throw Exception('Erro ao obter disciplinas: $e');
    }
  }

  @override
  Future<void> setDisciplinas(List<String> disciplinas) async {
    try {
      String json = jsonEncode(disciplinas);
      await service.set('disciplinas', json);
    } catch (e) {
      throw Exception('Erro ao guardar disciplinas: $e');
    }
  }
}
