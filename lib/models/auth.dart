class Auth {
  String? accessToken, tokenType, refreshToken, scope, grantType, clientId, username, password;
  int? expiresIn;

  Auth({
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.refreshToken,
    this.scope,
    this.grantType,
    this.clientId,
    this.username,
    this.password,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"],
        scope: json["scope"],
        grantType: json["grant_type"],
        clientId: json["client_id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "scope": scope,
        "grant_type": grantType,
        "client_id": clientId,
        "username": username,
        "password": password,
      };
}
