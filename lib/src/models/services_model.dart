class Services {
  List<Service> items = new List();

  Services();

  Services.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final service = new Service.fromJson(item);
      items.add(service);
    }
  }
}

class Service {
  String idestablecimiento;
  String code;
  String idasociado;
  String nombre;
  String razonsocial;
  String direccion;
  String latitud;
  String longitud;
  String status;
  String tarifaVehiculo;
  String tarifaMoto;
  String fechaCreacion;
  String fechaActualizacion;
  String imageurl;
  String horario;
  String telefono;
  String ciudadestablecimiento;
  String splitReceivers;
  String splitRule;
  String nit;
  String codPark;
  String codTerminal;
  String isla;
  String codigoEDS;
  String idestacion;
  String surtidor;
  String cara;
  String color;

  Service(
      {this.idestablecimiento,
      this.code,
      this.idasociado,
      this.nombre,
      this.razonsocial,
      this.direccion,
      this.latitud,
      this.longitud,
      this.status,
      this.tarifaVehiculo,
      this.tarifaMoto,
      this.fechaCreacion,
      this.fechaActualizacion,
      this.imageurl,
      this.horario,
      this.telefono,
      this.ciudadestablecimiento,
      this.splitReceivers,
      this.splitRule,
      this.nit,
      this.codPark,
      this.codTerminal,
      this.isla,
      this.codigoEDS,
      this.idestacion,
      this.surtidor,
      this.cara,
      this.color});

  Map<String, dynamic> toJson() => {
        "idestablecimiento": idestablecimiento,
        "code": code,
        "idasociado": idasociado,
        "nombre": nombre,
        "razonsocial": razonsocial,
        "direccion": direccion,
        "latitud": latitud,
        "longitud": longitud,
        "status": status,
        "tarifaVehiculo": tarifaVehiculo,
        "tarifaMoto": tarifaMoto,
        "fechaCreacion": fechaCreacion,
        "fechaActualizacion": fechaActualizacion,
        "imageurl": imageurl,
        "horario": horario,
        "telefono": telefono,
        "ciudadestablecimiento": ciudadestablecimiento,
        "splitReceivers": splitReceivers,
        "splitRule": splitRule,
        "nit": nit,
        "codPark": codPark,
        "codTerminal": codTerminal,
        "isla": isla,
        "codigoEDS": codigoEDS,
        "idestacion": idestacion,
        "surtidor": surtidor,
        "cara": cara,
        "color": color,
      };

  Service.fromJson(Map<String, dynamic> json)
      : idestablecimiento = json["idestablecimiento"],
        code = json["code"],
        idasociado = json["idasociado"],
        nombre = json["nombre"],
        razonsocial = json["razonsocial"],
        direccion = json["direccion"],
        latitud = json["latitud"],
        longitud = json["longitud"],
        status = json["status"],
        tarifaVehiculo = json["tarifaVehiculo"],
        tarifaMoto = json["tarifaMoto"],
        fechaCreacion = json["fechaCreacion"],
        fechaActualizacion = json["fechaActualizacion"],
        imageurl = json["imageurl"],
        horario = json["horario"],
        telefono = json["telefono"],
        ciudadestablecimiento = json["ciudadestablecimiento"],
        splitReceivers = json["splitReceivers"],
        splitRule = json["splitRule"],
        nit = json["nit"],
        codPark = json["codPark"],
        codTerminal = json["codTerminal"],
        isla = json["isla"],
        codigoEDS = json["codigoEDS"],
        idestacion = json["idestacion"],
        surtidor = json["surtidor"],
        cara = json["cara"],
        color = json["color"];

  @override
  String toString() =>
      '$idestablecimiento $code $idasociado $nombre $razonsocial $direccion $latitud $longitud $status $tarifaVehiculo $tarifaMoto $fechaCreacion $fechaActualizacion $imageurl $horario $telefono $ciudadestablecimiento $splitReceivers $splitRule $nit $codPark $codTerminal $isla $codigoEDS $idestacion $surtidor $cara $color';
}
