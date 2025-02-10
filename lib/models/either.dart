class Either<L, R> {
  final L? left;
  final R? right;

  Either._({this.left, this.right});

  factory Either.left(L left) => Either._(left: left);

  factory Either.right(R right) => Either._(right: right);

  bool get isLeft => left != null;

  bool get isRight => right != null;

  T fold<T>(T Function(L) ifLeft, T Function(R) ifRight) {
    if (isLeft) {
      return ifLeft(left as L);
    } else {
      return ifRight(right as R);
    }
  }
}
