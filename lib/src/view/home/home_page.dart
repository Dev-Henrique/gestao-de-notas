import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/home/crud_turma/crud_turma_view_model.dart';
import 'package:gestao_de_notas/src/view/home/crud_turma/editor_de_turma/editor_de_turma_page.dart';
import 'package:gestao_de_notas/src/view/home/home_view_model.dart';
import 'package:gestao_de_notas/src/view/tabela/tabela_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    _viewModel.iniciar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'Gestão de Notas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.school_rounded),
              title: Text('Cadastrar Escola'),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/escolas');
              },
            ),
            ListTile(
              leading: Icon(Icons.book_rounded),
              title: Text('Cadastrar Disciplina'),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/disciplinas');
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add_rounded),
              title: Text('Cadastrar Turma'),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/turmas');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_backup_restore_rounded),
              title: Text('Limpar Dados'),
              subtitle: Text('Limpa todos os dados do app'),
              onTap: () {
                _viewModel.clearAll();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Gestão de Notas'), centerTitle: true),
      body: ValueListenableBuilder(
        valueListenable: _viewModel.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Dropdown para selecionar Ano
                    ValueListenableBuilder(
                      valueListenable: _viewModel.anoSelecionado,
                      builder: (context, anoSelecionado, _) {
                        return DropdownButton(
                          hint: Text('Ano'),
                          value: anoSelecionado.isEmpty ? null : anoSelecionado,
                          items:
                              _viewModel.listaDeAnos.value
                                  .map(
                                    (ano) => DropdownMenuItem(
                                      value: ano,
                                      child: Text(ano),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (ano) {
                            if (ano != null) {
                              _viewModel.setDropdownAno(ano);
                            }
                          },
                        );
                      },
                    ),
                    //Dropdown para selecionar escola
                    ValueListenableBuilder(
                      valueListenable: _viewModel.escolaSelecionada,
                      builder: (context, escolaSelecionada, _) {
                        return DropdownButton(
                          hint: Text('Escola'),
                          value:
                              escolaSelecionada.isEmpty
                                  ? null
                                  : escolaSelecionada,
                          items:
                              _viewModel.listaDeEscolas.value
                                  .map(
                                    (escola) => DropdownMenuItem(
                                      value: escola,
                                      child: Text(
                                        escola.length > 10
                                            ? '${escola.substring(0, 10)}...'
                                            : escola,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (escola) {
                            if (escola != null) {
                              _viewModel.setDropdownEscola(escola);
                            }
                          },
                        );
                      },
                    ),
                    //Dropdown para selecionar Disciplina
                    ValueListenableBuilder(
                      valueListenable: _viewModel.disciplinaSelecionada,
                      builder: (context, diciplinaSelecionada, _) {
                        return DropdownButton(
                          hint: Text('Disciplina'),
                          value:
                              diciplinaSelecionada.isEmpty
                                  ? null
                                  : diciplinaSelecionada,
                          items:
                              _viewModel.listaDeDisciplina.value
                                  .map(
                                    (disciplina) => DropdownMenuItem(
                                      value: disciplina,
                                      child: Text(disciplina),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (disciplina) {
                            if (disciplina != null) {
                              _viewModel.setDropdownDisciplina(disciplina);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _viewModel.listaDeTurmas,
                    builder: (context, listaDeTurmas, _) {
                      if (listaDeTurmas.isEmpty) {
                        return Center(
                          child: TextButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EditorDeTurmaPage(
                                        viewmodel: CrudTurmaViewModel(),
                                      ),
                                ),
                              );
                              if (result != null) {
                                _viewModel.iniciar();
                              }
                            },
                            child: Text('Não há turmas, deseja criar?'),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: listaDeTurmas.length,
                        itemBuilder:
                            (context, index) => ListTile(
                              leading: IconButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => EditorDeTurmaPage(
                                            viewmodel: CrudTurmaViewModel(),
                                            turmaParaEditar:
                                                listaDeTurmas[index],
                                          ),
                                    ),
                                  );
                                  if (result != null) {
                                    _viewModel.iniciar();
                                  }
                                },
                                icon: Icon(Icons.edit_rounded),
                              ),
                              title: Text(listaDeTurmas[index].nome),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TabelaPage(
                                          turma: listaDeTurmas[index],
                                        ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Deseja remover a turma ${listaDeTurmas[index]}?',
                                        ),
                                        actions: [
                                          FilledButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          FilledButton(
                                            onPressed: () {
                                              _viewModel.removerTurma(index);
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
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      EditorDeTurmaPage(viewmodel: CrudTurmaViewModel()),
            ),
          );
          if (result != null) {
            _viewModel.iniciar();
          }
        },
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
