import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgoppas/src/bloc/blocs.dart';
import 'package:testgoppas/src/repositories/user_repository.dart';
import 'package:testgoppas/src/utils/utils.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginWidget> with TickerProviderStateMixin {
  String _connectionStatus = 'Unknown';

  AnimationController _animationController;
  Animation _animation;

  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    _onLoginButtonPressed() {
      if (!_formKey.currentState.validate()) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Verifique el email y/o la contraseña'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else if (_connectionStatus == 'ConnectivityResult.none') {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content:
                Text('Falló al conectar, verifique la conexión a Internet...'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        BlocProvider.of<AuthenticationBloc>(context).add(
            LoginAuthenticationEvent(
                email: _emailController.text,
                password: _passwordController.text));
      }
    }

    final emailTextField = TextFormField(
      controller: _emailController,
      autocorrect: true,
      autovalidate: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: Icon(Icons.email),
        ),
        labelText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      style: TextStyle(fontSize: 16.0),
      onSaved: (s) => _emailController.text = s,
      validator: (s) => utils.validateEmail(s)
          ? null
          : 'Ingrese un correo electrónico válido',
    );

    final passwordTextField = TextFormField(
      controller: _passwordController,
      autocorrect: true,
      autovalidate: true,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          icon:
              Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          iconSize: 18.0,
        ),
        labelText: 'Contraseña',
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: Icon(Icons.lock),
        ),
      ),
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: TextStyle(
        fontSize: 16.0,
      ),
      onSaved: (s) => _passwordController.text = s,
      validator: (s) => s.length < 6 ? "Longitud mínima de 6" : null,
    );

    final loginButton = RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: widthScreen * 0.20, vertical: widthScreen * 0.04),
        child: Text(
          'Acceder',
          style: TextStyle(fontSize: 17.0),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      elevation: 1.0,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: _onLoginButtonPressed,
    );

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: FadeTransition(
            opacity: _animation,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Form(
                        key: _formKey,
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: heightScreen * 0.03,
                            ),
                            SafeArea(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Iniciar sesión',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                ), //GetImagesProvider().getLoginHalcon(),
                                height: widthScreen * 0.50,
                                width: widthScreen * 0.50,
                              ),
                            ),
                            SizedBox(height: heightScreen * 0.05),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: emailTextField,
                            ),
                            SizedBox(height: heightScreen * 0.01),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: passwordTextField,
                            ),
                            SizedBox(height: heightScreen * 0.05),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: loginButton,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _getToolbar(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _getToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AppStartedEvent(),
          );
        },
      ),
    );
  }
}
