import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SelectionProvider with ChangeNotifier {
  int _value = 0;
  int get value => _value;
  List<String> _selectedlist = [];
  List<String> get selectedlist => _selectedlist;
  int getselected() {
    return _value;
    notifyListeners();
  }
  void selected(String name) {
    _selectedlist.add(name);
    _value++;
    notifyListeners();
  }

  void remove(String name) {
    _selectedlist.remove(name);
    _value--;
    notifyListeners();
  }
}