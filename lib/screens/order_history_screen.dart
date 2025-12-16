import 'package:flutter/material.dart';

import '../widgets/status_badge.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // --- State Variables for Logic ---
  int _currentPage = 1;      // Currently selected page
  int _rowsPerPage = 10;     // Dropdown value

  // Mock Data
  final List<Map<String, String>> _orders = [
    {'id': 'T201', 'date': '04 Feb 2025 - 02:00 PM', 'status': 'Delivered'},
    {'id': 'T202', 'date': '04 Feb 2025 - 02:30 PM', 'status': 'In Process'},
    {'id': 'T203', 'date': '04 Feb 2025 - 03:00 PM', 'status': 'In Process'},
    {'id': 'T204', 'date': '04 Feb 2025 - 04:15 PM', 'status': 'Delivered'},
    {'id': 'T205', 'date': '04 Feb 2025 - 05:00 PM', 'status': 'Delivered'},
    {'id': 'T206', 'date': '04 Feb 2025 - 06:45 PM', 'status': 'Canceled'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Thoda contrast background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
            ),
          ),
        ),
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black54)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined, color: Colors.black54)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.black54)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            // Light shadow for card effect
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

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  // Yaha se Vertical Lines aayengi
                  border: TableBorder(
                    verticalInside: BorderSide(width: 1, color: Colors.grey.shade200),
                    horizontalInside: BorderSide(width: 1, color: Colors.grey.shade200),
                    bottom: BorderSide(width: 1, color: Colors.grey.shade200),
                  ),
                  headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)), // Very light grey header
                  columnSpacing: 30,
                  horizontalMargin: 24,
                  columns: const [
                    DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Date & Time', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: _orders.map((order) {
                    return DataRow(cells: [
                      DataCell(Text(order['id']!, style: TextStyle(color: Colors.grey.shade700))),
                      DataCell(Text(order['date']!, style: TextStyle(color: Colors.grey.shade800))),
                      DataCell(StatusBadge(status: order['status']!)),
                      DataCell(
                        const Icon(Icons.visibility_outlined, color: Colors.black54, size: 20),
                      ),
                    ]);
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, size: 20),
                            onPressed: _currentPage > 1
                                ? () => setState(() => _currentPage--)
                                : null,
                          ),
                  
                          _buildPageNumberBtn(1),
                          const SizedBox(width: 4),
                          _buildPageNumberBtn(2),
                          const SizedBox(width: 4),
                  
                          const Text('..', style: TextStyle(color: Colors.grey)),
                          const SizedBox(width: 4),
                  
                          _buildPageNumberBtn(20),
                  
                          IconButton(
                            icon: const Icon(Icons.chevron_right, size: 20),
                            onPressed: _currentPage < 20
                                ? () => setState(() => _currentPage++)
                                : null,
                          ),
                        ],
                      ),
                  
                      Row(
                        children: [
                          const Text('Show  ', style: TextStyle(color: Colors.grey, fontSize: 13)),
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
                                style: const TextStyle(color: Colors.black87, fontSize: 13),
                                items: [10, 20, 50, 100].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _rowsPerPage = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget: Clickable Page Number
  Widget _buildPageNumberBtn(int pageNum) {
    bool isActive = _currentPage == pageNum;

    return InkWell(
      onTap: () {
        setState(() {
          _currentPage = pageNum;
        });
      },
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.black87 : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: isActive ? null : Border.all(color: Colors.transparent), // invisible border to keep size same
        ),
        child: Text(
          pageNum.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}