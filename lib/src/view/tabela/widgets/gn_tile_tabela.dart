// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GnTileTabela extends StatelessWidget {
  final String media;
  final String nota;
  final String nome;
  final void Function()? onTap;
  const GnTileTabela({
    super.key,
    required this.media,
    required this.nota,
    required this.nome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      leading: Text(media),
      title: Text(nome),
      trailing: Text(nota),
      onTap: onTap,
    );
  }
}
