
import 'package:gestion_tareas/core/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressModel? address;
  final String? phone;
  final String? website;
  final CompanyModel? company;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        id: id,
        name: name,
        username: username,
        email: email,
        address: address?.toEntity(),
        phone: phone,
        website: website,
        company: company?.toEntity()
    );
  }
}

@JsonSerializable()
class AddressModel {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoModel? geo;

  AddressModel({this.street, this.suite, this.city, this.zipcode, this.geo});

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}


extension AddressModelExtension on AddressModel {
  AddressEntity toEntity() {
    return AddressEntity(
        street: street,
        suite: suite,
        city: city,
        zipcode: zipcode,
        geo: geo?.toEntity()
    );
  }
}

@JsonSerializable()
class GeoModel {
  final String? lat;
  final String? lng;

  GeoModel({this.lat, this.lng});

  factory GeoModel.fromJson(Map<String, dynamic> json) => _$GeoModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeoModelToJson(this);
}

extension GeoModelExtension on GeoModel {
  GeoEntity toEntity() {
    return GeoEntity(
        lat: lat,
        lng: lng
    );
  }
}

@JsonSerializable()
class CompanyModel {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  CompanyModel({this.name, this.catchPhrase, this.bs});

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}


extension CompanyModelExtension on CompanyModel {
  CompanyEntity toEntity() {
    return CompanyEntity(
      name: name,
      catchPhrase: catchPhrase,
      bs: bs
    );
  }
}
