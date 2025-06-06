import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/home/crud_turma/crud_turma_view_model.dart';

class EditorDeTurmaPage extends StatefulWidget {
  final CrudTurmaViewModel viewmodel;

  const EditorDeTurmaPage({super.key, required this.viewmodel});

  @override
  State<EditorDeTurmaPage> createState() => _EditorDeTurmaPageState();
}

class _EditorDeTurmaPageState extends State<EditorDeTurmaPage> {
  late final CrudTurmaViewModel _viewModel;
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyStudent = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewmodel;
    _viewModel.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editor')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          children: [
            Form(
              key: _formKeyName,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        title: ValueListenableBuilder(
                          valueListenable: _viewModel.anoSelecionado,
                          builder: (context, ano, _) {
                            return DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                              hint: Text('Ano'),
                              value: ano.isNotEmpty ? ano : null,
                              items:
                                  _viewModel.listaDeAnos
                                      .map(
                                        (escola) => DropdownMenuItem(
                                          value: escola,
                                          child: Text(escola),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                _viewModel.setDropdownAno(value);
                              },
                            );
                          },
                        ),
                      ),
                      ListTile(
                        title: ValueListenableBuilder(
                          valueListenable: _viewModel.escolaSelecionada,
                          builder: (context, escola, _) {
                            return DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                              hint: Text(
                                _viewModel.listaDeEscolas.isEmpty
                                    ? 'Não há esolas cadastradas'
                                    : 'Selecione Escola',
                              ),
                              value: escola.isNotEmpty ? escola : null,
                              items:
                                  _viewModel.listaDeEscolas
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
                              onChanged: (value) {
                                _viewModel.setDropdownEscola(value);
                              },
                            );
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await Navigator.of(
                              context,
                            ).pushNamed('/escolas');
                            if (result != null) {
                              _viewModel.getAll();
                            }
                          },
                          icon: Icon(Icons.add_rounded),
                        ),
                      ),
                      ListTile(
                        title: ValueListenableBuilder(
                          valueListenable: _viewModel.disciplinaSelecionado,
                          builder: (context, disciplina, _) {
                            return DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                              hint: Text(
                                _viewModel.listaDeDisciplinas.isEmpty
                                    ? 'Não há disciplinas cadastradas'
                                    : 'Selecione Disciplina',
                              ),
                              value: disciplina.isNotEmpty ? disciplina : null,
                              items:
                                  _viewModel.listaDeDisciplinas
                                      .map(
                                        (disciplina) => DropdownMenuItem(
                                          value: disciplina,
                                          child: Text(disciplina),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                _viewModel.setDropdownDisciplina(value);
                              },
                            );
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await Navigator.of(
                              context,
                            ).pushNamed('/disciplinas');
                            if (result != null) {
                              _viewModel.getAll();
                            }
                          },
                          icon: Icon(Icons.add_rounded),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome da Turma',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _viewModel.setNomeTurma(newValue);
                      _viewModel.cadastrarTurma();
                    },
                  ),
                ],
              ),
            ),
            Text('Alunos'),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Form(
                    key: _formKeyStudent,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Nome do Aluno',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (newValue) {
                        if (newValue != null && newValue.isNotEmpty) {
                          _viewModel.cadastrarAluno(newValue);
                        }
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKeyStudent.currentState!.validate()) {
                      _formKeyStudent.currentState!.save();
                      _formKeyStudent.currentState!.reset();
                    }
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _viewModel.listaDeAlunos,
              builder: (context, listaDeAlunos, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: listaDeAlunos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(listaDeAlunos[index].name),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    'Deseja remover o Aluno ${listaDeAlunos[index]}?',
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
                                        _viewModel.removeAluno(index);
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
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (_formKeyName.currentState!.validate()) {
            _formKeyName.currentState!.save();
            Navigator.of(context).pop('');
          }
        },
        child: Text('Salvar Turma'),
      ),
    );
  }
}
