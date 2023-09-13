import 'package:feedback_app/features/feedback/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryModel test', () {
    test('CategoryModel_fromJson_isReturningCategoryModel', () async {
      //arrange
      Map<String, dynamic> json = {
        "list_of_categories": ["category1", "category2"],
      };
      //act
      final model = CategoryModel.fromJson(json);

      //assert

      expect(model.listOfCategories, isA<List<String>>());
      assert(model.listOfCategories!.contains("category1"));
      assert(model.listOfCategories!.contains("category2"));
    });
    test('CategoryModel_toJson_isReturningJsonMap', () async {
      //arrange
      final CategoryModel categoryModel =
          CategoryModel(listOfCategories: ["category1", "category2"]);
      //act
      final response = categoryModel.toJson();

      //assert
      assert(response["list_of_categories"].contains("category1"));
      assert(response["list_of_categories"].contains("category2"));
    });

    test('CategoryModel_copyWith_isReturningCategoryModel', () async {
      //arrange
      final CategoryModel categoryModel =
          CategoryModel(listOfCategories: ["category1", "category2"]);
      //act
      final model = categoryModel.copyWith(listOfCategories: ['category3']);

      //assert

      expect(model.listOfCategories, isA<List<String>>());
      assert(model.listOfCategories!.contains("category3"));
    });
  });
}
