/**
 * @author Gilmar N. Lima
 * @email gstrtoint@gmail.com or adminti@isofttec.com.br
 * @create date 25-06-2023  14:35:21
 * @modify date 25-06-2023  14:35:21
 * @desc [description]
 */
import 'package:flutter/material.dart';

//Fonte: (Mitch Koko) https://www.youtube.com/watch?v=IwPfP07MkdI
class NeuButton extends StatelessWidget {
  final onTap;
  bool isButtonPressed;
  NeuButton({super.key, this.onTap, required this.isButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          height: 160,
          width: 160,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isButtonPressed
                      ? Colors.grey.shade200
                      : Colors.grey.shade300),
              boxShadow: isButtonPressed
                  ? []
                  : [
                      //darker shadow on bottum right
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(6, 6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-6, -6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ]),
          child: Icon(
            color: isButtonPressed ? Colors.grey : Colors.green[400],
            Icons.settings,
            size: 80,
          ),
        ));
  }
}
