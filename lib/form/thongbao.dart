import 'package:flutter/material.dart';

class ThongBaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://image.slidesdocs.com/responsive-images/docs/notice-board-for-the-chinese-style-national-mountain-illustration-event-program-page-border-background-word-template_15b74d714f__1131_1600.jpg', // Hình nền
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent, // Màu nền trong suốt
              elevation: 0, // Không có bóng
            ),
            Expanded( // Sử dụng Expanded để nội dung chiếm toàn bộ không gian còn lại
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column( // Sử dụng Column để chứa tiêu đề và danh sách thông báo
                  children: [
                    Text(
                      'Thông báo', // Tiêu đề thông báo
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Màu chữ tiêu đề
                      ),
                      textAlign: TextAlign.center, // Căn giữa tiêu đề
                    ),
                    SizedBox(height: 16), // Khoảng cách giữa tiêu đề và danh sách
                    Expanded(
                      child: ListView(
                        children: [
                          _buildNotificationCard(
                            'Thiết bị tủ lạnh tiêu thụ điện nhiều.',
                            'Hãy kiểm tra để giảm thiểu tiêu thụ.',
                            Icons.kitchen,
                            Colors.blueAccent,
                            '', // Không cần ngày giờ
                          ),
                          _buildNotificationCard(
                            'Khói phát hiện!',
                            'Khói đã được phát hiện tại phòng khách. Vui lòng kiểm tra.',
                            Icons.warning,
                            Colors.redAccent,
                            '29/09/2024 - 14:30', // Ngày giờ cho thông báo khói
                          ),
                          _buildNotificationCard(
                            'Khí gas phát hiện!',
                            'Khí gas có mật độ cao tại nhà bếp. Cần sơ tán khẩn cấp!',
                            Icons.gas_meter_outlined,
                            Colors.orange,
                            '29/09/2024 - 14:30', // Ngày giờ cho thông báo khí gas
                          ),
                          // Thêm nhiều thông báo khác nếu cần
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String title, String description, IconData icon, Color color, String dateTime) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 30),
            ),
            SizedBox(width: 16), // Khoảng cách giữa biểu tượng và văn bản
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                  if (dateTime.isNotEmpty) // Chỉ hiển thị ngày giờ nếu có
                    SizedBox(height: 4),
                  if (dateTime.isNotEmpty)
                    Text(
                      dateTime,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
