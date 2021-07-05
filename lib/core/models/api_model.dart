///Response Models from Rest API. Adjust to Backend
class CApiRes<T> {
  String? errorCode;
  late String message;

  /// response data. E.g User Data.
  T? results;

  CApiRes({this.errorCode, required this.message, this.results});

  CApiRes.fromJson(
      Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    errorCode = (json['errorCode']).toString();
    message = json['message'];
    results = fromJsonT(
      json['result'],
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T? value) toJsonT) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    data['results'] = toJsonT(this.results);
    return data;
  }

  CApiResError get resError =>
      CApiResError(errorCode: errorCode!, message: message);
}

///Error Model with Error Code constant.
class CApiResError {
  late String errorCode;
  late String? message;

  CApiResError({required this.errorCode, this.message});

  CApiResError.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }
}
