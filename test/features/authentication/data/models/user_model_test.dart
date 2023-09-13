import 'package:feedback_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel test cases', () {
    test('UserModel_fromJson_isReturningUserModel', () async {
      //arrange
      Map<String, dynamic> json = {
        "email": "abc@gmail.com",
        "username": "xyz",
        "uid": "123"
      };
      //act
      final model = UserModel.fromJson(json);

      //assert
      expect(model, isA<UserModel>());
      expect(model.uid, '123');
      expect(model.email, 'abc@gmail.com');
      expect(model.username, 'xyz');
    });
    test('UserModel_toJson_isReturningJsonMap', () async {
      //arrange
      final UserModel userModel =
          UserModel(uid: '123', email: 'abc@gmail.com', username: 'abc');
      //act
      final response = userModel.toJson();

      //assert
      expect(response, isA<Map>());
      expect(response['uid'], '123');
      expect(response['email'], 'abc@gmail.com');
      expect(response['username'], 'abc');
    });
    test('UserModel_copyWith_isReturningUserModel', () async {
      //arrange
      final UserModel userModel =
          UserModel(uid: '123', email: 'abc@gmail.com', username: 'abc');
      //act
      final model = userModel.copyWith(email: 'a1@gmail.com');

      //assert
      expect(model, isA<UserModel>());
      expect(model.uid, '123');
      expect(model.email, 'a1@gmail.com');
      expect(model.username, 'abc');
    });
  });
}
