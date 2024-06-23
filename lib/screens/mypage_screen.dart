import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final RoundedLoadingButtonController _roundedLoadingButtonController =
      RoundedLoadingButtonController();
  final TextEditingController _idInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: const Text(
          "로그인",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Text("학사정보시스템 계정으로 로그인해주세요"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: _idInputController,
                  decoration: const InputDecoration(
                    hintText: "ID",
                  ),
                  textInputAction: TextInputAction.next,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: _passwordInputController,
                  decoration: const InputDecoration(
                    hintText: "PASSWORD",
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.join,
                  onSubmitted: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _roundedLoadingButtonController.reset();
                  },
                ),
              ),
              const Gap(80),
              RoundedLoadingButton(
                  color: Colors.blueAccent,
                  controller: _roundedLoadingButtonController,
                  onPressed: () {
                    //TODO : LOGIN
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
