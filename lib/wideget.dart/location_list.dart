import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile(
      {super.key, required this.location, required this.press});
  final String location;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: press,
        horizontalTitleGap: 0,
        leading: SvgPicture.asset(
          "assets/icons/location-pin-solid-svgrepo-com.svg",
          height: 16,
          width: 16,
        ),
        title: Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Divider(
        height: 4,
        thickness: 4,
        color: secondaryColor10LightTheme,
      ),
    ]);
  }
}
