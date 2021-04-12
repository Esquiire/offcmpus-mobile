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
            body: Column(
              children: [
                AppHeader(views.elementAt(_selectedPage).label),
                Expanded(child: views.elementAt(_selectedPage).view, flex: 1)
              ],
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

class AppHeader extends StatefulWidget {
  String header;
  AppHeader(this.header);

  @override
  _AppHeaderState createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Constants.navy(opacity: 0.3), width: 1))),
      child: Row(
        children: [
          DrawerButton(),
          Expanded(
              child: Container(
                  child: Text(widget.header,
                      style: TextStyle(
                        color: Constants.navy(),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0))),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border:
                    Border.all(color: Constants.navy(opacity: 0.3), width: 1)),
            constraints: BoxConstraints.tightFor(width: 40, height: 40),
          )
        ],
      ),
    );
  }
}

class DrawerButton extends StatefulWidget {
  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext ctx) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Constants.navy(opacity: 0.3), width: 1)),
        constraints: BoxConstraints.tightFor(width: 40, height: 40),
      );
}
