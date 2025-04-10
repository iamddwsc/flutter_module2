import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {
  int counter = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 2 Features'),
        backgroundColor: Colors.orange,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.countertops), text: 'Counter'),
            Tab(icon: Icon(Icons.info), text: 'About'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Counter Tab
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: incrementCounter,
                  child: const Text('Increment'),
                ),
              ],
            ),
          ),

          // About Tab
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Module 2',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('This is a modular Flutter component that demonstrates:'),
                SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Independent development'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Modular architecture'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Component reusability'),
                ),
              ],
            ),
          ),

          // Settings Tab
          ListView(
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                value: true,
                onChanged: (value) {},
              ),
              ListTile(
                title: const Text('Language'),
                trailing: const Text('English'),
                onTap: () {},
              ),
              const Divider(),
              const ListTile(
                title: Text('Module Version'),
                trailing: Text('1.0.0'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: incrementCounter,
              tooltip: 'Increment',
              backgroundColor: Colors.orange,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
