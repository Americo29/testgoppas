part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class ShowStablishmentState extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String email;
  AuthenticationAuthenticated({this.email});
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'AuthenticationAuthenticated {}';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  final bool isLogged;
  AuthenticationUnauthenticated({this.isLogged});

  @override
  List<Object> get props => [isLogged];

  @override
  String toString() => 'AuthenticationUnauthenticated {}';
}

class AuthenticationLogin extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;
  AuthenticationFailure({this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'AuthenticationFailure { $error }';
}

class AuthenticationRegisterUser extends AuthenticationState {
  @override
  String toString() => 'AuthenticationRegisterUser {}';
}

class AuthenticationLogoutUser extends AuthenticationState {
  final Usuario user;
  AuthenticationLogoutUser({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'AuthenticationLogoutUser {}';
}
