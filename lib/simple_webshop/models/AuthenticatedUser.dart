class AuthenticatedUser {
  final String id;
  final String email;
  final String token;
  final String name;

  AuthenticatedUser(
      {this.id = "", this.email = "", this.token = "", this.name = ""});
  factory AuthenticatedUser.fromJSON(Map<String, dynamic> parsedJSON) {
    return AuthenticatedUser(
        email: parsedJSON['email'],
        id: parsedJSON['id'],
        token: parsedJSON['token'],
        name: parsedJSON['name']);
  }
}
