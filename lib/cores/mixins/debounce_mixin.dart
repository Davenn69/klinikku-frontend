import 'dart:async';

mixin DebounceMixin {
  Timer? _debounceTimer;

  void debouncing({required Function() fn, int milliseconds = 150}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: milliseconds), fn);
  }

  void cancelDebounce() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
