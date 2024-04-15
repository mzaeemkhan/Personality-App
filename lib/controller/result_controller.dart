import 'package:get/get.dart';
import 'package:personality_test/models/data_model.dart';
import 'package:personality_test/models/result_model.dart';
import 'package:personality_test/models/test_history_model.dart';
import 'package:personality_test/shared/methods/read_json.dart';

import '../local/my_local_storage.dart';
import '../module/test/component/result_calculating_dialog.dart';
import '../shared/resources/string_assets.dart';

class ResultController extends GetxController {
  bool isClick = false;
  bool isTestStarted = false;
  bool isPreviousVisible = false;
  DataModel newModel = DataModel();
  bool isDataLoading = true, isPersonalitySelected = false;
  double countE = 0,
      countI = 0,
      countS = 0,
      countN = 0,
      countT = 0,
      countF = 0,
      countJ = 0,
      countP = 0;
  double total = 0;
  int personalityIndex = 0, questionTemp = 0, percentage = 0, clicked = 0;
  String result = "", optionSelected = "";
  Map<String, double> resultMap = {};
  Map<String, double> populationMap = {};
  List<ResultModel> resultDataList = List.empty(growable: true);
  List<TestHistoryModel> testHistoryList = List.empty(growable: true);

  @override
  void onInit() {
    getPersonalityIndex();
    readData();
    setHistory();
    super.onInit();
  }

  Future<void> setHistory() async {
    testHistoryList = await MyLocalStorage.getTestHistory();

    if (testHistoryList.isNotEmpty) {
      isTestStarted = true;
      isPreviousVisible = true;
      percentage = testHistoryList[testHistoryList.length - 1].questNo + 1;
      questionTemp = testHistoryList[testHistoryList.length - 1].questNo + 1;

      for (var element in testHistoryList) {
        if (element.selectedOption == "A") {
          if (element.questNo >= 0 && element.questNo <= 4) {
            countE++;
          } else if (element.questNo >= 5 && element.questNo <= 9) {
            countS++;
          } else if (element.questNo >= 10 && element.questNo <= 14) {
            countT++;
          } else if (element.questNo >= 15 && element.questNo <= 19) {
            countJ++;
          }
        } else if (element.selectedOption == "B") {
          if (element.questNo >= 0 && element.questNo <= 4) {
            countI++;
          } else if (element.questNo >= 5 && element.questNo <= 9) {
            countN++;
          } else if (element.questNo >= 10 && element.questNo <= 14) {
            countF++;
          } else if (element.questNo >= 15 && element.questNo <= 19) {
            countP++;
          }
        }
      }
    } else {
      updateOptionSelected("");
      changeClick(false, 0);
    }

    update();
  }

  changeClick(click, val) {
    isClick = click;
    clicked = val;

    update();
  }

  Future readData() async {
    isDataLoading = true;
    readJson().then((value) {
      newModel = value;
      isDataLoading = false;
      update();
    });
  }

  setValues(bool val1, val2) {
    isTestStarted = val1;
    isPreviousVisible = val2;
    update();
  }

  updatePercentage(int val) {
    if (val == 1) {
      percentage++;
    } else {
      if (percentage > 0) {
        percentage--;
      }
    }

    update();
  }

  updateOptionSelected(String val) {
    optionSelected = val;

    update();
  }

  updateQuestion(int val) {
    if (val == 1) {
      questionTemp++;
    } else {
      if (questionTemp > 0) {
        questionTemp--;
      }
    }

    if (questionTemp == 0) {
      // isTestStarted = false;
      isPreviousVisible = false;
    }
    update();
  }

  updateQuesResultForA() {
    if (questionTemp >= 0 && questionTemp <= 4) {
      countE++;
    } else if (questionTemp >= 5 && questionTemp <= 9) {
      countS++;
    } else if (questionTemp >= 10 && questionTemp <= 14) {
      countT++;
    } else if (questionTemp >= 15 && questionTemp <= 19) {
      countJ++;
    }

    update();
  }

