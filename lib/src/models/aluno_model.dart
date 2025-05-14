// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlunoModel {
  String name;
  List<double> notas;
  double media;
  AlunoModel({required this.name, required this.notas, required this.media});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'notas': notas, 'media': media};
  }

  factory AlunoModel.fromMap(Map<String, dynamic> map) {
    return AlunoModel(
      name: map['name'] as String,
      notas: List.from((map['notas'] as List)),
      media: map['media'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlunoModel.fromJson(String source) =>
      AlunoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
