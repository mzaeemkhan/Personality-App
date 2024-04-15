import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personality_test/module/test/screen/test_screen.dart';

import '../../controller/result_controller.dart';
import '../../local/my_local_storage.dart';
import '../../shared/app_font_family/font_family.dart';
import '../../shared/resources/app_color.dart';
import '../../shared/resources/images_assets.dart';
import '../../shared/resources/string_assets.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';
import '../mbti_16personalities/mbti_personalities_screen.dart';
import '../profile/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = "";
  int current = 0;
  late ResultController _resultController;

  @override
  void initState() {
    super.initState();
    try {
      _resultController = Get.find();
    } catch (exception) {
      _resultController = Get.put(ResultController());
    }

    _resultController.getPersonalityIndex();
    Future.delayed(Duration.zero, () {
      checkForName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultController>(
      builder: (_) => Scaffold(
        backgroundColor: AppColor.primaryWhiteColor,
        body: SafeArea(
          child: _resultController.isDataLoading == true
                ? const Center(child: CircularProgressIndicator())
                : _resultController.isPersonalitySelected == false
                    ? homeScreen()
                    : resultScreen(),

        ),
      ),
    );
  }

  Widget homeScreen() {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: Get.width,
            child: assetImage(
              ImageAssets.homeBg,
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top:Get.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          updateNameDialog(context, "Update Name", name,
                              _nameController, formKey, () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              String data = _nameController.text;
                              setGetName(data);
                            }
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: customText(
                                    'HI! ${name.toUpperCase()}',
                                    36,
                                    AppColor.primaryWhiteColor,
                                    FontWeight.bold,AppFontFamily.poppinsBold)),
                            const SizedBox(
                              width: 10,
                            ),
                            customIcon(
                                Icons.edit, 20, AppColor.primaryWhiteColor),
                          ],
                        ),
                      ),
                      customTextCapitalizeFirst(
                          'Let us help you to find your personality type!',
                          24,
                          AppColor.primaryWhiteColor,
                          FontWeight.normal,AppFontFamily.poppinsRegular),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top:Get.height * 0.03),
                  width:Get.width - 60,
                  child: svgImage(ImageAssets.homeGroupSvg),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top:Get.height * 0.1),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child:  alignText(
                              "${'”'}Discover Your PERSONALITY${'“'}",
                              22,
                              AppColor.textBlackColor,
                              FontWeight.normal,
                              TextAlign.center,AppFontFamily.poppinsSemiBold),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child:  alignText(
                              "Take our Personality Test and get an ${'”'}Outlandishly precise${'“'} depiction of what your identity is and why you do things the manners in which you do.",
                              14,
                              AppColor.textBlackColor,
                              FontWeight.normal,
                              TextAlign.center,AppFontFamily.poppinsRegular),

                      ),
                      const SizedBox(height: 60.0),
                      defaultColoredButton("START TEST", 40.0, () {
                        Get.to(() => const TestScreen());
                      }),
                      const SizedBox(height: 5.0),
                      alignText(
                          "It only takes few minutes",
                          12.0,
                          AppColor.grayColor,
                          FontWeight.normal,
                          TextAlign.center,AppFontFamily.poppinsRegular),
                      const SizedBox(height: 40.0),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        child: alignText(
                            "Understanding Others",
                            22,
                            AppColor.textBlackColor,
                            FontWeight.normal,
                            TextAlign.center,AppFontFamily.poppinsSemiBold),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: alignText(
                            "In our free type descriptions, you will realize what truly drives, motivates, and stresses different characters types, assisting you with building more significant connection.",
                            14,
                            AppColor.textBlackColor,
                            FontWeight.normal,
                            TextAlign.center,AppFontFamily.poppinsRegular),
                      ),
                      const SizedBox(height: 20.0),
                      svgIconButton("MBTI'S Types",  () {
                        Get.to(() => const MBTIPersonalities());
                      }),
                      const SizedBox(height: 20.0)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget resultScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageAssets.resultBg),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: customSvgImage(
                    _resultController
                        .newModel
                        .combinations![_resultController.personalityIndex]
                        .svgCharacter!,
                    Get.width * 0.6,
                    Get.width * 0.4,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width:Get.width,
                child: Column(
                  children: [
                    customTextAllInCaps("Your Tst Result is Below", 16,
                        AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsSemiBold),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "${_resultController.newModel.combinations![_resultController.personalityIndex].name} = ",
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: AppColor.textBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                            "${_resultController.newModel.combinations![_resultController.personalityIndex].abr}",
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: AppColor.headingSpaceCadetColor,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
          const Divider(
            thickness: 1,
            indent: 10,
            color: AppColor.lightGreyColor,
            endIndent: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextAllInCaps(
                    'KNOW YOUR PERSONALITY', 17, AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsSemiBold),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: _resultController.newModel
                        .combinations![_resultController.personalityIndex].traits!.map((e){
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColor.cardColors[_resultController.newModel
                                    .combinations![_resultController.personalityIndex].traits!.indexOf(e)],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: customTextAllInCaps(
                                  e,
                                  14,
                                  AppColor.textColors[_resultController.newModel
                                      .combinations![_resultController.personalityIndex].traits!.indexOf(e)],
                                  FontWeight.bold,AppFontFamily.poppinsRegular),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColor.borderColor, width: 2.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    heightSvgImage(
                      _resultController
                          .newModel
                          .combinations![_resultController.personalityIndex]
                          .svgCharacter!,
                      150,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              updateNameDialog(context, "Update Name", name,
                                  _nameController, formKey, () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      String data = _nameController.text;
                                      setGetName(data);
                                    }
                                  });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: customText(
                                        'HI! ${name.toUpperCase()}',
                                        36,
                                        AppColor.textBlackColor,
                                        FontWeight.bold,AppFontFamily.poppinsBold)),
                                Padding(
                                  padding: EdgeInsets.only(left: 5,right: 10),
                                  child: customIcon(
                                      Icons.edit, 20, AppColor.textBlackColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: customTextCapitalizeFirst(
                                _resultController
                                    .newModel
                                    .combinations![
                                        _resultController.personalityIndex]
                                    .overview,
                                16,
                                AppColor.headingSpaceCadetColor,
                                FontWeight.normal,AppFontFamily.poppinsRegular),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1,
                  indent: 20,
                  color: AppColor.lightGreyColor,
                  endIndent: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: customTextAllInCaps('You can be', 17,
                              AppColor.textBlackColor, FontWeight.bold,AppFontFamily.poppinsSemiBold),
                        ),
                         SizedBox(
                           height: Get.height * 0.20,
                           child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _resultController
                                    .newModel
                                    .combinations![_resultController.personalityIndex]
                                    .careers!
                                    .carimage!
                                    .length,
                                itemBuilder: (BuildContext ctx, int i) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.primaryWhiteColor
                                            ),
                                            child: Image.asset(
                                              _resultController.newModel.combinations![_resultController.personalityIndex].careers!.carimage![i],
                                              fit: BoxFit.cover,
                                              cacheHeight: 70,
                                              cacheWidth: 70,
                                            ),
                                          ),
                                          SizedBox(
                                          width: 70,
                                            child: customContinueText(
                                                _resultController
                                                    .newModel
                                                    .combinations![_resultController
                                                        .personalityIndex]
                                                    .careers!
                                                    .carname![i],
                                                12,
                                                AppColor.headingSpaceCadetColor,
                                                FontWeight.bold,
                                                AppFontFamily.poppinsRegular),
                                          )
                                        ],
                                      ),
                                  );
                                }),
                         ),
                      ],
                    ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          defaultColoredButton("START TEST", 40.0, () {
            _resultController.clearResultMap();
            Get.to(() => const TestScreen());
          }),
          const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            child: alignText("It only takes few minutes", 12.0,
                AppColor.grayColor, FontWeight.normal, TextAlign.center,AppFontFamily.poppinsRegular),
          ),
          const SizedBox(height: 20.0),
          svgIconButton("MBTI's Types", () {
            Get.to(() => const MBTIPersonalities());
          }),
          const SizedBox(height: 35.0),
          defaultIconButton("PROFILE", Icons.person, () async {
            Get.to(
                () => ProfilePage(index: _resultController.personalityIndex));
          }),
          const SizedBox(height: 50.0)
        ],
      ),
    );
  }

  checkForName() async {
    if (MyLocalStorage.getString(StringAssets.keyName) != "") {
      setState(() {
        name = MyLocalStorage.getString(StringAssets.keyName);
      });
    } else {
      customNameDialog(context, _nameController, formKey, () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          String data = _nameController.text;
          setGetName(data);
        }
      });
    }
  }

  setGetName(String data) {
    MyLocalStorage.setString(StringAssets.keyName, data);
    setState(() {
      name = MyLocalStorage.getString(StringAssets.keyName);
    });
    _nameController.clear();
    Get.back();
  }
}
