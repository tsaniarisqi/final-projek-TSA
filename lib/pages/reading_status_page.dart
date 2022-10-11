import 'package:final_projek/pages/main_page.dart';
import 'package:flutter/material.dart';

class ReadingStatusPage extends StatefulWidget {
  const ReadingStatusPage({Key? key}) : super(key: key);

  @override
  State<ReadingStatusPage> createState() => _ReadingStatusPageState();
}

class _ReadingStatusPageState extends State<ReadingStatusPage>
    with SingleTickerProviderStateMixin {
  // ScrollController? _scrollController;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            // AppBar
            ListTile(
              title: const Text(
                'Reading Status',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
                textAlign: TextAlign.left,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black45,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => const MainPage()));
                },
              ),
              contentPadding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            ),

            // Tab Bar
            TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.black54,
              labelColor: const Color(0xffC5930B),
              labelPadding: const EdgeInsets.only(right: 10, left: 10),
              tabs: const [
                Tab(
                  child: Text(
                    'Currently Reading',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    'To Read Later',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    'Finished',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    'Give Up',
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),

            // Tab View
            SizedBox(
              height: 100,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('content'),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('content1'),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('content2'),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('content3'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
