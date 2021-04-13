import 'package:flutter/cupertino.dart';
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
  static List<GlobalKey<NavigatorState>> tabNavKeys = [];

  int tabNavKeyIndex;

  ViewInfo(this.icon, this.label, this.view) {
    tabNavKeys.add(GlobalKey<NavigatorState>());
    this.tabNavKeyIndex = tabNavKeys.length - 1;
  }

  GlobalKey<NavigatorState> getGlobalKey() => tabNavKeys[tabNavKeyIndex];
}

class _UserAccessBottomNavContainerState
    extends State<UserAccessBottomNavContainer> {
  CupertinoTabController tabController;
  int _selectedPage = 0;

  // define the views
  List<ViewInfo> views = <ViewInfo>[
    new ViewInfo(Icons.article, 'Feed', FeedScreen()),
    new ViewInfo(Icons.search, 'Search', SearchScreen())
  ];

  _UserAccessBottomNavContainerState() {
    super.initState();
    this.tabController = CupertinoTabController(initialIndex: 0);
  }

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
        body: WillPopScope(
            onWillPop: () async {
              return !await views
                  .elementAt(_selectedPage)
                  .getGlobalKey()
                  .currentState
                  .maybePop();
            },
            child: CupertinoTabScaffold(
                controller: this.tabController,
                tabBuilder: (BuildContext context, int index) {
                  return CupertinoTabView(
                      navigatorKey: views.elementAt(index).getGlobalKey(),
                      builder: (BuildContext context) {
                        return CupertinoPageScaffold(
                            child: Column(
                          children: [
                            AppHeader(views.elementAt(index).label),
                            Expanded(
                                child: views.elementAt(index).view, flex: 1)
                          ],
                        ));
                      });
                },
                tabBar: CupertinoTabBar(
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
                  activeColor: Constants.pink(),
                ))));
  }
}

class AppHeader extends StatefulWidget {
  String header;
  int mode;
  BuildContext parentCtx;

  static const int MODE_BACK = 1;
  static const int MODE_MENU = 2;

  AppHeader(this.header, {this.mode = MODE_MENU, this.parentCtx});

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
          DrawerButton(
            widget.mode,
            parentCtx: widget.parentCtx,
          ),
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
  int mode;
  BuildContext parentCtx;
  DrawerButton(this.mode, {this.parentCtx});

  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  void handleDrawerTap() {
    // check whether to open the drawer or
    // go back
    if (widget.mode == AppHeader.MODE_MENU) {
      print("TODO: Implement Drawer Button Menu Mode");
    } else if (widget.mode == AppHeader.MODE_BACK) {
      // parentCtx must not be null for this mode to work
      if (widget.parentCtx == null) {
        print("DrawerButton Error: parentCtx is null");
      } else {
        Navigator.pop(widget.parentCtx);
      }
    }
  }

  @override
  Widget build(BuildContext ctx) => GestureDetector(
        child: Container(
          child: widget.mode == AppHeader.MODE_MENU
              ? Icon(
                  Icons.menu,
                  color: Constants.navy(),
                )
              : Icon(Icons.chevron_left, color: Constants.navy()),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border:
                  Border.all(color: Constants.navy(opacity: 0.3), width: 1)),
          constraints: BoxConstraints.tightFor(width: 40, height: 40),
        ),
        onTap: handleDrawerTap,
      );
}
