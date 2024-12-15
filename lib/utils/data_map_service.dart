import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';

class DataMapService {


  // Email ID Validation
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return StringConstants.VALID_EMAIL_EMPTY;
    } else if (value.isEmpty) {
      return StringConstants.VALID_EMAIL_EMPTY;
    } else if (!GetUtils.isEmail(value)) {
      return StringConstants.VALID_EMAIL;
    }
    return null;
  }

  // User name Validation
  String? validateUserName(String value) {
    if (value.isEmpty) {
      return StringConstants.VALID_USER_NAME_EMPTY;
    } else if (value.isEmpty) {
      return StringConstants.VALID_USER_NAME_EMPTY;
    } else if (value.length < 3) {
      return StringConstants.VALID_USER_NAME;
    }
    return null;
  }

  // Password Validation
  String? validatePassword(String value) {
    if (value == '') {
      return StringConstants.VALID_PASSWORD_EMPTY;
    } else if (value.isEmpty) {
      return StringConstants.VALID_PASSWORD_EMPTY;
    }
    return null;
  }


  bool isValidPassword(String password) {
    const String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{4,}$';
    final RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }



  String getFormattedDateString(String? timestamp) {
    // Check if timestamp is null or empty and use current time if it is
    int validTimestamp;
    if (timestamp == null || timestamp.isEmpty) {
      validTimestamp = DateTime.now().millisecondsSinceEpoch;
    } else {
      validTimestamp = int.tryParse(timestamp) ?? DateTime.now().millisecondsSinceEpoch;
    }

    // Convert timestamp to DateTime
    var date = DateTime.fromMillisecondsSinceEpoch(validTimestamp);

    // Create a formatter for the desired date format
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    // Format the date
    var formattedDate = formatter.format(date);

    return formattedDate;
  }



}

