// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GnTileTabela extends StatelessWidget {
  final String media;
  final String nota;
  final String nome;
  final String notaDaAtividade;
  final void Function()? onTap;
  const GnTileTabela({
    super.key,
    required this.media,
    required this.nota,
    required this.nome,
    required this.notaDaAtividade,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.green,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(color: Colors.blue),
      shape: RoundedRectangleBorder(side: BorderSide(width: 0.5)),
      leading: SizedBox(
        width: 50,
        child: Text(media, textAlign: TextAlign.center),
      ),
      title: Text(nome),
      subtitle: Text(notaDaAtividade),
      trailing: SizedBox(
        width: 75,
        child: Text(nota, textAlign: TextAlign.center),
      ),
      onTap: onTap,
    );
  }
}
