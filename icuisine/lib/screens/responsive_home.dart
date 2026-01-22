import 'package:flutter/material.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    
    // Determine device type based on screen width
    bool isPhone = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1200;
    bool isDesktop = screenWidth >= 1200;
    
    // Responsive values
    int crossAxisCount = isPhone ? 2 : (isTablet ? 3 : 4);
    double cardPadding = isPhone ? 8.0 : 16.0;
    double fontSize = isPhone ? 14.0 : (isTablet ? 16.0 : 18.0);
    double headerFontSize = isPhone ? 24.0 : (isTablet ? 32.0 : 40.0);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section - Responsive AppBar
            _buildHeader(context, screenWidth, headerFontSize, isPhone),
            
            // Main Content Area - Expanded to fill available space
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Statistics Cards - Responsive Grid
                      _buildStatisticsSection(
                        context,
                        screenWidth,
                        crossAxisCount,
                        fontSize,
                        isPhone,
                      ),
                      
                      SizedBox(height: cardPadding * 2),
                      
                      // Active Orders Section
                      _buildActiveOrdersSection(
                        context,
                        screenWidth,
                        fontSize,
                        isPhone,
                        orientation,
                      ),
                      
                      SizedBox(height: cardPadding * 2),
                      
                      // Quick Actions - Flexible Layout
                      _buildQuickActions(
                        context,
                        screenWidth,
                        fontSize,
                        isPhone,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Footer/Action Section - Responsive Button Layout
            _buildFooter(context, screenWidth, isPhone),
          ],
        ),
      ),
    );
  }

  // Responsive Header with adaptive sizing
  Widget _buildHeader(BuildContext context, double screenWidth, double headerFontSize, bool isPhone) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isPhone ? 16.0 : 24.0,
        vertical: isPhone ? 12.0 : 20.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF6B35),
            const Color(0xFFFF8C42),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'iCuisine Dashboard',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: isPhone ? 4 : 8),
                Text(
                  'Manage your orders efficiently',
                  style: TextStyle(
                    fontSize: isPhone ? 12 : 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: isPhone ? 24 : 32,
          ),
        ],
      ),
    );
  }

  // Statistics Section with responsive grid
  Widget _buildStatisticsSection(
    BuildContext context,
    double screenWidth,
    int crossAxisCount,
    double fontSize,
    bool isPhone,
  ) {
    final stats = [
      {'icon': Icons.receipt_long, 'title': 'Active Orders', 'value': '12', 'color': Colors.blue},
      {'icon': Icons.check_circle, 'title': 'Completed', 'value': '45', 'color': Colors.green},
      {'icon': Icons.access_time, 'title': 'Pending', 'value': '8', 'color': Colors.orange},
      {'icon': Icons.attach_money, 'title': 'Today\'s Sales', 'value': '\$520', 'color': Colors.purple},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isPhone ? 8 : 16,
            mainAxisSpacing: isPhone ? 8 : 16,
            childAspectRatio: isPhone ? 1.2 : 1.5,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            final stat = stats[index];
            return _buildStatCard(
              icon: stat['icon'] as IconData,
              title: stat['title'] as String,
              value: stat['value'] as String,
              color: stat['color'] as Color,
              fontSize: fontSize,
              isPhone: isPhone,
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required double fontSize,
    required bool isPhone,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(isPhone ? 12.0 : 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Icon(
                icon,
                color: color,
                size: isPhone ? 32 : 40,
              ),
            ),
            SizedBox(height: isPhone ? 8 : 12),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: fontSize * 1.5,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize * 0.85,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Active Orders with responsive layout
  Widget _buildActiveOrdersSection(
    BuildContext context,
    double screenWidth,
    double fontSize,
    bool isPhone,
    Orientation orientation,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Orders',
          style: TextStyle(
            fontSize: fontSize * 1.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Use different layouts for portrait vs landscape
        orientation == Orientation.portrait
            ? _buildOrdersList(screenWidth, fontSize, isPhone)
            : _buildOrdersGrid(screenWidth, fontSize, isPhone),
      ],
    );
  }

  Widget _buildOrdersList(double screenWidth, double fontSize, bool isPhone) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildOrderCard(index + 1, fontSize, isPhone);
      },
    );
  }

  Widget _buildOrdersGrid(double screenWidth, double fontSize, bool isPhone) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildOrderCard(index + 1, fontSize, isPhone);
      },
    );
  }

  Widget _buildOrderCard(int orderNumber, double fontSize, bool isPhone) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(isPhone ? 12.0 : 16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${100 + orderNumber}',
                    style: TextStyle(
                      fontSize: fontSize * 1.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isPhone ? 4 : 8),
                  Text(
                    '2 items • Table ${orderNumber}',
                    style: TextStyle(
                      fontSize: fontSize * 0.9,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: isPhone ? 12 : 16,
                    vertical: isPhone ? 8 : 12,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'View',
                    style: TextStyle(fontSize: fontSize * 0.9),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Actions with Wrap for responsive flow
  Widget _buildQuickActions(
    BuildContext context,
    double screenWidth,
    double fontSize,
    bool isPhone,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: fontSize * 1.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: isPhone ? 8 : 16,
          runSpacing: isPhone ? 8 : 16,
          children: [
            _buildActionButton(
              'New Order',
              Icons.add_shopping_cart,
              Colors.green,
              fontSize,
              isPhone,
            ),
            _buildActionButton(
              'View Menu',
              Icons.restaurant_menu,
              Colors.blue,
              fontSize,
              isPhone,
            ),
            _buildActionButton(
              'Reports',
              Icons.analytics,
              Colors.purple,
              fontSize,
              isPhone,
            ),
            _buildActionButton(
              'Settings',
              Icons.settings,
              Colors.grey,
              fontSize,
              isPhone,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    double fontSize,
    bool isPhone,
  ) {
    double buttonWidth = isPhone ? 160 : 180;
    
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: isPhone ? 12 : 16,
            horizontal: isPhone ? 8 : 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: isPhone ? 20 : 24),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(fontSize: fontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Responsive Footer with adaptive button sizing
  Widget _buildFooter(BuildContext context, double screenWidth, bool isPhone) {
    return Container(
      padding: EdgeInsets.all(isPhone ? 12.0 : 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: screenWidth < 600
          ? Column(
              children: [
                _buildFooterButton('Take New Order', Icons.add, true, isPhone),
                const SizedBox(height: 8),
                _buildFooterButton('View All Orders', Icons.list, false, isPhone),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _buildFooterButton('Take New Order', Icons.add, true, isPhone),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFooterButton('View All Orders', Icons.list, false, isPhone),
                ),
              ],
            ),
    );
  }

  Widget _buildFooterButton(String label, IconData icon, bool isPrimary, bool isPhone) {
    return SizedBox(
      height: isPhone ? 48 : 56,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(
              fontSize: isPhone ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFFFF6B35) : Colors.white,
          foregroundColor: isPrimary ? Colors.white : const Color(0xFFFF6B35),
          side: isPrimary ? null : const BorderSide(color: Color(0xFFFF6B35), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
