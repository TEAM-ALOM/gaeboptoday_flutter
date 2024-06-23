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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          title: const Text("asd"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _idInputController,
                decoration: const InputDecoration(
                  hintText: "ID",
                ),
                textInputAction: TextInputAction.next,
                enableSuggestions: false,
                keyboardType: TextInputType.number,
              ),
              const Gap(10),
              TextField(
                controller: _passwordInputController,
                decoration: const InputDecoration(
                  hintText: "PASSWORD",
                ),
                obscureText: true,
                textInputAction: TextInputAction.join,
                onSubmitted: (value) {
                  _roundedLoadingButtonController.reset();
                },
              ),
              const Gap(20),
              RoundedLoadingButton(
                  color: Colors.blueAccent,
                  controller: _roundedLoadingButtonController,
                  onPressed: () {},
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
