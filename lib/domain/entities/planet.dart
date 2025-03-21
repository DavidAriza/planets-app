import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'planet.g.dart';

@HiveType(typeId: 0)
// ignore: must_be_immutable
class Planet extends Equatable {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? mass;

  @HiveField(2)
  final num? orbitalDisctance;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  bool? isInFavorites;

  Planet({this.name, this.mass, this.orbitalDisctance, this.image, this.description, this.isInFavorites = false});

  Planet copyWith({
    String? name,
    String? mass,
    num? orbitalDisctance,
    String? image,
    String? description,
    bool? isInFavorites,
  }) {
    return Planet(
      name: name ?? this.name,
      mass: mass ?? this.mass,
      orbitalDisctance: orbitalDisctance ?? this.orbitalDisctance,
      image: image ?? this.image,
      description: description ?? this.description,
      isInFavorites: isInFavorites ?? this.isInFavorites,
    );
  }

  @override
  List<Object?> get props => [name, mass, orbitalDisctance, image, description, isInFavorites];
}
