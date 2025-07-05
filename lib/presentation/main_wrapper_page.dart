import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/presentation/home/pages/home_page.dart';
import 'package:tekmob_hitnews/presentation/search/pages/search_page.dart';
import 'package:tekmob_hitnews/presentation/news/pages/bookmarked_news_page.dart';
import 'package:tekmob_hitnews/presentation/profile/pages/profile_page.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const BookmarkedNewsPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Tersimpan',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor:
            Theme.of(context).unselectedWidgetColor, // Warna dinamis
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            Theme.of(
              context,
            ).bottomNavigationBarTheme.backgroundColor, // Warna dinamis
        elevation: 8,
      ),
    );
  }
}
