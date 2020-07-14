import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:testgoppas/src/models/services_model.dart';
import 'package:testgoppas/src/repositories/services_repository.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesRepository servicesRepository;

  ServicesBloc({this.servicesRepository}) : super(null);

  ServicesState get initialState => ServicesInitial();

  @override
  Stream<ServicesState> mapEventToState(ServicesEvent event) async* {
    if (event is ServicesEventGetServices) {
      yield ServicesStateLoadInProgress();
      try {
        final resp = await servicesRepository.getServices();
        if (resp.ok) {
          // print(resp.services["data"]);
          // if (resp.services["code"] == 100) {
          final services = Services.fromJsonList(resp.services["data"]);
          yield ServicesStateLoadSuccess(services: services);
          // }
        } else {
          yield ServicesStateLoadFailure();
          print('Error al obtener servicios: ${resp.message}');
        }
      } catch (e) {
        yield ServicesStateLoadFailure();
        print('Error en ServicesEventGetServices: ${e.toString()}');
      }
    }
  }
}
