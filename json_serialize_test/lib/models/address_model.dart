import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class Address {
  final String street;
  final String city;
  Address({
    required this.street,
    required this.city,
  });

  factory Address.fromJson(json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
  
}
