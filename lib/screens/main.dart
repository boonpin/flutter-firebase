import 'package:firebase/components/page/page_not_found.dart';
import 'package:firebase/components/widgets/icon_badge.dart';
import 'package:firebase/screens/main/landing.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  Main({this.observer, this.analytics});

  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<Main>
    with SingleTickerProviderStateMixin, RouteAware {
  PageController pageController;
  int page = 0;

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget barIcon(
        {IconData icon = Icons.home, int page = 0, bool badge = false}) {
      return IconButton(
        icon: badge ? IconBadge(icon: icon, size: 24) : Icon(icon, size: 24),
        color:
            page == page ? Theme.of(context).accentColor : Colors.blueGrey[300],
        onPressed: () => pageController.jumpToPage(page),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          Landing(),
          PageNotFound(),
          PageNotFound(),
          PageNotFound(),
          PageNotFound(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            barIcon(icon: Icons.home, page: 0),
            barIcon(icon: Icons.favorite, page: 1),
            barIcon(icon: Icons.drive_eta, page: 2),
            barIcon(icon: Icons.mail, page: 3),
            barIcon(icon: Icons.person, page: 4),
            SizedBox(width: 7),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();

    if (widget.observer != null) {
      widget.observer.unsubscribe(this);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.observer != null) {
      widget.observer.subscribe(this, ModalRoute.of(context));
    }
  }
}
