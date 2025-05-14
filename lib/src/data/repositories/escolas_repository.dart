import 'dart:convert';

import 'package:gestao_de_notas/src/data/services/prefs_service.dart';

abstract class EscolasRepository {
  Future<List<String>> getEscolas();
  Future<void> setEscolas(List<String> disciplinas);
}

class EscolasRepositoryImpl implements EscolasRepository {
  PrefsService service;
  EscolasRepositoryImpl({required this.service});

  @override
  Future<List<String>> getEscolas() async {
    try {
      String json = await service.get('escolas');
      if (json.isEmpty) {
        return [];
      }
      List list = jsonDecode(json);
      return list.map((e) => e.toString()).toList();
    } catch (e) {
      throw Exception('Erro ao obter escolas: $e');
    }
  }

  @override
  Future<void> setEscolas(List<String> escolas) async {
    try {
      String json = jsonEncode(escolas);
      await service.set('escolas', json);
    } catch (e) {
      throw Exception('Erro ao guardar escolas: $e');
    }
  }
}
