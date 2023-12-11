import 'package:flutter/material.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key, required this.menu, required this.menuType});
  final List<String> menu;
  final String menuType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          menuType,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        ...menu
            .map((String e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "·" + e,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ))
            .toList()
      ],
    );
  }
}
