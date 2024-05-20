import 'package:court_craze/components/widgets/coming_soon.dart';
import 'package:court_craze/components/widgets/custom_app_bar.dart';
import 'package:court_craze/components/widgets/pop_ups/privacy_popup.dart';
import 'package:court_craze/screens/views/authentication/get_started_screen.dart';
import 'package:court_craze/screens/views/channel/channel_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:court_craze/screens/views/games_view/games.dart';
import 'package:court_craze/screens/views/standings_view/standings.dart';
import 'package:court_craze/screens/views/teams_view/players.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedScreen = 0;
  List<Widget> views = [
    const Standings(),
    const ChannelPage(id: 'UCWJ2lWNubArHWmf3FIHbfcQ', title: 'NBA'),
    const Games(),
    const Players(),
  ];

  void onTapChangeView(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  String _appVersion = '1.0.0';
  String _userEmail = '';
  String _greeting = '';

  Future<void> _loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  void _loadUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _userEmail = user?.email ?? 'No email';
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const GetStartedScreen(title: 'Court Craze')),
        (route) => false,
      );
    }
  }

  void _setGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      _greeting = '🌄 Good Morning';
    } else if (hour < 17) {
      _greeting = '🕑 Good Afternoon';
    } else {
      _greeting = '🌆 Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
    _loadUserInfo();
    _setGreetingMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(hamburger: true),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_greeting,\n $_userEmail',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'App Version: $_appVersion',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            _buildDrawerSection('MY ACCOUNT', [
              _buildDrawerItem(Icons.subscriptions, 'Subscriptions', () {
                ComingSoonPopup.show(context);
              }),
              _buildDrawerItem(Icons.star, 'Benefits, Voting, Badges', () {
                // Handle Benefits, Voting, Badges navigation
                ComingSoonPopup.show(context);
              }),
            ]),
            _buildDrawerSection('PREFERENCES', [
              _buildDrawerItem(Icons.accessibility, 'Accessibility', () {
                ComingSoonPopup.show(context);
              }),
              _buildDrawerItem(Icons.notifications, 'Notifications', () {
                // Handle Notifications navigation
                ComingSoonPopup.show(context);
              }),
              _buildDrawerItem(Icons.settings, 'App Settings', () {
                // Handle App Settings navigation
                ComingSoonPopup.show(context);
              }),
            ]),
            _buildDrawerSection('MORE', [
              _buildDrawerItem(Icons.privacy_tip, 'Privacy', () {
                PrivacyPopup.show(context);
              }),
              _buildDrawerItem(Icons.money, 'Fantasy and Gambling', () {
                // Handle Text Size navigation
                ComingSoonPopup.show(context);
              }),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text('App Version: $_appVersion'),
              ),
            ]),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: _signOut,
              trailing: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: views.elementAt(_selectedScreen),
      // backgroundColor: Color(0XFFEDF1FF),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart_outlined),
            label: "Standings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_sharp),
            label: "Videos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball_sharp),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Teams",
          ),
        ],
        currentIndex: _selectedScreen,
        onTap: onTapChangeView,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildDrawerSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...items,
        const Divider(),
      ],
    );
  }

  Widget _buildDrawerItem(
      IconData icon, String title, GestureTapCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
