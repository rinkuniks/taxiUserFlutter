import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/res/app_url.dart';
import 'package:rovertaxi/model/profileModel/profileModel.dart';

import '../../Utilities/res/Assets.dart';
import '../../Utilities/res/color.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.profileResp, this.tapOnDrawrOption});
  final Function? tapOnDrawrOption;
  final ProfileResponse? profileResp;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  // color: Colors.transparent,
                  ),
              child: Column(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white, width: 4)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: Assets.assetsPlaceholder,
                          image: profileResp?.userData?.userImage ??
                              AppUrl.placeholderImgUrl,
                          // width: 60,
                          // height: 60,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    profileResp?.userData?.name ?? "NA",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white),
                  ),
                  Text(
                    profileResp?.userData?.phone ?? "NA",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.home,
              color: AppColors.white,
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'History',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.history,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'FAQ',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.question_answer,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'Delete Account',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.delete,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'Bottom Tab Bar1 ',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.delete,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              tapOnDrawrOption!(1);
            },
          ),
          ListTile(
            title: const Text(
              'Bottom Tab Bar2',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.delete,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              tapOnDrawrOption!(2);
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
            ),
            leading: const Icon(
              Icons.logout,
              color: AppColors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
