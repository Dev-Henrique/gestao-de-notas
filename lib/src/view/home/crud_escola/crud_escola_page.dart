import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/home/crud_escola/crud_escola_view_model.dart';

class CrudEscolaPage extends StatefulWidget {
  const CrudEscolaPage({super.key});

  @override
  State<CrudEscolaPage> createState() => _CrudEscolaPageState();
}

class _CrudEscolaPageState extends State<CrudEscolaPage> {
  final _viewModel = CrudEscolaViewModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _viewModel.getEscolas();
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
        title: const Text('Escolas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome da Escola',

                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) {
                  if (newValue != null && newValue.isNotEmpty) {
                    _viewModel.cadastrarEscola(newValue);
                    _formKey.currentState!.reset();
                  }
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _viewModel.listaDeEscolas,
              builder: (context, escolas, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: escolas.length,
                    itemBuilder:
                        (context, index) => ListTile(
                          title: Text(escolas[index]),
                          trailing: IconButton(
                            onPressed: () {
                              _viewModel.removeEscola(index);
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
        child: Text('Cadastrar Escola'),
      ),
    );
  }
}
