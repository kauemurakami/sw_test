class AuthRequest {
  String? grantType, clientId, username, password, refreshToken, token;

  AuthRequest({
    this.grantType,
    this.clientId,
    this.username,
    this.password,
    this.refreshToken,
    this.token,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
        grantType: json["grant_type"],
        clientId: json["client_id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "grant_type": grantType,
        "client_id": clientId,
        "username": username,
        "password": password,
      };
  Map<String, dynamic> toJsonRefresh() => {
        "grant_type": grantType,
        "client_id": clientId,
        "refresh_token": refreshToken,
      };

  Map<String, dynamic> toJsonCancelToken() => {
        "token_type_hint": grantType,
        "client_id": clientId,
        "token": refreshToken,
      };
}
