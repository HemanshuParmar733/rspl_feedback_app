class CategoryModel {
  List<String>? listOfCategories;

  CategoryModel({
    this.listOfCategories,
  });

  CategoryModel copyWith({
    List<String>? listOfCategories,
  }) =>
      CategoryModel(
        listOfCategories: listOfCategories ?? this.listOfCategories,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        listOfCategories: json["list_of_categories"] == null
            ? []
            : List<String>.from(json["list_of_categories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "list_of_categories": listOfCategories == null
            ? []
            : List<dynamic>.from(listOfCategories!.map((x) => x)),
      };
}
