import 'package:flutter/material.dart';
import 'package:mobile_fl/components/AuthWrapper.dart';
import 'package:mobile_fl/screens/Search.dart';
import 'package:mobile_fl/constants.dart';
import 'package:mobile_fl/screens/Feed.dart';

class UserAccessBottomNavContainer extends StatefulWidget {
  @override
  _UserAccessBottomNavContainerState createState() =>
      _UserAccessBottomNavContainerState();
}

class ViewInfo {
  IconData icon;
  String label;
  Widget view;

  ViewInfo(this.icon, this.label, this.view);
}

class _UserAccessBottomNavContainerState
    extends State<UserAccessBottomNavContainer> {
  _UserAccessBottomNavContainerState() {
    print("On page: UserAccessBottomNavContainerState");
  }

  int _selectedPage = 0;
  // define the views
  List<ViewInfo> views = <ViewInfo>[
    new ViewInfo(Icons.article, 'Feed', FeedScreen()),
    new ViewInfo(Icons.search, 'Search', SearchScreen())
  ];

  void _changeViewOnTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return AuthWrapper(
        authLevel: AuthLevels.STUDENT,
        ctx: ctx,
        body: Scaffold(
            body: Center(
              child: views.elementAt(_selectedPage).view,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: (() {
                List<BottomNavigationBarItem> tabs = [];
                for (int i = 0; i < views.length; ++i) {
                  tabs.add(BottomNavigationBarItem(
                      icon: Icon(views[i].icon), label: views[i].label));
                }
                return tabs;
              })(),
              currentIndex: _selectedPage,
              onTap: _changeViewOnTap,
              selectedItemColor: Constants.pink(),
            )));
  }
}
