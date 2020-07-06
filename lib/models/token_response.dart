class TokenResponse {

  String token;

  TokenResponse.fromJsonMap(Map<String, dynamic> map):
        token = map["key"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = token;
    return data;
  }
}