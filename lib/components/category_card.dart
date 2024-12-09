import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {required this.date,
      required this.title,
      required this.icon,
      required this.amount,
      required this.color});


  final IconData icon;
  final Color color;
  final String amount;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 8),
          //padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 27,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text("-\$$amount",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
              Text("$date",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ));
  }
}
