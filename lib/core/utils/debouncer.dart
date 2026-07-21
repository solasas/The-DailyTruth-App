import 'dart:async';

/// Delays invoking a callback until [milliseconds] have passed without a new
/// call — used to debounce search fields (model search, leaderboard search).
class Debouncer {
  Debouncer({this.milliseconds = 300});

  final int milliseconds;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}
