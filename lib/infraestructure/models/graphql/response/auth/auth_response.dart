import '../../../models.dart';

class CheckStatusResponse {
    final AuthGraphQl checkTokenStatus;

    CheckStatusResponse({
        required this.checkTokenStatus,
    });

    factory CheckStatusResponse.fromJson(Map<String, dynamic> json) => CheckStatusResponse(
        checkTokenStatus: AuthGraphQl.fromJson(json["checkTokenStatus"]),
    );

    Map<String, dynamic> toJson() => {
        "checkTokenStatus": checkTokenStatus.toJson(),
    };
}

