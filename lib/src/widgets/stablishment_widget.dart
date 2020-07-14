import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgoppas/src/bloc/blocs.dart';
import 'package:testgoppas/src/models/services_model.dart';

class StablishmentWidget extends StatelessWidget {
  const StablishmentWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  title: Text('Establecimientos'),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () =>
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AppStartedEvent()),
                  )),
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Establecimientos',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(height: screenHeight * 0.01),
                      Container(
                        height: screenHeight * 0.80,
                        child: loadServices(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget loadServices(BuildContext context) {
    return BlocListener<ServicesBloc, ServicesState>(
      listener: (context, state) {},
      child: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          return state is ServicesStateLoadSuccess
              ? activeServices(context, state.services)
              : state is ServicesStateLoadInProgress
                  ? loadingServices()
                  : state is ServicesStateLoadFailure
                      ? failureServices()
                      : Scaffold(body: Container());
        },
      ),
    );
  }

  Widget imageUrl(String urlImage) {
    try {
      return CircleAvatar(
        radius: 20.0,
        backgroundImage: urlImage != null
            ? CacheImage(urlImage)
            : AssetImage('assets/images/no-image.png'),
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      return CircleAvatar(
        radius: 20.0,
        backgroundImage: AssetImage('assets/images/no-image.png'),
        backgroundColor: Colors.transparent,
      );
    }
  }

  Widget activeServices(BuildContext context, Services services) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: ListView.builder(
        itemCount: services.items.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            leading: imageUrl(services.items[index].imageurl),
            // leading: Icon(Icons.list),
            title: Text(services.items[index].nombre),
            children: <Widget>[
              ListTile(
                title: services.items[index].direccion != null
                    ? Text('Dirección: ${services.items[index].direccion}')
                    : Text('Dirección: No registra'),
              ),
              ListTile(
                title: services.items[index].horario != null
                    ? Text('Horario: ${services.items[index].horario}')
                    : Text('Horario: No registra'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget loadingServices() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text('Cargando servicios...'),
      ],
    );
  }

  Widget failureServices() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text('No se cargaron los servicios, posible error de red!'),
      ],
    );
  }
}
