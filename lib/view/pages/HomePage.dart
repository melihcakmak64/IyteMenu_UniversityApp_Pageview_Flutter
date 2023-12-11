import 'package:flutter/material.dart';
import 'package:menu_app/controller/NetworkController.dart';
import 'package:menu_app/view/widgets/menuBody.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  List<String> normalMenu = <String>[];
  List<String> vejeteryanMenu = <String>[];
  List<String> veganMenu = <String>[];
  String selectedDate = NetworkController.datetimeToString(DateTime.now());
  @override
  void initState() {
    _loadMenus();
    super.initState();
  }

//-----------DateTimePicker----------------
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 30)),
            initialEntryMode: DatePickerEntryMode.calendarOnly)
        .then((value) {
      if (value != null) {
        selectedDate = NetworkController.datetimeToString(value);
        _loadMenus();
      }
    });
  }

//--------------Network requests----------------

  Future<void> _loadMenus() async {
    normalMenu = await NetworkController.readMenu("O", tarih: selectedDate);
    vejeteryanMenu = await NetworkController.readMenu("V", tarih: selectedDate);
    veganMenu = await NetworkController.readMenu("VEG", tarih: selectedDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      MenuBody(
        menu: normalMenu,
        menuType: "Günün Menüsü",
      ),
      MenuBody(
        menu: vejeteryanMenu,
        menuType: "Vejeteryan Menü",
      ),
      MenuBody(
        menu: veganMenu,
        menuType: "Vegan Menü",
      ),
    ];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.png"),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 13,
            ),
            //-----------HEADER---------------------//
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Header
                IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.keyboard_double_arrow_left),
                  color: Colors.white,
                  iconSize: 50,
                ),
                for (int i = 0; i < _pages.length; i++)
                  CircleAvatar(
                    radius: 8,
                    backgroundColor:
                        _activePage == i ? Colors.black : Colors.white,
                  ),
                IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.keyboard_double_arrow_right),
                  color: Colors.white,
                  iconSize: 50,
                ),
              ],
            ),

            //----------DATEPICKER-----------------------//
            OutlinedButton(
              onPressed: () {
                _showDatePicker();
              },
              child: Text(
                selectedDate,
                style: TextStyle(color: Colors.white),
              ),
            ),

            //--------------MENU------------------------//
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _activePage = page;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages[index % _pages.length];
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
