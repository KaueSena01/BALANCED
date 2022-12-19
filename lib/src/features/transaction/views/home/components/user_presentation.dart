import 'package:atlas_coins/src/features/user/controller/auth_controller.dart';
import 'package:atlas_coins/src/theme/app_theme.dart';
import 'package:atlas_coins/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPresentation extends StatelessWidget {
  const UserPresentation({
    Key? key,
    required this.authController,
  }) : super(key: key);

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(size15, size30, size00, size00),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: size15),
                  height: size45,
                  width: size45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.5,
                      color: primaryColor,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://avatars.githubusercontent.com/u/86299739?v=4",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Olá,",
                      style: AppTheme.lightText.headlineSmall!.apply(
                        color: whiteColor,
                      ),
                    ),
                    Text(
                      authController.auth.name!,
                      style: AppTheme.lightText.labelSmall!.apply(
                        color: labelColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(size25),
            child: Padding(
              padding: const EdgeInsets.all(size05),
              child: SvgPicture.asset(
                "assets/icons/menu_more_vertical.svg",
                height: size25,
                width: size25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
