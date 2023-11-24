import 'package:instagram/infraestructure/models/models.dart';

class ConfirmSmsResponse {
    final SmsResponse confirmSmsCode;

    ConfirmSmsResponse({
        required this.confirmSmsCode,
    });

    factory ConfirmSmsResponse.fromJson(Map<String, dynamic> json) => ConfirmSmsResponse(
        confirmSmsCode: SmsResponse.fromJson(json["confirmSMSCode"]),
    );

    Map<String, dynamic> toJson() => {
        "confirmSMSCode": confirmSmsCode.toJson(),
    };
}

