import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/reading_time.dart';
import 'package:anaquel/screens/reading_time_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ReadingChart extends StatelessWidget {
  ReadingChart({super.key});

  final ReadingWeek data = ReadingWeek(
    monday: 2400,
    tuesday: 3000 * 0,
    wednesday: 4200,
    thursday: 4500,
    friday: 3900,
    saturday: 3000,
    sunday: 3600,
  );

  String secondsToHours(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    if (hours == 0) return "${minutes}m";
    return "${hours}h ${minutes}m";
  }

  void onTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ReadingTimeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(context),
        overlayColor: WidgetStateProperty.all(
          context.theme.colorScheme.hover(AppColors.antiFlashWhite),
        ),
        borderRadius: context.theme.style.borderRadius,
        child: Ink(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: context.theme.colorScheme.border,
            ),
            borderRadius: context.theme.style.borderRadius,
          ),
          child: BarChart(
            BarChartData(
              maxY: data.max.toDouble() + 1000,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => Colors.transparent,
                  tooltipPadding: EdgeInsets.zero,
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      secondsToHours(rod.toY.round()),
                      const TextStyle(
                        color: AppColors.eerieBlack,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: getTitles,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: barGroups,
              gridData: FlGridData(
                show: true,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    dashArray: [8],
                    color: AppColors.timberwolf.withValues(alpha: 0.25),
                  );
                },
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    dashArray: [8],
                    color: AppColors.timberwolf.withValues(alpha: 0.25),
                  );
                },
              ),
              backgroundColor: Colors.transparent,
              alignment: BarChartAlignment.spaceAround,
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final days = [
      "schedules_screen.days.monday",
      "schedules_screen.days.tuesday",
      "schedules_screen.days.wednesday",
      "schedules_screen.days.thursday",
      "schedules_screen.days.friday",
      "schedules_screen.days.saturday",
      "schedules_screen.days.sunday",
    ];
    String text = (value >= 0 && value < days.length)
        ? days[value.toInt()].tr().substring(0, 3)
        : "";

    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.eerieBlack,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  BarChartRodData rodWidget(double value) {
    return BarChartRodData(
      toY: value,
      gradient: LinearGradient(
        colors: [
          AppColors.eerieBlack.withValues(alpha: 0.85),
          AppColors.eerieBlack,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      color: AppColors.eerieBlack,
      width: 42,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    );
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [rodWidget(data.monday.toDouble())],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [rodWidget(data.tuesday.toDouble())],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [rodWidget(data.wednesday.toDouble())],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [rodWidget(data.thursday.toDouble())],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [rodWidget(data.friday.toDouble())],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [rodWidget(data.saturday.toDouble())],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [rodWidget(data.sunday.toDouble())],
          showingTooltipIndicators: [0],
        ),
      ];
}
