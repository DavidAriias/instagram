import 'package:instagram/infraestructure/models/models.dart';

class AuthLogOut {
    final CloseSession closeSession;

    AuthLogOut({
        required this.closeSession,
    });

    factory AuthLogOut.fromJson(Map<String, dynamic> json) => AuthLogOut(
        closeSession: CloseSession.fromJson(json["closeSession"]),
    );

    Map<String, dynamic> toJson() => {
        "closeSession": closeSession.toJson(),
    };
}

class CloseSession {
    final GenericResponse responseTypeOfString;

    CloseSession({
        required this.responseTypeOfString,
    });

    factory CloseSession.fromJson(Map<String, dynamic> json) => CloseSession(
        responseTypeOfString: GenericResponse.fromJson(json["responseTypeOfString"]),
    );

    Map<String, dynamic> toJson() => {
        "responseTypeOfString": responseTypeOfString.toJson(),
    };
}


