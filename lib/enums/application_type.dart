enum ContentTypes {
  json('application/json'),
  urlencoded('application/x-www-form-urlencoded');

  const ContentTypes(this.type);
  final String type;
}
