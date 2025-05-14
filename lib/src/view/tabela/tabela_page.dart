import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/models/turma_model.dart';
import 'package:gestao_de_notas/src/view/tabela/tabela_view_model.dart';
import 'package:gestao_de_notas/src/view/tabela/widgets/gn_tile_tabela.dart';

class TabelaPage extends StatefulWidget {
  final TurmaModel turma;

  const TabelaPage({super.key, required this.turma});

  @override
  State<TabelaPage> createState() => _TabelaPageState();
}

class _TabelaPageState extends State<TabelaPage> {
  final _viewModel = TabelaViewModel();
  final _formKeyNomeDaAtividade = GlobalKey<FormState>();

  @override
  void initState() {
    _viewModel.getTurma(widget.turma);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  spacing: 8,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),

                    Text(
                      _viewModel.nomeDaTurma,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _viewModel.alterarAtividade('esquerda');
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    _viewModel.listaDeAtividades.isEmpty
                        ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Form(
                                    key: _formKeyNomeDaAtividade,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Nome da Atividade',
                                      ),
                                      onSaved: (newValue) {
                                        if (newValue != null) {
                                          _viewModel.cadastrarAtividade(
                                            newValue,
                                          );
                                        }
                                      },
                                    ),
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
                                        if (_formKeyNomeDaAtividade
                                            .currentState!
                                            .validate()) {
                                          _formKeyNomeDaAtividade.currentState!
                                              .save();
                                          Navigator.of(context).pop('');
                                        }
                                      },
                                      child: Text('Confirmar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Cadastrar atividade'),
                        )
                        : Text(_viewModel.atividadeSelecionada),
                    IconButton(
                      onPressed: () {
                        _viewModel.alterarAtividade('direita');
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Form(
                                key: _formKeyNomeDaAtividade,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Nome da Atividade',
                                  ),
                                  onSaved: (newValue) {
                                    if (newValue != null) {
                                      _viewModel.cadastrarAtividade(newValue);
                                    }
                                  },
                                ),
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
                                    if (_formKeyNomeDaAtividade.currentState!
                                        .validate()) {
                                      _formKeyNomeDaAtividade.currentState!
                                          .save();
                                      Navigator.of(context).pop('');
                                    }
                                  },
                                  child: Text('Confirmar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.add_rounded),
                    ),
                  ],
                ),
                GnTileTabela(
                  media: 'Média',
                  nota: 'Nota',
                  nome: 'Nome do aluno',
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _viewModel.listaDeAlunos.length,
                    itemBuilder: (context, index) {
                      String media =
                          _viewModel.listaDeAlunos[index].media.toString();
                      String nota =
                          (_viewModel.getNotaDoAluno(index)).toString();
                      String nome = _viewModel.listaDeAlunos[index].name;
                      return GnTileTabela(media: media, nota: nota, nome: nome);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
