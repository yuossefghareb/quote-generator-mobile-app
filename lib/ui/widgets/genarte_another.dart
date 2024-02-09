import 'package:flutter/material.dart';
import 'package:inter2grow_qoute_app/ui/pages/home_page.dart';

class Generate_another_qoute extends StatelessWidget {
  const Generate_another_qoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }), (route) => false);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff5D13E7),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Generate Another Quote',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
