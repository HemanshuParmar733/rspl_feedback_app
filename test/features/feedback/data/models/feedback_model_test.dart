import 'package:feedback_app/features/feedback/data/models/feedback_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeedbackModel test', () {
    test('FeedbackModel_fromJson_isReturningFeedbackModel', () async {
      //arrange
      Map<String, dynamic> json = {
        "category": "category",
        "id": "id",
        "time": DateTime.now().toUtc().toString(),
        "description": "description",
        "reporter_name": "reporterName",
        "title": "title",
        "user_name": "userName",
        "likes": ["id1"],
        "dislikes": ["id2"],
      };
      //act
      final model = FeedbackModel.fromJson(json);

      //assert
      expect(model, isA<FeedbackModel>());
      expect(model.id, 'id');
      expect(model.title, 'title');
      expect(model.userName, 'userName');
      expect(model.description, 'description');
      expect(model.reporterName, 'reporterName');
      expect(model.likes, isA<List<String>>());
      expect(model.dislikes, isA<List<String>>());
      assert(model.likes!.contains("id1"));
      assert(model.dislikes!.contains("id2"));
    });
    test('FeedbackModel_toJson_isReturningJsonMap', () async {
      //arrange
      final FeedbackModel feedbackModel = FeedbackModel(
          title: 'abc',
          id: 'id',
          userName: 'userName',
          reporterName: 'reporter',
          likes: ["id1"],
          time: DateTime.now().toUtc().toString(),
          category: 'category',
          description: 'desc',
          dislikes: ["id2"]);
      //act
      final response = feedbackModel.toJson();

      //assert
      expect(response, isA<Map>());
      expect(response['id'], 'id');
      expect(response['title'], 'abc');
      expect(response['user_name'], 'userName');
      expect(response['reporter_name'], 'reporter');
      expect(response['category'], 'category');
      expect(response['description'], 'desc');
      expect(response['likes'], isA<List<String>>());
      expect(response['dislikes'], isA<List<String>>());
      assert(response["likes"].contains("id1"));
      assert(response["dislikes"].contains("id2"));
    });
    test('FeedbackModel_copyWith_isReturningFeedbackModel', () async {
      //arrange
      final FeedbackModel feedbackModel = FeedbackModel(
          title: 'abc',
          id: 'id',
          userName: 'userName',
          reporterName: 'reporter',
          likes: ["id1"],
          time: DateTime.now().toUtc().toString(),
          category: 'category',
          description: 'desc',
          dislikes: ["id2"]);
      //act
      final model = feedbackModel.copyWith();

      //assert
      expect(model, isA<FeedbackModel>());
      expect(model.id, 'id');
      expect(model.title, 'abc');
      expect(model.userName, 'userName');
      expect(model.description, 'desc');
      expect(model.category, 'category');
      expect(model.reporterName, 'reporter');
      expect(model.likes, isA<List<String>>());
      expect(model.dislikes, isA<List<String>>());
      assert(model.likes!.contains("id1"));
      assert(model.dislikes!.contains("id2"));
    });
  });
}
