import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKeyNotaDoAluno = GlobalKey<FormState>();

  @override
  void initState() {
    _viewModel.getTurma(widget.turma);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.turma.nome),
        actions: [
          ElevatedButton(
            onPressed: () {
              _viewModel.salvar(widget.turma);
            },
            child: Text('Salvar'),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _viewModel.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        _viewModel.alterarBimestre('esquerda');
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(
                      width: 200,
                      height: 25,
                      child: Center(
                        child: Text(_viewModel.bimestreSelecionado),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        _viewModel.alterarBimestre('direita');
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                Divider(),
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
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                    FilledButton(
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
                                FilledButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                FilledButton(
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
                Divider(),
                GnTileTabela(
                  media: 'Média Anual',
                  nota: 'Nota Bimestral',
                  nome: 'Nome do aluno',
                  notaDaAtividade: 'Nota na atividade',
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _viewModel.listaDeAlunos.length,
                    itemBuilder: (context, index) {
                      String media =
                          _viewModel.listaDeAlunos[index].media.toString();
                      String nota =
                          (_viewModel.getNotaBimestral(index)).toString();

                      String nome = _viewModel.listaDeAlunos[index].name;
                      String notaNaAtividade =
                          (_viewModel.getNotaDoAluno(index)).toString();

                      return GnTileTabela(
                        media: media,
                        nota: nota,
                        nome: nome,
                        notaDaAtividade: notaNaAtividade,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Form(
                                  key: _formKeyNotaDoAluno,
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*'),
                                      ),
                                    ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),

                                    decoration: InputDecoration(
                                      hintText: '0.0',
                                    ),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Não pode ser vazio';
                                      } else {
                                        if (value.isEmpty) {
                                          return 'Não pode ser vazio';
                                        }
                                        if ((double.tryParse(value) ?? 0) >
                                            10) {
                                          return 'Não pode ser maior que 10.0';
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      if (newValue != null) {
                                        _viewModel.alterarNota(
                                          double.tryParse(newValue) ?? 0.0,
                                          index,
                                        );
                                      }
                                    },
                                  ),
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
                                      if (_formKeyNotaDoAluno.currentState!
                                          .validate()) {
                                        _formKeyNotaDoAluno.currentState!
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
                      );
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
