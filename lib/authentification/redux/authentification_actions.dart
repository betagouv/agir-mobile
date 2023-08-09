class DoAuthentificationAction {
  final String userName;
  DoAuthentificationAction(this.userName);
}

class HandleAuthentificationResultAction {
  final String userName;
  final String userId;
  HandleAuthentificationResultAction(this.userName, this.userId);
}