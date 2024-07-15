import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constanta.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({
    super.key,
  });
  final List nah = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      // color: primaryColor,
      padding: allPadding,
      child: SafeArea(
        top: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  elevation: WidgetStateProperty.all(0),
                  padding: WidgetStateProperty.all(EdgeInsets.zero)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
              },
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
                        colorFilter: const ColorFilter.mode(
                            primaryColor, BlendMode.srcIn),
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
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
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
