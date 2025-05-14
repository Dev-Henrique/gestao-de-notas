// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlunoModel {
  String name;
  Map<String, double> bimestre1;
  double notaBimestre1;
  Map<String, double> bimestre2;

  double notaBimestre2;
  Map<String, double> bimestre3;

  double notaBimestre3;
  Map<String, double> bimestre4;

  double notaBimestre4;
  double media;
  AlunoModel({
    required this.name,
    required this.bimestre1,
    this.notaBimestre1 = 0.0,
    required this.bimestre2,
    this.notaBimestre2 = 0.0,
    required this.bimestre3,
    this.notaBimestre3 = 0.0,
    required this.bimestre4,
    this.notaBimestre4 = 0.0,
    required this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bimestre1': bimestre1,
      'notaBimestre1': notaBimestre1,
      'bimestre2': bimestre2,
      'notaBimestre2': notaBimestre2,
      'bimestre3': bimestre3,
      'notaBimestre3': notaBimestre3,
      'bimestre4': bimestre4,
      'notaBimestre4': notaBimestre4,
      'media': media,
    };
  }

  factory AlunoModel.fromMap(Map<String, dynamic> map) {
    return AlunoModel(
      name: map['name'] as String,
      bimestre1: Map.from((map['bimestre1'] as Map)),
      notaBimestre1: map['notaBimestre1'] as double,
      bimestre2: Map.from((map['bimestre2'] as Map)),
      notaBimestre2: map['notaBimestre2'] as double,
      bimestre3: Map.from((map['bimestre3'] as Map)),
      notaBimestre3: map['notaBimestre3'] as double,
      bimestre4: Map.from((map['bimestre4'] as Map)),
      notaBimestre4: map['notaBimestre4'] as double,
      media: map['media'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlunoModel.fromJson(String source) =>
      AlunoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
