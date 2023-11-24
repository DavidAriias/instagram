class GenericResponse {
    final dynamic value;
    final String statusCode;
    final String message;

    GenericResponse({
        required this.value,
        required this.statusCode,
        required this.message,
    });

    factory GenericResponse.fromJson(Map<String, dynamic> json) => GenericResponse(
        value: json["value"],
        statusCode: json["statusCode"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "statusCode": statusCode,
        "message": message,
    };
}