import 'package:gestao_de_notas/src/data/repositories/disciplinas_repository.dart';
import 'package:gestao_de_notas/src/data/repositories/escolas_repository.dart';
import 'package:gestao_de_notas/src/data/repositories/turmas_repository.dart';
import 'package:gestao_de_notas/src/data/services/off_service.dart';
import 'package:gestao_de_notas/src/data/services/prefs_service.dart';
import 'package:gestao_de_notas/src/models/turma_model.dart';

class Domain {
  final serviceOff = OffService();
  final turmaRepository = TurmasRepositoryImpl(service: PrefsService());
  final escolaRepository = EscolasRepositoryImpl(service: PrefsService());
  final disciplinaRepository = DisciplinasRepositoryImpl(
    service: PrefsService(),
  );

  Future<List<TurmaModel>> getTurmas() async {
    return await turmaRepository.getTurmas();
  }

  Future<void> setTurmas(List<TurmaModel> listaLocal) async {
    turmaRepository.setTurmas(listaLocal);
  }

  Future<List<String>> getEscolas() async {
    return await escolaRepository.getEscolas();
  }

  setEscolas(List<String> listaLocal) {
    escolaRepository.setEscolas(listaLocal);
  }

  Future<List<String>> getDisciplinas() async {
    return await disciplinaRepository.getDisciplinas();
  }

  setDisciplinas(List<String> listaLocal) {
    disciplinaRepository.setDisciplinas(listaLocal);
  }
}
