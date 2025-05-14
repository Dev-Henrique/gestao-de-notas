import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/home/crud_turma/crud_turma_view_model.dart';
import 'package:gestao_de_notas/src/view/home/crud_turma/editor_de_turma/editor_de_turma_page.dart';

class CrudTurmaPage extends StatefulWidget {
  const CrudTurmaPage({super.key});

  @override
  State<CrudTurmaPage> createState() => _CrudTurmaPageState();
}

class _CrudTurmaPageState extends State<CrudTurmaPage> {
  final _viewModel = CrudTurmaViewModel();
  @override
  void initState() {
    _viewModel.getTurmas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turmas')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _viewModel.listaDeTurmas,
              builder: (context, turmas, _) {
                if (turmas.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhuma turma cadastrada',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: turmas.length,
                    itemBuilder:
                        (context, index) => ListTile(
                          title: Text(turmas[index].nome),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Deseja remover a turma ${turmas[index]}?',
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _viewModel.removeTurma(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Confirmar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete_rounded),
                          ),
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorDeTurmaPage(viewmodel: _viewModel),
            ),
          );
        },
        child: Text('Cadastrar Turma'),
      ),
    );
  }
}
