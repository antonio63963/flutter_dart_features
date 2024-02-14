import 'package:json_annotation/json_annotation.dart';
import 'package:json_serialize_test/models/address_model.dart';

// strictly user_model))) by warnint message
part 'user_model.g.dart';

const apiUser = 'https://jsonplaceholder.typicode.com/users';

@JsonSerializable(explicitToJson: true) // need if nested class (Address)
class User {
  final int id;
  final String name;
  final String email;
  final Address address;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    super.toString();
    return '''
      id: $id,
      name: $name,
      email: $email,
      address: $address
    ''';
  }
}
