import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constanta.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({
    Key? key,
  }) : super(key: key);
  final List nah = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: primaryColor,
      padding: allPadding,
      child: SafeArea(
        top: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(paddingButton)),
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current location',
                      style: tStyle.copyWith(
                          color: grey, fontWeight: FontWeight.w300),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_location.svg',
                          height: 13,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Makassar',
                          style: tStyle.copyWith(
                              color: white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
