import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/status_badge.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // --- State Variables ---
  int _currentPage = 1;
  int _rowsPerPage = 10;

  // Mock Data
  final List<Map<String, String>> _orders = [
    {'id': 'T201', 'date': '04 Feb 2025 - 02:00 PM', 'status': 'Delivered', 'items': '2 Items'},
    {'id': 'T202', 'date': '04 Feb 2025 - 02:30 PM', 'status': 'In Process', 'items': '5 Items'},
    {'id': 'T203', 'date': '04 Feb 2025 - 03:00 PM', 'status': 'In Process', 'items': '1 Item'},
    {'id': 'T204', 'date': '04 Feb 2025 - 04:15 PM', 'status': 'Delivered', 'items': '3 Items'},
    {'id': 'T205', 'date': '04 Feb 2025 - 05:00 PM', 'status': 'Delivered', 'items': '4 Items'},
    {'id': 'T206', 'date': '04 Feb 2025 - 06:45 PM', 'status': 'Canceled', 'items': '2 Items'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
            ),
          ),
        ),
        title: Text(
          'Order History',
          style: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black54)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined, color: Colors.black54)),
        ],
      ),

      body: ResponsiveDiffLayout(
        MobileBody: _buildMobileList(),
        TabletBody: _buildTabletTable(),
      ),
    );
  }

  // ==========================================
  // 1. MOBILE VIEW (Beautiful Card List)
  // ==========================================
  Widget _buildMobileList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Order ID and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${order['id']}",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      order['date']!.split('-')[0].trim(), // Only Date
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Divider line
                Divider(color: Colors.grey[100], height: 1),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.receipt_long_rounded, color: Colors.blue, size: 20),
                    ),
                    const SizedBox(width: 12),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['items'] ?? "Items",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            order['date']!.split('-')[1].trim(), // Time
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status Badge
                    StatusBadge(status: order['status']!),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: OutlinedButton(
                    onPressed: (){},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("View Details", style: GoogleFonts.nunito(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  // 2. TABLET VIEW (Data Table)

  Widget _buildTabletTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Table
            DataTable(
              headingRowHeight: 50,
              dataRowMinHeight: 60,
              dataRowMaxHeight: 60,
              border: TableBorder(
                horizontalInside: BorderSide(width: 1, color: Colors.grey.shade100),
                bottom: BorderSide(width: 1, color: Colors.grey.shade100),
              ),
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF9FAFB)),
              columnSpacing: 30,
              horizontalMargin: 30,
              columns: [
                DataColumn(label: Text('#', style: GoogleFonts.nunito(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Date & Time', style: GoogleFonts.nunito(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Status', style: GoogleFonts.nunito(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Action', style: GoogleFonts.nunito(fontWeight: FontWeight.bold))),
              ],
              rows: _orders.map((order) {
                return DataRow(cells: [
                  DataCell(Text(order['id']!, style: GoogleFonts.nunito(color: Colors.grey.shade700, fontWeight: FontWeight.bold))),
                  DataCell(Text(order['date']!, style: GoogleFonts.nunito(color: Colors.grey.shade800))),
                  DataCell(StatusBadge(status: order['status']!)),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.visibility_outlined, color: Colors.black54, size: 20),
                      onPressed: (){},
                    ),
                  ),
                ]);
              }).toList(),
            ),

            // Pagination Controls (Only for Tablet)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, size: 20),
                        onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                      ),
                      _buildPageNumberBtn(1),
                      const SizedBox(width: 4),
                      _buildPageNumberBtn(2),
                      const SizedBox(width: 4),
                      const Text('..', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 4),
                      _buildPageNumberBtn(10),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, size: 20),
                        onPressed: _currentPage < 10 ? () => setState(() => _currentPage++) : null,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Show  ', style: GoogleFonts.nunito(color: Colors.grey, fontSize: 13)),
                      Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _rowsPerPage,
                            icon: const Icon(Icons.arrow_drop_down, size: 18),
                            style: GoogleFonts.nunito(color: Colors.black87, fontSize: 13),
                            items: [10, 20, 50].map((int value) {
                              return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                            }).toList(),
                            onChanged: (v) => setState(() => _rowsPerPage = v!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageNumberBtn(int pageNum) {
    bool isActive = _currentPage == pageNum;
    return InkWell(
      onTap: () => setState(() => _currentPage = pageNum),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.black87 : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          pageNum.toString(),
          style: GoogleFonts.nunito(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}