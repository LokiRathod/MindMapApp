import 'package:get_storage/get_storage.dart';

class StorageService {
  var storage = GetStorage();

  // Generic method to save string values
  void saveString(String key, String value) {
    storage.write(key, value);
  }

  // Generic method to read string values
  String? readString(String key) {
    return storage.read(key);
  }


  // Generic method to save boolean values
  void saveBool(String key, bool value) {
    storage.write(key, value);
  }
  // Generic method to read boolean values
  bool? readBool(String key) {
    return storage.read(key);
  }


  // Generic method to save integer values
  void saveInt(String key, int value) {
    storage.write(key, value);
  }

  // Generic method to read integer values
  int? readInt(String key) {
    return storage.read(key);
  }



}
