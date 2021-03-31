class Repository {
  Map<String, dynamic> _requestCache;

  Repository() {
    _requestCache = {};
  }

  dynamic checkCache(String key) {
    return _requestCache[key];
  }

  void updateCache(String key, dynamic val) {
    _requestCache[key] = val;
  }
}