import 'package:flutter/material.dart';
import 'device.dart'; // Import file device.dart
import 'power.dart';
import 'smoker.dart';
import 'gas.dart';
import 'thongbao.dart'; // Import file thongbao.dart

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // Sử dụng MediaQuery để xác định kích thước màn hình
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://lumi.vn/wp-content/uploads/2023/11/nha-thong-minh-smarthome-la-gi-768x576.webp'), // Đường dẫn đến hình nền của bạn
                fit: BoxFit.cover, // Đảm bảo hình nền bao phủ toàn bộ khung hình
              ),
            ),
          ),
          // Overlay color
          Container(
            color: Colors.black.withOpacity(0.5), // Màu overlay (tối hơn) để tăng độ tương phản với các thành phần trên
          ),
          // Nội dung chính
          Column(
            children: [
              // Tiêu đề
              AppBar(
                title: Text('Home Control System'),
                backgroundColor: Colors.transparent, // Để tiêu đề trong suốt
                elevation: 0, // Không có bóng
              ),
              // Phần thêm ảnh
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  'https://lumi.vn/wp-content/uploads/2023/11/nha-thong-minh-smarthome-la-gi-768x576.webp', // Đường dẫn đến ảnh trong dự án của bạn
                  height: screenSize.height * 0.25, // Điều chỉnh chiều cao của ảnh (25% chiều cao màn hình)
                  width: screenSize.width, // Chiều rộng bằng màn hình
                  fit: BoxFit.cover, // Đảm bảo ảnh bao phủ toàn bộ khung hình
                ),
              ),
              // Phần GridView chứa các thẻ
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2, // Hiển thị 2 cột
                    crossAxisSpacing: 10, // Khoảng cách giữa các cột
                    mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                    childAspectRatio: (screenSize.width / 2) / (screenSize.height / 5), // Tỷ lệ diện tích dựa trên màn hình
                    children: [
                      _buildCard('Điều khiển thiết bị', Icons.device_hub, context, color: Colors.grey),
                      _buildCard('Giám sát năng lượng', Icons.battery_charging_full, context, color: Colors.grey),
                      _buildCard('Cảm biến khói', Icons.smoke_free, context, color: Colors.grey),
                      _buildCard('Cảm biến khí gas', Icons.gas_meter_outlined, context, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
     bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.grey, // Đặt màu nền thành xám
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: 'Thông báo',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Trang chủ',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.workspace_premium),
      label: 'Premium', 
    ),
  ],
  currentIndex: 1, // Chọn trang chủ
  onTap: (index) {
    if (index == 0) {
      // Di chuyển đến ThongBaoPage khi nhấn vào "Thông báo"
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThongBaoPage()),
      );
    } else if (index == 1) {
      // Di chuyển đến Trang chủ (nếu cần)
      Navigator.pop(context); // Có thể pop ra nếu đang ở trang này
    } else if (index == 2) {
      // Thêm logic điều hướng cho Premium (nếu có trang Premium)
      // Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumPage()));
    }
  },
),

    );
  }

  Widget _buildCard(String title, IconData icon, BuildContext context, {Color color = Colors.grey}) {
    return Card(
      color: color, // Thay đổi màu sắc thẻ
      elevation: 4,
      child: Center(
        child: ListTile(
          leading: Icon(icon, size: 40),
          title: Text(
            title,
            style: TextStyle(fontSize: 14), // Giảm kích thước chữ xuống 14
          ),
          onTap: () {
            // Kiểm tra nếu là biểu tượng Điều khiển thiết bị thì điều hướng
            if (icon == Icons.device_hub) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DevicePage()),
              );
            } else if (icon == Icons.battery_charging_full) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LineChartExample()),
              );
            } else if (icon == Icons.smoke_free) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SmokerPage()),
              );
            } else if (icon == Icons.gas_meter_outlined) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GasSensorPage()),
              );
            }
          }
        ),
      ),
    );
  }
}
