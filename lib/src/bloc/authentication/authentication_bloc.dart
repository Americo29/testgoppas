import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:testgoppas/src/models/usuario_model.dart';
import 'package:testgoppas/src/providers/db_provider.dart';
import 'package:testgoppas/src/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  // final _prefs = UserPrefs();

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(null);

  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // await _prefs.initPrefs();
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is AppStartedEvent) {
      yield AuthenticationUnauthenticated(isLogged: false);
    }

    if (event is LoggedInEvent) {
      yield AuthenticationLogin();
    }

    if (event is RegisterUserEvent) {
      yield AuthenticationRegisterUser();
    }

    if (event is LoginAuthenticationEvent) {
      try {
        final user = await DBProvider.db.getLogin(event.email, event.password);

        if (user != null) {
          print('${user.nombres} ${user.apellidos} ha iniciado sesión');
          yield AuthenticationUnauthenticated(isLogged: true);
        } else {
          print('Error de login');
          yield AuthenticationUnauthenticated(isLogged: false);
        }
      } catch (e) {
        print('Error en RegisterAuthenticationEvent: ${e.toString()}');
      }
    }

    if (event is RegisterAuthenticationEvent) {
      Map<String, dynamic> user = {
        "nombres": event.nombres,
        "apellidos": event.apellidos,
        "tipoDocumento": event.tipoDocumento,
        "numeroIdentificacion": event.numeroIdentificacion,
        "telefonoMovil": event.telefonoMovil,
        "correo": event.correo,
        "password": event.password
      };
      try {
        final userdb = Usuario.fromJson(user);
        await DBProvider.db.saveUser(userdb);
        yield AuthenticationUnauthenticated(isLogged: false);
      } catch (e) {
        print('Error en RegisterAuthenticationEvent: ${e.toString()}');
      }
    }

    if (event is ShowEstablishmentEvent) {
      yield ShowStablishmentState();
    }

    if (event is LoggedOutEvent) {
      yield AuthenticationLoading();
      await userRepository.takeToken();
      yield AuthenticationUnauthenticated(isLogged: false);
    }
  }
}
