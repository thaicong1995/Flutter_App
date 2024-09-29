import 'package:flutter/material.dart';

class AvartarWigget extends StatelessWidget {
  final String avatarImg;
  final String email;

  const AvartarWigget({super.key, required this.avatarImg, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(avatarImg),
        ),
        const SizedBox(height: 8,),
        Text(
            email,
            style: TextStyle(

            fontSize: 16
          ),
        ),
      ],
    );
  }
}
