import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Nhập thư viện audio

class GasSensorPage extends StatelessWidget {
  // Giả lập dữ liệu cảm biến khí gas
  final String location = 'Nhà bếp';
  final String dateTime = '29/09/2024 - 14:30';
  final String gasDensity = 'Mật độ khí: Cao'; // Giả lập mật độ khí

  final AudioPlayer _audioPlayer = AudioPlayer(); // Tạo đối tượng AudioPlayer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cảm biến khí gas'),
        backgroundColor: const Color.fromARGB(255, 115, 114, 114),
        centerTitle: true,
      ),
      body: Stack( // Sử dụng Stack để đặt hình nền và nội dung
        children: [
          // Hình nền
          Image.network(
            'https://siamgas.com.vn/wp-content/uploads/khi-gas-1.jpg', // Thay thế bằng URL hình ảnh của bạn
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
                    'Trạng thái cảm biến khí gas',
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
                          Icon(Icons.gas_meter_outlined, size: 80, color: Colors.orange),
                          SizedBox(height: 10),
                          Text(
                            'Phát hiện khí gas tại $location!',
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
                            gasDensity,
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
                      // Xử lý sự kiện nhấn nút kiểm tra
                      _checkGasLevel(context); // Thêm context vào tham số
                    },
                    child: Text('Kiểm tra ngay'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Phát âm thanh cảnh báo khi nhấn nút
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

  void _checkGasLevel(BuildContext context) {
    // Xử lý kiểm tra khí gas
    print('Đang kiểm tra mức độ khí gas...');

    // Hiển thị SnackBar thông báo đang kiểm tra
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mức độ khí gas đang được kiểm tra...'),
        duration: Duration(seconds: 3), // Thời gian hiển thị
      ),
    );

    // Sau 3 giây, hiển thị thông báo cần sơ tán khẩn cấp
    Future.delayed(Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cần sơ tán khẩn cấp! Mật độ khí gas rất cao, dễ gây cháy nổ!'),
          duration: Duration(seconds: 5), // Thời gian hiển thị
          backgroundColor: Colors.red, // Màu nền thông báo
        ),
      );
    });
  }

  void _playAlertSound() async {
    await _audioPlayer.play(AssetSource('sounds/coibaochay.mp3')); // Phát âm thanh cảnh báo
  }

  void _stopAlertSound() async {
    await _audioPlayer.stop(); // Dừng âm thanh cảnh báo
  }
}
