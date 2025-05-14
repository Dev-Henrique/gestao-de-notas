import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/home/crud_diciplina/crud_disciplinas_view_model.dart';

class CrudDisciplinaPage extends StatefulWidget {
  const CrudDisciplinaPage({super.key});

  @override
  State<CrudDisciplinaPage> createState() => _CrudDisciplinaPageState();
}

class _CrudDisciplinaPageState extends State<CrudDisciplinaPage> {
  final _viewModel = CrudDisciplinasViewModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _viewModel.getDisciplinas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop('');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('Disciplinas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome da Disciplina',

                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) {
                  if (newValue != null && newValue.isNotEmpty) {
                    _viewModel.cadastrarDisciplina(newValue);
                    _formKey.currentState!.reset();
                  }
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _viewModel.listaDeDisciplinas,
              builder: (context, disciplinas, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: disciplinas.length,
                    itemBuilder:
                        (context, index) => ListTile(
                          title: Text(disciplinas[index]),
                          trailing: IconButton(
                            onPressed: () {
                              _viewModel.removeDisciplina(index);
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
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        child: Text('Cadastrar Disciplina'),
      ),
    );
  }
}
