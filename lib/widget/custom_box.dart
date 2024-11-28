import 'package:flutter/material.dart';
import 'package:nov19_demo1/model/custom_box_model.dart';

class CustomBox extends StatelessWidget {

  CustomBoxModel customBoxModel;
    CustomBox({
    required this.customBoxModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(.7),
      child: Container(
        
        width: 30,
        height: 30,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          color: customBoxModel.clr,
        ),
        child: Center(

        ),

      ),
    );
  }
}
