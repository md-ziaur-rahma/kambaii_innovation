import 'package:flutter/material.dart';
import 'package:innovation/app/core/values/strings.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';

import '../../global_widget/floating_back.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().simpleAppBar("About Us"),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: CridUsaLogoLayout().cridLogo(200,Alignment.center),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text("About Us : ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(AppStrings.aboutUs),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.startFloat,
      floatingActionButton: const FloatingBack(),
    );
  }
}
