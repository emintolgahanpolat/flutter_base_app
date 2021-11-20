class ErrorModel {
  String? status;
  String? code;
  String? message;

  ErrorModel({this.status, this.code, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json['status'] as String?,
        code: json['code'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
      };
}
