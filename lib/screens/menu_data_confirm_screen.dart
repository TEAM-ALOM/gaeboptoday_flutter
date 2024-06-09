import 'package:flutter/material.dart';

class MenuDataConfirmScreen extends StatefulWidget {
  const MenuDataConfirmScreen({super.key, required this.menuJsonData});
  final Map<String, dynamic> menuJsonData;
  @override
  State<MenuDataConfirmScreen> createState() => _MenuDataConfirmScreenState();
}

class _MenuDataConfirmScreenState extends State<MenuDataConfirmScreen> {
  @override
  void initState() {
    print(widget.menuJsonData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
