import 'package:flutter/material.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/create/presentation/widgets/train_option_button.dart';

class SelectMenuScreen extends StatelessWidget {
  const SelectMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('目指せムキムキ')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 32),
              SelectMenuButton(
                routeName: RouteNames.createMenu,
                text: '筋トレメニュー作成',
              ),
              SelectMenuButton(routeName: RouteNames.settings, text: '作成設定'),
              SelectMenuButton(routeName: RouteNames.home, text: 'home'),
            ],
          ),
        ),
      ),
    );
  }
}
