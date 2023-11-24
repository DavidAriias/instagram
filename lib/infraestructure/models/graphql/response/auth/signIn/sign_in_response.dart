import '../../../../models.dart';

class SignInResponse {
    final SignInUser signInUser;

    SignInResponse({
        required this.signInUser,
    });

    factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        signInUser: SignInUser.fromJson(json["signInUser"]),
    );

    Map<String, dynamic> toJson() => {
        "signInUser": signInUser.toJson(),
    };
}

class SignInUser {
    final AuthGraphQl authTypeOut;

    SignInUser({
        required this.authTypeOut,
    });

    factory SignInUser.fromJson(Map<String, dynamic> json) => SignInUser(
        authTypeOut: AuthGraphQl.fromJson(json["authTypeOut"]),
    );

    Map<String, dynamic> toJson() => {
        "authTypeOut": authTypeOut.toJson(),
    };
}
