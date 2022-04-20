class WalkThroughState {
  final int page;

  WalkThroughState({this.page = 0});

  WalkThroughState copyWith({required int page}) =>
      WalkThroughState(page: page);
}
