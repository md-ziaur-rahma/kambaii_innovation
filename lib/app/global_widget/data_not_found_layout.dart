import 'package:innovation/app/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataNotFoundLayout extends StatelessWidget {
  const DataNotFoundLayout({Key? key, required this.displayText,required this.isButton, required this.onPresses, required this.buttonText}) : super(key: key);
  final String displayText;
  final bool isButton;
  final String buttonText;
  final Function onPresses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        const Image(
            image: AssetImage('images/crid_logo_p.png'),height: 140,),
        const SizedBox(
          height: 16,
        ),
        const Text("Oops",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
        const SizedBox(
          height: 16,
        ),
        Text(displayText,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 16),),
        const SizedBox(
          height: 24,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              end: Alignment.centerRight,
              begin: Alignment.centerLeft,
              colors: [
                AppColors.mainColor,
                AppColors.mainColor.withOpacity(0.8),
              ]
            )
          ),
          child: OutlinedButton(
            style: ElevatedButton.styleFrom(side: BorderSide.none,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            onPressed: (){
              onPresses();
            },
            child: Text(buttonText,style: const TextStyle(color: Colors.white),),
          ),
        )

      ],
    );
  }
}
