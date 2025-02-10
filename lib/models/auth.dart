class Auth {
  String? accessToken, tokenType, refreshToken, scope;
  int? expiresIn;

  Auth({
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.refreshToken,
    this.scope,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"],
        scope: json["scope"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "scope": scope,
      };
}
