import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  String? type;
  String? title;
  String? description;
  String? date;
  int? value;

  TransactionModel({
    this.type,
    this.title,
    this.description,
    this.date,
    this.value,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => 
    _$TransactionModelFromJson(json);
    
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}