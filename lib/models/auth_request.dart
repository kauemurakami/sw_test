class AuthRequest {
  String? grantType;
  String? clientId;
  String? username;
  String? password;

  AuthRequest({
    this.grantType,
    this.clientId,
    this.username,
    this.password,
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
}
