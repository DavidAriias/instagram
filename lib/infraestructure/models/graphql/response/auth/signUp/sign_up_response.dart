import 'package:instagram/infraestructure/models/models.dart';

class SignUpResponse {
    final SignUpUser signUpUser;

    SignUpResponse({
        required this.signUpUser,
    });

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        signUpUser: SignUpUser.fromJson(json["signUpUser"]),
    );

    Map<String, dynamic> toJson() => {
        "signUpUser": signUpUser.toJson(),
    };
}

class SignUpUser {
    final GenericResponse responseTypeOfString;

    SignUpUser({
        required this.responseTypeOfString,
    });

    factory SignUpUser.fromJson(Map<String, dynamic> json) => SignUpUser(
        responseTypeOfString: GenericResponse.fromJson(json["responseTypeOfString"]),
    );

    Map<String, dynamic> toJson() => {
        "responseTypeOfString": responseTypeOfString.toJson(),
    };
}


