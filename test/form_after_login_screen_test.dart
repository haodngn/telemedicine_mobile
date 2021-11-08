import 'package:flutter_test/flutter_test.dart';
import 'package:telemedicine_mobile/Screens/form_after_login_screen.dart';

class AvatarFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng chọn ảnh đại diện" : "";
  }
}

class LastNameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng nhập họ của bạn" : "";
  }
}

class FirstNameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng nhập tên của bạn" : "";
  }
}

class DOBFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng chọn ngày sinh của bạn" : "";
  }
}

class PhoneFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng nhập số điện thoại" : "";
  }
}

class CityFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng chọn thành phố bạn ở" : "";
  }
}

class DistrictFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng chọn quận, huyện" : "";
  }
}

class WardFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng chọn phường, xã" : "";
  }
}

class StreetFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Vui lòng nhập địa chỉ của bạn" : "";
  }
}

void main() {
  test('empty avatar field', () {
    var result = AvatarFieldValidator.validate("");
    expect(result, "Vui lòng chọn ảnh đại diện");
  });

  test('non-empty avatar field', () {
    var result = AvatarFieldValidator.validate("test");
    expect(result, "");
  });
  test('empty last name field', () {
    var result = LastNameFieldValidator.validate("");
    expect(result, "Vui lòng nhập họ của bạn");
  });

  test('non-empty last name field', () {
    var result = LastNameFieldValidator.validate("test");
    expect(result, "");
  });
  test('empty first name field', () {
    var result = FirstNameFieldValidator.validate("");
    expect(result, "Vui lòng nhập tên của bạn");
  });
  test('non-empty first name field', () {
    var result = FirstNameFieldValidator.validate("test");
    expect(result, "");
  });
  test('empty dob field', () {
    var result = DOBFieldValidator.validate("");
    expect(result, "Vui lòng chọn ngày sinh của bạn");
  });
  test('non-empty dob field', () {
    var result = DOBFieldValidator.validate("test");
    expect(result, "");
  });
  test('empty phone field', () {
    var result = PhoneFieldValidator.validate("");
    expect(result, "Vui lòng nhập số điện thoại");
  });

  test('non-empty phone field', () {
    var result = PhoneFieldValidator.validate("test");
    expect(result, "");
  });

  test('empty city field', () {
    var result = CityFieldValidator.validate("");
    expect(result, "Vui lòng chọn thành phố bạn ở");
  });

  test('non-empty city field', () {
    var result = CityFieldValidator.validate("test");
    expect(result, "");
  });

  test('empty district field', () {
    var result = DistrictFieldValidator.validate("");
    expect(result, "Vui lòng chọn quận, huyện");
  });

  test('non-empty district field', () {
    var result = DistrictFieldValidator.validate("test");
    expect(result, "");
  });

  test('empty ward field', () {
    var result = WardFieldValidator.validate("");
    expect(result, "Vui lòng chọn phường, xã");
  });

  test('non-empty ward field', () {
    var result = WardFieldValidator.validate("test");
    expect(result, "");
  });

  test('empty street field', () {
    var result = StreetFieldValidator.validate("");
    expect(result, "Vui lòng nhập địa chỉ của bạn");
  });

  test('non-empty street field', () {
    var result = StreetFieldValidator.validate("test");
    expect(result, "");
  });
}