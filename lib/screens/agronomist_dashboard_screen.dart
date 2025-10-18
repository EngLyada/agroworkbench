import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/agronomist_model.dart';
import '../models/farmer_model.dart';
import '../utils/app_constants.dart';

class AgronomistDashboardScreen extends StatefulWidget {
  final Agronomist agronomist;
  final List<Farmer> assignedFarmers;
  
  const AgronomistDashboardScreen({super.key, required this.agronomist, required this.assignedFarmers});

  @override
  State<AgronomistDashboardScreen> createState() => _AgronomistDashboardScreenState();
}

class _AgronomistDashboardScreenState extends State<AgronomistDashboardScreen> 
    with TickerProviderStateMixin {
  final bool _showMapView = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agronomist Panel'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards (Top Row)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryCard('Farmers', widget.assignedFarmers.length.toString()),
                _buildSummaryCard('Groups', widget.agronomist.totalGroups.toString()),
                _buildSummaryCard('Acres', widget.agronomist.totalAcres.toStringAsFixed(1)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Quick Actions (Same 4-card layout)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildQuickActionCard('Map View', Icons.map, AppConstants.primaryColor),
                _buildQuickActionCard('Schedule Visit', Icons.event, AppConstants.secondaryColor),
                _buildQuickActionCard('Reports', Icons.bar_chart, AppConstants.warningColor),
                _buildQuickActionCard('Messages', Icons.message, AppConstants.dangerColor),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Activity Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Activity Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildActivityCard('Pending Visits', '3'),
                const SizedBox(height: 8),
                _buildActivityCard('Reviews', '12/15'),
                const SizedBox(height: 8),
                _buildActivityCard('Reports', '5 This Week'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Tab Bar for Map/List View
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Map View'),
              Tab(text: 'Farmer List'),
            ],
            labelColor: AppConstants.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppConstants.primaryColor,
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMapView(),
                _buildFarmerListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(0.3476, 32.5825), // Coordinates for Uganda
        initialZoom: 8.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: widget.assignedFarmers.map((farmer) {
            return Marker(
              width: 40,
              height: 40,
              point: LatLng(farmer.location.lat, farmer.location.lng),
              child: Container(
                decoration: BoxDecoration(
                  color: _getPinColor(farmer.id), // Color based on farmer status
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _getPinColor(String farmerId) {
    // Mock logic to determine pin color based on status
    // In real app, this would come from the farmer's status data
    final index = widget.assignedFarmers.indexWhere((f) => f.id == farmerId);
    if (index % 3 == 0) return Colors.green;
    if (index % 3 == 1) return Colors.yellow;
    return Colors.red;
  }

  Widget _buildFarmerListView() {
    return Column(
      children: [
        // Search and filter bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search farmers...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Farmer list with filters
        Expanded(
          child: ListView.builder(
            itemCount: widget.assignedFarmers.length,
            itemBuilder: (context, index) {
              final farmer = widget.assignedFarmers[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getPinColor(farmer.id),
                    child: Text(
                      farmer.name.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(farmer.name),
                  subtitle: Text(
                    'Crop: ${farmer.crops.isNotEmpty ? farmer.crops[0].name : "N/A"} • '
                    'Land: ${farmer.acreage} acres',
                  ),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'visit',
                        child: Text('Schedule Visit'),
                      ),
                      const PopupMenuItem(
                        value: 'message',
                        child: Text('Send Message'),
                      ),
                      const PopupMenuItem(
                        value: 'profile',
                        child: Text('View Profile'),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to farmer details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(String title, String value) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}