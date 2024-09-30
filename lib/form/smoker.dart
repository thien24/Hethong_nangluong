import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Nhập thư viện audio

class SmokerPage extends StatelessWidget {
  // Giả lập dữ liệu cảm biến khói
  final String location = 'Phòng khách';
  final String dateTime = '29/09/2024 - 14:30';
  final String smokeDensity = 'Mật độ khói: Cao'; // Giả lập mật độ khói

  final AudioPlayer _audioPlayer = AudioPlayer(); // Tạo đối tượng AudioPlayer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cảm biến khói'),
        backgroundColor: const Color.fromARGB(255, 115, 114, 114),
        centerTitle: true,
      ),
      body: Stack( // Sử dụng Stack để đặt hình nền và nội dung
        children: [
          // Hình nền
          Image.network(
            'https://img.pikbest.com/png-images/qianku/white-smoke-effect_2372732.png!sw800', // Thay thế bằng URL hình ảnh của bạn
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Nội dung chính
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Trạng thái cảm biến khói',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Đổi màu chữ để dễ đọc
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.smoke_free, size: 80, color: Colors.red),
                          SizedBox(height: 10),
                          Text(
                            'Phát hiện khói tại $location!',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Thời gian: $dateTime',
                            style: TextStyle(fontSize: 16, color: Colors.black), // Đổi màu chữ
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            smokeDensity,
                            style: TextStyle(fontSize: 16, color: Colors.black), // Đổi màu chữ
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Vui lòng kiểm tra khu vực xung quanh.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Nếu mật độ khói cao, thực hiện hành động phun nước
                      if (smokeDensity.contains('Cao')) {
                        _checkSmokeLevel(context);
                      }
                    },
                    child: Text('Kiểm tra ngay'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Phát âm thanh cảnh báo
                      _playAlertSound();
                    },
                    child: Text('Phát âm thanh cảnh báo'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Dừng âm thanh cảnh báo
                      _stopAlertSound();
                    },
                    child: Text('Dừng âm thanh cảnh báo'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkSmokeLevel(BuildContext context) {
    // Hiển thị thông báo đang kiểm tra
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mức độ khói đang được kiểm tra...'),
        duration: Duration(seconds: 3), // Thời gian hiển thị
      ),
    );

    // Sau 3 giây, cập nhật thông báo
    Future.delayed(Duration(seconds: 3), () {
      _updateSmokeStatus(context);
    });
  }

  void _updateSmokeStatus(BuildContext context) {
    // Cập nhật trạng thái khói
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Khói rất dày đặc, có thể đã có cháy nổ'),
        duration: Duration(seconds: 3), // Thời gian hiển thị
        backgroundColor: Colors.red, // Màu nền thông báo
      ),
    );
  }

  void _sprayWater() {
    // Xử lý phun nước
    print('Phun nước đã được kích hoạt!');
  }

  void _playAlertSound() async {
    await _audioPlayer.play(AssetSource('sounds/coibaochay.mp3')); // Phát âm thanh cảnh báo
  }

  void _stopAlertSound() async {
    await _audioPlayer.stop(); // Dừng âm thanh cảnh báo
  }
}
