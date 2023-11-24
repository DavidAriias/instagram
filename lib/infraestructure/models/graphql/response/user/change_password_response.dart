import 'package:instagram/infraestructure/models/models.dart';

class UpdatePasswordResponse {
    final GenericResponse updatePassword;

    UpdatePasswordResponse({
        required this.updatePassword,
    });

    factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) => UpdatePasswordResponse(
        updatePassword: GenericResponse.fromJson(json["updatePassword"]),
    );
}
