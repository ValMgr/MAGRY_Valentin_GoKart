import 'package:equatable/equatable.dart';

/// {@template user}
/// Profil model
///
/// [Profil.empty] represents an unauthenticated user.
/// {@endtemplate}
class Profil extends Equatable {
  /// {@macro user}
  const Profil({
    required this.id,
    this.email,
    this.name,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Empty user which represents an unauthenticated user.
  static const empty = Profil(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Profil.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Profil.empty;

  @override
  List<Object?> get props => [email, id, name];
}
