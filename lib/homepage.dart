import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Aplikasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
 
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTabIndex = 0;
  String email = "azima@gmail.com";

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Profil Pengguna"),
          content: Text("Email: $email"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _showProfileDialog,
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text('Menu', style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
          _buildDrawerItem(Icons.home, "Home", () {}),
          _buildDrawerItem(Icons.settings, "Settings", () {}),
          _buildDrawerItem(Icons.logout, "Logout", () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(),
          const SizedBox(height: 16),
          _buildInfoCards(),
          const SizedBox(height: 16),
          _buildSectionTitle("Tingkat Kesegaran"),
          _buildChart(), // Menambahkan Grafik
          const SizedBox(height: 16),
          _buildSectionTitle("Pengguna Terbaru"),
          _buildUserList(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TabWidget(label: "Tab 1", isSelected: _selectedTabIndex == 0, onTap: () => _onTabSelected(0)),
        _TabWidget(label: "Tab 2", isSelected: _selectedTabIndex == 1, onTap: () => _onTabSelected(1)),
        _TabWidget(label: "Tab 3", isSelected: _selectedTabIndex == 2, onTap: () => _onTabSelected(2)),
      ],
    );
  }

  Widget _buildInfoCards() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _InfoCard(color: Colors.red, title: "Merah", value: "x"),
        _InfoCard(color: Colors.green, title: "Hijau", value: "y"),
        _InfoCard(color: Colors.blue, title: "Biru", value: "z"),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildUserList() {
    return const Column(
      children: [
        ListTile(leading: CircleAvatar(), title: Text("Elynn Lee"), subtitle: Text("email@fakedomain.net")),
        ListTile(leading: CircleAvatar(), title: Text("Oscar Dum"), subtitle: Text("email@fakedomain.net")),
      ],
    );
  }

  Widget _buildChart() {
  return SizedBox(
    height: 250,
    child: LineChart(
      LineChartData(
        titlesData: const FlTitlesData(
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              'Near',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            sideTitles: SideTitles(showTitles: true),
          ),
          leftTitles: AxisTitles(
            axisNameWidget: Text(
              'Tingkat Kesegaran',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            sideTitles: SideTitles(showTitles: true),
          ),
          topTitles: AxisTitles(
            sideTitles: const SideTitles(showTitles: false), 
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), 
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1),
              FlSpot(2, 2),
              FlSpot(4, 3),
              FlSpot(6, 2),
              FlSpot(8, 4),
              FlSpot(10,5),
              FlSpot(11, 4),
            ],
            isCurved: true,
            gradient: const LinearGradient(colors: [Colors.green, Colors.greenAccent]),
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(colors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.1)]),
            ),
          ),
        ],
      ),
    ),
  );
}



  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedTabIndex,
      onTap: _onTabSelected,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: "Swap"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
      ],
    );
  }
}

class _TabWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabWidget({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.black : Colors.grey.shade300,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Color color;
  final String title;
  final String value;

  const _InfoCard({required this.color, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: color)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
