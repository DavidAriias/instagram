import 'package:instagram/infraestructure/models/models.dart';

class SendVerificationSmsResponse {
    final SmsResponse sendVerificationSms;

    SendVerificationSmsResponse({
        required this.sendVerificationSms,
    });

    factory SendVerificationSmsResponse.fromJson(Map<String, dynamic> json) => SendVerificationSmsResponse(
        sendVerificationSms: SmsResponse.fromJson(json["sendVerificationSMS"]),
    );

    Map<String, dynamic> toJson() => {
        "sendVerificationSMS": sendVerificationSms.toJson(),
    };
}

