import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LineChartExample(),
    );
  }
}

class LineChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Biểu đồ Tiêu thụ Năng lượng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Biểu đồ đường') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BdDuongScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'Biểu đồ đường', child: Text('Biểu đồ đường', style: TextStyle(color: Colors.black))),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Image.network(
            'https://media.istockphoto.com/id/1420649842/vi/vec-to/n%E1%BB%81n-bi%E1%BB%83u-%C4%91%E1%BB%93-t%C3%A0i-ch%C3%ADnh-%C4%91ang-ph%C3%A1t-tri%E1%BB%83n-tr%E1%BB%ABu-t%C6%B0%E1%BB%A3ng.jpg?s=612x612&w=0&k=20&c=cVe-yEQEr5BMBhf57Wf2sVlXVWm2vMtDiDuGQXvmxJo=',
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.height,
          ),
          // Nội dung biểu đồ
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDropdownMenu(context),
                SizedBox(height: 16),
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.45,
                  child: _buildColumnChart(),
                ),
                SizedBox(height: 20),
                _buildDeviceLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<EnergyData> _getData() {
    return [
      EnergyData(1, 100, Colors.lightBlue),
      EnergyData(2, 150, Colors.greenAccent),
      EnergyData(3, 1400, Colors.redAccent),
      EnergyData(4, 1100, Colors.orangeAccent),
      EnergyData(5, 200, Colors.purpleAccent),
      EnergyData(6, 100, Colors.yellowAccent),
      EnergyData(7, 50, Colors.black),
    ];
  }

  Widget _buildColumnChart() {
    return SfCartesianChart(
      title: ChartTitle(text: 'Tiêu thụ Năng lượng (W)', textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(fontSize: 12, color: Colors.white),
        title: AxisTitle(text: 'Thiết bị', textStyle: TextStyle(fontSize: 14, color: Colors.white)),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(fontSize: 12, color: Colors.white),
        majorGridLines: MajorGridLines(width: 0.7),
        minimum: 0,
      ),
      series: <CartesianSeries>[
        ColumnSeries<EnergyData, String>(
          dataSource: _getData(),
          xValueMapper: (EnergyData energy, _) => energy.deviceId.toString(),
          yValueMapper: (EnergyData energy, _) => energy.consumption,
          name: 'Năng lượng',
          width: 0.7,
          spacing: 0.3,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 11, color: Colors.white),
          ),
          pointColorMapper: (EnergyData energy, _) => energy.color,
        ),
      ],
    );
  }

  Widget _buildDropdownMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Biểu đồ đường') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BdDuongScreen()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: 'Biểu đồ đường', child: Text('Biểu đồ thời gian', style: TextStyle(color: Colors.black))),
            ];
          },
          child: Row(
            children: [
              Icon(Icons.menu, color: Colors.white),
              SizedBox(width: 8),
              Text('Menu', style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chú thích thiết bị:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 8),
        _buildLegendItem(Colors.lightBlue, 'Tivi - 100W'),
        _buildLegendItem(Colors.greenAccent, 'Máy giặt - 150W'),
        _buildLegendItem(Colors.redAccent, 'Tủ lạnh - 1500W'),
        _buildLegendItem(Colors.orangeAccent, 'Điều hòa - 1100W'),
        _buildLegendItem(Colors.purpleAccent, 'Đèn LED - 200W'),
        _buildLegendItem(Colors.yellowAccent, 'Quạt - 100W'),
        _buildLegendItem(Colors.black, 'Thiết bị khác - 50W'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String deviceName) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          deviceName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }
}

// Cập nhật mô hình dữ liệu để bao gồm màu sắc
class EnergyData {
  final int deviceId;
  final double consumption;
  final Color color;

  EnergyData(this.deviceId, this.consumption, this.color);
}

// Kết hợp lớp BdDuongScreen vào đây
class BdDuongScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Biểu đồ Thời gian Hoạt động', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.network(
            'https://media.istockphoto.com/id/1420649842/vi/vec-to/n%E1%BB%81n-bi%E1%BB%83u-%C4%91%E1%BB%93-t%C3%A0i-ch%C3%ADnh-%C4%91ang-ph%C3%A1t-tri%E1%BB%83n-tr%E1%BB%ABu-t%C6%B0%E1%BB%A3ng.jpg?s=612x612&w=0&k=20&c=cVe-yEQEr5BMBhf57Wf2sVlXVWm2vMtDiDuGQXvmxJo=',
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.height,
          ),
          // Nội dung biểu đồ
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.45,
                  child: _buildLineChart(),
                ),
                SizedBox(height: 20),
                _buildDeviceLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
  return SfCartesianChart(
    title: ChartTitle(
      text: 'Thời gian hoạt động của thiết bị (giờ)',
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    primaryXAxis: CategoryAxis(
      labelStyle: TextStyle(fontSize: 12, color: Colors.white),
      title: AxisTitle(text: 'Thiết bị', textStyle: TextStyle(fontSize: 14, color: Colors.white)),
    ),
    primaryYAxis: NumericAxis(
      labelStyle: TextStyle(fontSize: 12, color: Colors.white),
      majorGridLines: MajorGridLines(width: 0.7),
    ),
    series: <CartesianSeries>[
      LineSeries<EnergyData, String>(
        dataSource: _getData(),
        xValueMapper: (EnergyData energy, _) => energy.deviceId.toString(),
        yValueMapper: (EnergyData energy, _) => energy.consumption,
        name: 'Thời gian',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 11, color: Colors.white),
        ),
        pointColorMapper: (EnergyData energy, _) => energy.color, // Thêm dòng này
      ),
    ],
  );
}


  List<EnergyData> _getData() {
    return [
      EnergyData(1, 10, Colors.lightBlue),
      EnergyData(2, 15, Colors.greenAccent),
      EnergyData(3, 24, Colors.redAccent),
      EnergyData(4, 11, Colors.orangeAccent),
      EnergyData(5, 20, Colors.purpleAccent),
      EnergyData(6, 10, Colors.yellowAccent),
      EnergyData(7, 5, Colors.black),
    ];
  }

  Widget _buildDeviceLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chú thích thiết bị:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 8),
        _buildLegendItem(Colors.lightBlue, 'Tivi - 10 giờ'),
        _buildLegendItem(Colors.greenAccent, 'Máy giặt - 15 giờ'),
        _buildLegendItem(Colors.redAccent, 'Tủ lạnh - 24 giờ'),
        _buildLegendItem(Colors.orangeAccent, 'Điều hòa - 11 giờ'),
        _buildLegendItem(Colors.purpleAccent, 'Đèn LED - 20 giờ'),
        _buildLegendItem(Colors.yellowAccent, 'Quạt - 10 giờ'),
        _buildLegendItem(Colors.black, 'Thiết bị khác - 5 giờ'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String deviceName) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          deviceName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }
}
