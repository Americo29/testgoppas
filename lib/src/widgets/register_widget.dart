import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgoppas/src/bloc/blocs.dart';

class RegisterWidget extends StatefulWidget {
  final String phone;

  RegisterWidget({this.phone});

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterWidget> {
  static const String emailRegExpString =
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
  static final RegExp emailRegExp =
      new RegExp(emailRegExpString, caseSensitive: false);

  bool _obscurePassword = true;

  final _formKey = new GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _typeIDController = TextEditingController();
  final _iDController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    _onRegisterButtonPressed() {
      if (!_formKey.currentState.validate()) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Información inválida.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(RegisterAuthenticationEvent());
      }
    }

    final registerButton = RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 15.0),
        child: Text(
          'Registrar',
          style: TextStyle(fontSize: 17.0),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10.0,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(RegisterAuthenticationEvent(
          nombres: _nameController.text,
          apellidos: _lastNameController.text,
          telefonoMovil: _phoneController.text,
          tipoDocumento: _typeIDController.text,
          numeroIdentificacion: _iDController.text,
          correo: _emailController.text,
          password: _passwordController.text,
        ));
      },
    );

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: new Column(
                        children: <Widget>[
                          SizedBox(height: heightScreen * 0.10),
                          setRegisterForm(),
                          // SizedBox(height: heightScreen * 0.10),
                          new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: registerButton,
                          ),
                          SizedBox(height: heightScreen * 0.06),
                        ],
                      ),
                    ),
                  ),
                  _getToolbar(context),
                ],
              ),
            ),
          );
        },
      ),
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

  Widget setRegisterForm() {
    final nameTextField = TextFormField(
      controller: _nameController,
      autocorrect: true,
      autovalidate: true,
      decoration: new InputDecoration(
        labelText: 'Nombres',
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.person),
        ),
      ),
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _nameController.text = s,
    );

    final lastNameTextField = TextFormField(
      controller: _lastNameController,
      autocorrect: true,
      autovalidate: true,
      decoration: new InputDecoration(
        labelText: 'Apellidos',
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.person_outline),
        ),
      ),
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _lastNameController.text = s,
    );

    final typeIDTextField = TextFormField(
      controller: _typeIDController,
      autocorrect: true,
      autovalidate: true,
      decoration: new InputDecoration(
        labelText: 'Tipo de identificación',
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.indeterminate_check_box),
        ),
      ),
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _typeIDController.text = s,
    );

    final idTextField = TextFormField(
      controller: _iDController,
      autocorrect: true,
      autovalidate: true,
      decoration: new InputDecoration(
        labelText: 'Número de identificación',
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.assignment_ind),
        ),
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _iDController.text = s,
    );

    final phoneTextField = TextFormField(
      controller: _phoneController,
      autocorrect: true,
      autovalidate: true,
      decoration: new InputDecoration(
        labelText: 'Teléfono',
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.phone),
        ),
      ),
      keyboardType: TextInputType.phone,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _phoneController.text = s,
    );

    final emailTextField = new TextFormField(
      controller: _emailController,
      autocorrect: true,
      autovalidate: true,
      decoration: new InputDecoration(
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.email),
        ),
        labelText: 'Correo',
      ),
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _emailController.text = s,
      validator: (s) => emailRegExp.hasMatch(s)
          ? null
          : 'Ingrese un correo electrónico válido',
    );

    final passwordTextField = new TextFormField(
      controller: _passwordController,
      autocorrect: true,
      autovalidate: true,
      obscureText: _obscurePassword,
      decoration: new InputDecoration(
        suffixIcon: new IconButton(
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          icon: new Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility),
          iconSize: 18.0,
        ),
        labelText: 'Contraseña',
        prefixIcon: new Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: new Icon(Icons.lock),
        ),
      ),
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: new TextStyle(fontSize: 16.0),
      onSaved: (s) => _passwordController.text = s,
      validator: (s) => s.length < 6 ? "Longitud mínima de 6" : null,
    );

    return Container(
      child: Column(
        children: <Widget>[
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: nameTextField,
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: lastNameTextField,
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: typeIDTextField,
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: idTextField,
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: phoneTextField,
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: emailTextField,
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: passwordTextField,
          ),
        ],
      ),
    );
  }
}