  updateQuesResultForB() {
    if (questionTemp >= 0 && questionTemp <= 4) {
      countI++;
    } else if (questionTemp >= 5 && questionTemp <= 9) {
      countN++;
    } else if (questionTemp >= 10 && questionTemp <= 14) {
      countF++;
    } else if (questionTemp >= 15 && questionTemp <= 19) {
      countP++;
    }

    update();
  }

  updateQuestionNumber() {
    if (questionTemp < 19) {
      updateQuestion(1);
    }

    update();
  }

  updateHistory(int questNo, String val, bool isNext) {
    if (isNext) {
      TestHistoryModel testHistoryModel =
          TestHistoryModel(questNo: questNo, selectedOption: val);

      if (testHistoryList.isNotEmpty) {
        bool isExists =
            testHistoryList.any((element) => element.questNo == questNo);
        if (isExists) {
          testHistoryList[questNo] = testHistoryModel;
        } else {
          testHistoryList.insert(questNo, testHistoryModel);
        }
      } else {
        testHistoryList.insert(questNo, testHistoryModel);
      }
    }

    update();
  }

  resultCalculation(context) {
    calculateResult();
    for (var i = 0; i < newModel.combinations!.length; i++) {
      if (newModel.combinations![i].name == result) {
        setID(i);
      }
    }
    savePersonalityIndex();
    calculatingResult(context);
    clearTestHistory();
    MyLocalStorage.setTestHistory([]);

    update();
  }

  setID(int id) {
    personalityIndex = id;
    isPersonalitySelected = true;
    update();
  }

  void calculateResult() {
    if (countE > countI) {
      result = "E";
      resultMap["Extraversion"] = countE;
    } else {
      result = "I";
      resultMap["Introversion"] = countI;
    }

    if (countS > countN) {
      result += "S";
      resultMap["Sensing"] = countS;
    } else {
      result += "N";
      resultMap["Intuition"] = countN;
    }

    if (countT > countF) {
      result += "T";
      resultMap["Thinking"] = countT;
    } else {
      result += "F";
      resultMap["Feeling"] = countF;
    }

    if (countJ > countP) {
      result += "J";
      resultMap["Judging"] = countJ;
    } else {
      result += "P";
      resultMap["Perceiving"] = countP;
    }

    getPopulationMap(personalityIndex);

    if (resultDataList.isNotEmpty) {
      resultDataList.clear();
    }

    resultDataList = resultMap.entries
        .map((entry) => ResultModel(entry.key, entry.value))
        .toList();

    for (var element in resultDataList) {
      total += element.percentage;
    }

    update();
  }

  void getPopulationMap(int index) {
    if (populationMap.isNotEmpty) {
      populationMap.clear();
    }

    if (newModel.combinations != null) {
      populationMap["World Population"] =
          double.parse(newModel.combinations![index].population!);
      populationMap["Male Population"] =
          double.parse(newModel.combinations![index].male!);
      populationMap["Female Population"] =
          double.parse(newModel.combinations![index].female!);
    }

    // update();
  }

  void getPersonalityIndex() async {
    if (MyLocalStorage.getInt(StringAssets.keyPersonalityIndex) != -1) {
      personalityIndex =
          MyLocalStorage.getInt(StringAssets.keyPersonalityIndex);
    }
    isPersonalitySelected =
        MyLocalStorage.getInt(StringAssets.keyPersonalityIndex) != -1;

    // update();
  }

  void savePersonalityIndex() async {
    await MyLocalStorage.setInt(
        StringAssets.keyPersonalityIndex, personalityIndex);
  }

  void clearResultMap() {
    resultMap.clear();
    resultDataList.clear();
    populationMap.clear();
    total = 0;
    countE = 0;
    countI = 0;
    countS = 0;
    countN = 0;
    countT = 0;
    countF = 0;
    countJ = 0;
    countP = 0;
    questionTemp = 0;
    percentage = 0;
    clicked = 0;
    isTestStarted = false;
    optionSelected = "";
    isClick = false;
    isPreviousVisible = false;

    update();
  }

  void clearTestHistory() {
    testHistoryList.clear();
    update();
  }
}
