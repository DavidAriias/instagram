class SmsResponse {
    final SmsType smsType;

    SmsResponse({
        required this.smsType,
    });

    factory SmsResponse.fromJson(Map<String, dynamic> json) => SmsResponse(
        smsType: SmsType.fromJson(json["smsType"]),
    );

    Map<String, dynamic> toJson() => {
        "smsType": smsType.toJson(),
    };
}

class SmsType {
    final bool success;
    final String message;

    SmsType({
        required this.success,
        required this.message,
    });

    factory SmsType.fromJson(Map<String, dynamic> json) => SmsType(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
