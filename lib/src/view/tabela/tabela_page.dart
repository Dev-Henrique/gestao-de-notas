import 'package:flutter/material.dart';
import 'package:gestao_de_notas/src/view/tabela/widgets/gn_tile_tabela.dart';

class TabelaPage extends StatefulWidget {
  const TabelaPage({super.key});

  @override
  State<TabelaPage> createState() => _TabelaPageState();
}

class _TabelaPageState extends State<TabelaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nome da turma')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                Text('Atividade 1'),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
            GnTileTabela(media: 'Média', nota: 'Nota', nome: 'Nome do aluno'),
            Expanded(
              child: ListView.builder(
                itemBuilder:
                    (context, index) => GnTileTabela(
                      media: '0.0',
                      nota: '0.0',
                      nome: 'Maria Clara Desincourt dos Santos Costa',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
