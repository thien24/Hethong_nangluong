import 'package:flutter/material.dart';

class DevicePage extends StatefulWidget {
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  // Trạng thái bật/tắt của các thiết bị
  bool isTvOn = false;
  bool isFridgeOn = false;
  bool isWashingMachineOn = false;
  bool isAirConditionerOn = false;
  bool isLedOn = false;
  bool isFanOn = false;

  // Biến nhiệt độ của máy lạnh
  double airConditionerTemp = 24; // Mặc định là 24 độ C

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Điều khiển thiết bị',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey, // Màu nền cho app bar
      ),
      body: Container(
        color: const Color(0xFF1C1C1C), // Màu nền tối
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // Số cột trong lưới
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _buildGridItem('Tivi', Icons.tv, isTvOn, (value) {
              setState(() {
                isTvOn = value;
              });
            }),
            _buildGridItem('Tủ lạnh', Icons.kitchen, isFridgeOn, (value) {
              setState(() {
                isFridgeOn = value;
              });
            }),
            _buildGridItem('Máy giặt', Icons.local_laundry_service, isWashingMachineOn, (value) {
              setState(() {
                isWashingMachineOn = value;
              });
            }),
            _buildGridItemWithTemperature(
              'Điều hòa', 
              Icons.ac_unit, 
              isAirConditionerOn, 
              airConditionerTemp, 
              (value) {
                setState(() {
                  isAirConditionerOn = value;
                });
              }
            ),
            _buildGridItem('Đèn LED', Icons.light_mode, isLedOn, (value) {
              setState(() {
                isLedOn = value;
              });
            }),
            _buildGridItem('Quạt', Icons.air, isFanOn, (value) {
              setState(() {
                isFanOn = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  // Widget cho các thiết bị không có nhiệt độ
  Widget _buildGridItem(String title, IconData icon, bool isOn, Function(bool) onChanged) {
    return GestureDetector(
      child: Card(
        elevation: 4,
        color: isOn ? const Color.fromARGB(255, 69, 91, 92) : Colors.grey[850], // Màu nền của card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: isOn ? Colors.green : Colors.grey), // Biểu tượng thiết bị
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Màu chữ trắng
                  ),
                  SizedBox(height: 4),
                  Text(
                    isOn ? 'Bật' : 'Tắt',
                    style: TextStyle(fontSize: 12, color: isOn ? Colors.green : Colors.red),
                  ),
                ],
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    onChanged(!isOn); // Chỉ thay đổi trạng thái khi nhấn vào biểu tượng toggle
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isOn ? Icons.toggle_on : Icons.toggle_off, // Thay đổi biểu tượng toggle
                      size: 48, // Kích thước biểu tượng toggle
                      color: isOn ? Colors.green : Colors.grey, // Màu sắc tùy vào trạng thái
                    ),
                    SizedBox(height: 4),
                    Text(
                      isOn ? 'Tắt' : 'Bật',
                      style: TextStyle(fontSize: 12, color: Colors.white), // Màu chữ trắng
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cho điều hòa, hiển thị nhiệt độ nhưng không có thanh trượt
    // Widget cho điều hòa, hiển thị nhiệt độ và không bị nhảy ra
 // Widget cho điều hòa, hiển thị nhiệt độ trong Row
Widget _buildGridItemWithTemperature(String title, IconData icon, bool isOn, double temp, Function(bool) onChanged) {
  return GestureDetector(
    child: Card(
      elevation: 4,
      color: isOn ? const Color.fromARGB(255, 69, 91, 92) : Colors.grey[850], // Màu nền của card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn giữa giữa các phần tử
          crossAxisAlignment: CrossAxisAlignment.center, // Căn chỉnh theo chiều dọc
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, // Căn trái cho văn bản
              children: [
                Icon(icon, size: 40, color: isOn ? Colors.green : Colors.grey), // Biểu tượng thiết bị
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), // Màu chữ trắng
                ),
                SizedBox(height: 4),
                Text(
                  isOn ? 'Bật' : 'Tắt',
                  style: TextStyle(fontSize: 12, color: isOn ? Colors.green : Colors.red),
                ),
                if (isOn) // Hiển thị nhiệt độ nếu điều hòa bật
                  Text(
                    '${temp.toStringAsFixed(1)}°C', // Hiển thị nhiệt độ
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  onChanged(!isOn); // Thay đổi trạng thái khi nhấn vào toggle
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isOn ? Icons.toggle_on : Icons.toggle_off, // Thay đổi biểu tượng toggle
                    size: 48, // Kích thước biểu tượng toggle
                    color: isOn ? Colors.green : Colors.grey, // Màu sắc tùy vào trạng thái
                  ),
                  SizedBox(height: 4),
                  Text(
                    isOn ? 'Tắt' : 'Bật',
                    style: TextStyle(fontSize: 12, color: Colors.white), // Màu chữ trắng
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}