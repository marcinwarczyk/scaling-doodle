import 'package:code_brothers/screens/photos_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/comments_screen.dart';
import '../utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          PhotosScreen(title: 'Photos',),
          CommentsScreen(title: 'Comments',),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: navigationBarColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_library_outlined,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: 'Photos',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment_bank_outlined,
              color: (_page == 1) ? primaryColor : secondaryColor,
            ),
            label: 'Comments',
            backgroundColor: primaryColor,
          ),
        ],
        activeColor: primaryColor,
        inactiveColor: secondaryColor,
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
