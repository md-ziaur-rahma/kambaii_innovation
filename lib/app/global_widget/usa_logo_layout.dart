import 'package:flutter/material.dart';

class CridUsaLogoLayout{
  cridLogo(double size,Alignment alignment){
    return Align(
      alignment: alignment,
      child: Image(
        image: const AssetImage("images/crid_usa.png"),
        height: size,
        // width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }
}