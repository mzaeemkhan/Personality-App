class TestHistoryModel {
  late int questNo;
  late String selectedOption;

  TestHistoryModel({required this.questNo, required this.selectedOption});

  //constructor that convert json to object instance
  factory TestHistoryModel.fromJson(Map<String, dynamic> json) {
    return TestHistoryModel(
      questNo: json["questNo"],
      selectedOption: json["selectedOption"],
    );
  }

  //a method that convert object to json
  Map<String, dynamic> toJson() {
    return {
      "questNo": questNo,
      "selectedOption": selectedOption,
    };
  }
}
