import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TaskStatisticsScreen extends StatefulWidget {
  static const String routeName = '/taskStatistics';

  @override
  _TaskStatisticsScreenState createState() => _TaskStatisticsScreenState();
}

class _TaskStatisticsScreenState extends State<TaskStatisticsScreen> {
  final List<List<int>> monthlyTaskCounts = [
    [10, 5, 3], // January
    [8, 7, 4],  // February
    [12, 6, 2], // March
  ];
  final List<String> taskLabels = ['Hoàn thành', 'Đang thực hiện', 'Mới tạo'];
  final List<Color> taskColors = [Colors.green, Colors.blue, Colors.orange];
  final List<String> months = ['Tháng 1', 'Tháng 2', 'Tháng 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thống Kê Công Việc'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thống Kê Công Việc Theo Tháng',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Container(
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: monthlyTaskCounts.expand((i) => i).reduce((a, b) => a > b ? a : b).toDouble(),
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            );
                          },
                          reservedSize: 30,
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(months.length, (monthIndex) {
                      return BarChartGroupData(
                        x: monthIndex,
                        barRods: List.generate(taskLabels.length, (taskIndex) {
                          return BarChartRodData(
                            toY: monthlyTaskCounts[monthIndex][taskIndex].toDouble(),
                            color: taskColors[taskIndex],
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(taskLabels.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: taskColors[index],
                        ),
                        SizedBox(width: 8),
                        Text(
                          taskLabels[index],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
