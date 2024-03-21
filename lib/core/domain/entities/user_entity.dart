part of 'entities.dart';

class UserEntity {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressEntity? address;
  final String? phone;
  final String? website;
  final CompanyEntity? company;

  UserEntity(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone,
        this.website,
        this.company});

}

class AddressEntity {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoEntity? geo;

  AddressEntity({this.street, this.suite, this.city, this.zipcode, this.geo});

}

class GeoEntity {
  final String? lat;
  final String? lng;

  GeoEntity({this.lat, this.lng});

}

class CompanyEntity {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  CompanyEntity({this.name, this.catchPhrase, this.bs});

}
