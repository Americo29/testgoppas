import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgoppas/src/bloc/blocs.dart';
import 'package:testgoppas/src/pages/pages.dart';

import 'src/repositories/services_repository.dart';
import 'src/repositories/user_repository.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  final servicesRepository = ServicesRepository();
  final userRepository = UserRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(AppStartedEvent()),
      ),
      BlocProvider(
        create: (context) =>
            ServicesBloc(servicesRepository: servicesRepository),
      ),
    ],
    child: MyApp(
        servicesRepository: servicesRepository, userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final ServicesRepository servicesRepository;
  final UserRepository userRepository;

  MyApp({Key key, @required this.servicesRepository, this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            return HomePage();
          }
          if (state is AuthenticationLogin) {
            return LoginPage();
          }
          if (state is AuthenticationRegisterUser) {
            return RegisterPage();
          }
          if (state is ShowStablishmentState) {
            return StablishmentPage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
