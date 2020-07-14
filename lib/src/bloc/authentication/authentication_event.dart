part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AuthenticationEvent {}

class ShowEstablishmentEvent extends AuthenticationEvent {}

class LoggedInEvent extends AuthenticationEvent {
  // final String email;
  // final String password;
  const LoggedInEvent();

  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoggedIn {}';
}

class LoginAuthenticationEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginAuthenticationEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
  @override
  String toString() => 'LoginAuthenticationEvent {}';
}

class RegisterAuthenticationEvent extends AuthenticationEvent {
  final String tipoDocumento;
  final String numeroIdentificacion;
  final String nombres;
  final String apellidos;
  final String telefonoMovil;
  final String correo;
  final String password;

  const RegisterAuthenticationEvent(
      {this.tipoDocumento,
      this.numeroIdentificacion,
      this.nombres,
      this.apellidos,
      this.telefonoMovil,
      this.correo,
      this.password});

  @override
  List<Object> get props => [
        tipoDocumento,
        numeroIdentificacion,
        nombres,
        apellidos,
        telefonoMovil,
        correo,
        password
      ];
  @override
  String toString() => 'RegisterAuthenticationEvent {}';
}

class LoggedOutEvent extends AuthenticationEvent {
  final Usuario user;
  LoggedOutEvent({this.user});
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'LoggedOut {}';
}

class RegisterUserEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoggeRegisterUserEventdIn {}';
}
