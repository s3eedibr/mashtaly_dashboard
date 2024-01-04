import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mashtaly_dashboard/getData/getData.dart';

class PostStatistics extends StatefulWidget {
  PostStatistics({Key? key}) : super(key: key);

  @override
  State<PostStatistics> createState() => _PostStatisticsState();
}

class _PostStatisticsState extends State<PostStatistics> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: getAllPostsForStatistics(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.hasError) {
              return Container(); // Display error message if an error occurs
            } else {
              List<ArticlesData> chartArticlesData =
                  getArticleChartData(snapshot.data!);

              return FutureBuilder(
                future: getAllSellPostsForStatistics(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Container(); // Display error message if an error occurs
                  } else {
                    List<SalePlantsData> chartSalePlantsData =
                        getSalesPlantChartData(snapshot.data!);

                    return Column(
                      children: [
                        buildPostsStatistics(
                            chartArticlesData, chartSalePlantsData),
                        buildUserStatistics(),
                      ],
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildPostsStatistics(List<ArticlesData> chartArticleData,
      List<SalePlantsData> chartSalePlantData) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      enableAxisAnimation: true,
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Month')),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Number of Posts'),
        interval: 1,
      ),
      series: <CartesianSeries>[
        ColumnSeries<ArticlesData, String>(
          name: 'Articles',
          dataSource: chartArticleData,
          xValueMapper: (ArticlesData posts, _) => posts.postsMonth,
          yValueMapper: (ArticlesData posts, _) => posts.posts,
          color: tPrimaryActionColor, // Customize the color as needed
        ),
        ColumnSeries<SalePlantsData, String>(
          name: 'Plants for sale',
          dataSource: chartSalePlantData,
          xValueMapper: (SalePlantsData posts, _) => posts.postsMonth,
          yValueMapper: (SalePlantsData posts, _) => posts.posts,
          color: tPrimaryActionBarColor, // Customize the color as needed
        ),
      ],
    );
  }

  Widget buildUserStatistics() {
    // Assuming you have a method to get the number of users per month
    return FutureBuilder<List<UserData>>(
      future: getUserChartData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<UserData> userData = snapshot.data!;
          return SfCartesianChart(
            backgroundColor: Colors.white,
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Month')),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'Number of Users'),
              interval: 1,
            ),
            legend: Legend(isVisible: true),
            series: <CartesianSeries>[
              ColumnSeries<UserData, String>(
                name: 'Users',
                dataSource: userData,
                xValueMapper: (UserData user, _) => user.userMonth,
                yValueMapper: (UserData user, _) => user.users,
                color: tPrimaryActionColor, // Customize the color as needed
              ),
            ],
          );
        }
      },
    );
  }

  List<ArticlesData> getArticleChartData(List<Map<String, dynamic>> postsData) {
    List<ArticlesData> chartData = [];

    for (var post in postsData) {
      String dateString = post['date'];
      DateTime postTime = DateTime.parse(dateString);
      String month = DateFormat('MMM').format(postTime);
      chartData.add(ArticlesData(month, chartData.length + 1));
    }

    return chartData;
  }

  List<SalePlantsData> getSalesPlantChartData(
      List<Map<String, dynamic>> postsData) {
    List<SalePlantsData> chartData = [];

    for (var post in postsData) {
      String dateString = post['date'];
      DateTime postTime = DateTime.parse(dateString);
      String month = DateFormat('MMM').format(postTime);
      chartData.add(SalePlantsData(month, chartData.length + 1));
    }

    return chartData;
  }

  Future<List<UserData>> getUserChartData() async {
    // Implement the logic to get the number of users per month
    // Using getUsersData() to fetch user data from Firestore
    List<Map<String, dynamic>> usersData = await getUsersData();

    List<UserData> chartData = [];

    for (var user in usersData) {
      String dateString = user['date'];
      DateTime userTime = DateTime.parse(dateString);
      String month = DateFormat('MMM').format(userTime);
      chartData.add(UserData(month, chartData.length + 1));
    }

    return chartData;
  }
}

class ArticlesData {
  ArticlesData(
    this.postsMonth,
    this.posts,
  );
  final String postsMonth;
  final double posts;
}

class SalePlantsData {
  SalePlantsData(
    this.postsMonth,
    this.posts,
  );
  final String postsMonth;
  final double posts;
}

class UserData {
  UserData(
    this.userMonth,
    this.users,
  );
  final String userMonth;
  final double users;
}
