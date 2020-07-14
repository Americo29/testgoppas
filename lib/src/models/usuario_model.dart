class Usuario {
  final String tipoDocumento;
  final String numeroIdentificacion;
  final String nombres;
  final String apellidos;
  final String telefonoMovil;
  final String correo;
  final String password;

  Usuario({
    this.tipoDocumento,
    this.numeroIdentificacion,
    this.nombres,
    this.apellidos,
    this.telefonoMovil,
    this.correo,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "tipoDocumento": tipoDocumento,
        "numeroIdentificacion": numeroIdentificacion,
        "nombres": nombres,
        "apellidos": apellidos,
        "telefonoMovil": telefonoMovil,
        "correo": correo,
        "password": password,
      };

  Usuario.fromJson(Map<String, dynamic> json)
      : tipoDocumento = json["tipoDocumento"],
        numeroIdentificacion = json["numeroIdentificacion"],
        nombres = json["nombres"],
        apellidos = json["apellidos"],
        telefonoMovil = json["telefonoMovil"],
        correo = json["correo"],
        password = json["password"];

  @override
  String toString() =>
      '$tipoDocumento $numeroIdentificacion $nombres $apellidos $telefonoMovil $correo $password';
}
