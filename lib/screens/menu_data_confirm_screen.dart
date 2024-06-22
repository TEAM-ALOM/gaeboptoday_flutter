import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gaeboptoday_flutter/controllers/json_decoder.dart';
import 'package:gaeboptoday_flutter/controllers/json_decoder.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';
import 'package:gaeboptoday_flutter/screens/cards/added_menu_card.dart';
import 'package:gaeboptoday_flutter/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class MenuDataConfirmScreen extends StatefulWidget {
  const MenuDataConfirmScreen({super.key, required this.menuJsonData});
  final Map<String, dynamic> menuJsonData;
  @override
  State<MenuDataConfirmScreen> createState() => _MenuDataConfirmScreenState();
}

class _MenuDataConfirmScreenState extends State<MenuDataConfirmScreen> {
  int dateIndex = 0;
  final SwiperController _swiperController = SwiperController();
  final RoundedLoadingButtonController _roundedLoadingButtonController =
      RoundedLoadingButtonController();
  late MenuModel receivedMenuData;
  @override
  void initState() {
    receivedMenuData = menuJsonToStringList(
      jsonData: widget.menuJsonData,
      isReaderRequest: true,
    );
    print(receivedMenuData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "메뉴 등록 완료",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: RoundedLoadingButton(
          color: Colors.blueAccent,
          controller: _roundedLoadingButtonController,
          onPressed: () {
            _roundedLoadingButtonController.success();
            Navigator.pop(context);
          },
          child: const Text(
            "홈으로 돌아가기",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Gap(70),
            const Column(
              children: [
                AutoSizeText(
                  "성공적으로 메뉴를 읽었습니다!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                  minFontSize: 20,
                ),
                AutoSizeText(
                  "메뉴를 제보해주셔서 감사합니다 :)",
                  minFontSize: 15,
                ),
              ],
            ),
            const Gap(40),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(248, 248, 248, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: AnimatedToggleSwitch<int>.size(
                        current: dateIndex,
                        values: const [0, 1, 2, 3, 4],
                        iconOpacity: 0.3,
                        indicatorSize: const Size.fromWidth(100),
                        customIconBuilder: (context, local, global) {
                          final text =
                              const ['월', '화', '수', '목', '금'][local.index];
                          return Center(
                              child: Text(
                            text,
                            style: TextStyle(
                              fontSize: dateIndex != local.index ? 12 : 12,
                              color: Color.lerp(Colors.black, Colors.white,
                                  local.animationValue),
                              fontWeight: dateIndex != local.index
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ));
                        },
                        borderWidth: 4.0,
                        iconAnimationType: AnimationType.onHover,
                        style: ToggleStyle(
                          backgroundColor: Colors.white,
                          borderColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [],
                        ),
                        styleBuilder: (i) =>
                            ToggleStyle(indicatorColor: colorBuilder(i)),
                        onChanged: (i) => setState(() {
                          dateIndex = i;
                          _swiperController.move(dateIndex);
                        }),
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 400,
                      child: Swiper(
                        loop: false,
                        itemBuilder: (BuildContext context, int index) {
                          // return Text(index.toString());
                          return addedMenuCard(receivedMenuData);
                        },
                        onIndexChanged: (v) => setState(() {
                          dateIndex = v;
                        }),
                        index: dateIndex,
                        itemCount: 5,
                        viewportFraction: 1,
                        scale: 0.8,
                        controller: _swiperController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
