import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgoppas/src/bloc/blocs.dart';
import 'package:testgoppas/src/pages/pages.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLogged = false;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              isLogged = state.isLogged;
            }
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'Menú principal',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: screenHeight * 0.80,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(height: screenHeight * 0.1),
                              RaisedButton(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.06,
                                      vertical: screenWidth * 0.04),
                                  child: Text(
                                    'Iniciar sesión',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                elevation: 2.0,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedInEvent());
                                },
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              RaisedButton(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.1,
                                      vertical: screenWidth * 0.04),
                                  child: Text(
                                    'Registrar',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                elevation: 2.0,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(RegisterUserEvent());
                                },
                              ),
                              SizedBox(height: screenHeight * 0.1),
                              Text(
                                  'Registrece e inicie sesión para ver los establecimientos',
                                  textAlign: TextAlign.center),
                              SizedBox(height: screenHeight * 0.02),
                              RaisedButton(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.01,
                                        vertical: screenWidth * 0.04),
                                    child: Text(
                                      'Establecimientos',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  elevation: 2.0,
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed: isLogged
                                      ? () {
                                          BlocProvider.of<ServicesBloc>(context)
                                              .add(ServicesEventGetServices());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          StablishmentPage()));
                                        }
                                      : null),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
