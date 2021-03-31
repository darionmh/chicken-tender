import 'package:flutter/cupertino.dart';

class EventEmitter {
  List<VoidCallback> _subscribers;

  EventEmitter() {
    _subscribers = [];
  }

  emit() {
    _subscribers.forEach((subscriber) => subscriber());
  }

  VoidCallback subscribe(VoidCallback callback) {
    _subscribers.add(callback);
    return () => _unsubscribe(callback);
  }

  _unsubscribe(VoidCallback callback) {
    _subscribers.remove(callback);
  }
}
