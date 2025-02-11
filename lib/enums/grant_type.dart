enum GrantType {
  password('password'),
  refreshToken('refresh_token');

  const GrantType(this.type);

  final String type;
}
