import 'package:flutter/widgets.dart';
import 'package:gestao_de_notas/src/domain/domain.dart';

class CrudEscolaViewModel {
  final domain = Domain();
  ValueNotifier<List<String>> listaDeEscolas = ValueNotifier([]);

  getEscolas() async {
    List<String> lista = await domain.getEscolas();
    listaDeEscolas.value = lista;
  }

  Future<void> cadastrarEscola(String newValue) async {
    List<String> lista = [];
    lista.addAll(listaDeEscolas.value);
    lista.add(newValue);
    listaDeEscolas.value.clear();
    listaDeEscolas.value = lista;

    await domain.setEscolas(listaDeEscolas.value);
  }

  Future<void> removeEscola(int index) async {
    List<String> lista = [];
    lista.addAll(listaDeEscolas.value);
    listaDeEscolas.value.clear();
    lista.removeAt(index);
    listaDeEscolas.value = lista;

    await domain.setEscolas(listaDeEscolas.value);
  }
}
