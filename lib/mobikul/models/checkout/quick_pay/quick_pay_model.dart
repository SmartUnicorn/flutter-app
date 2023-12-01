import 'package:json_annotation/json_annotation.dart';
part 'quick_pay_model.g.dart';

@JsonSerializable()
class QuickPayModel {
  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "url")
  String? url;

  @JsonKey(name: "successUrl")
  String? successUrl;

  @JsonKey(name: "cancelUrl")
  String? cancelUrl;

  @JsonKey(name: "failureUrl")
  String? failureUrl;

  QuickPayModel(
      {this.success,
      this.url,
      this.successUrl,
      this.cancelUrl,
      this.failureUrl});

  factory QuickPayModel.fromJson(Map<String, dynamic> json) =>
      _$QuickPayModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickPayModelToJson(this);
}
