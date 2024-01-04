import 'package:cloud_firestore/cloud_firestore.dart';

// Function to check device connectivity

Future<List<Map<String, dynamic>>> getAllData(
    String collectionName, bool posted, bool report) async {
  List<Map<String, dynamic>> allData = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userId)
          .collection(collectionName == 'posts' ? 'Posts' : 'SalePlants');

      try {
        // Get a snapshot of data for the current user, ordered by date in descending order
        QuerySnapshot userDataSnapshot = await userPostsRef
            .where('posted', isEqualTo: posted)
            .where('report', isEqualTo: report)
            .orderBy('date', descending: true)
            .get();

        // Iterate through each data document and add data to the list
        for (final dataDoc in userDataSnapshot.docs) {
          final data = dataDoc.data() as Map<String, dynamic>;
          allData.add(data);
        }
      } catch (e) {
        // Handle errors when getting data for a user
        print('Error getting data for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  // Sort the list in descending order by date
  allData.sort((a, b) => b['date'].compareTo(a['date']));

  return allData;
}

Future<List<Map<String, dynamic>>> getAllDataForStatistics(
    String collectionName) async {
  List<Map<String, dynamic>> allData = [];

  final userUidsRef = FirebaseFirestore.instance.collection('users');

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot = await userUidsRef.get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userId = userDoc.id;
      final userPostsRef = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userId)
          .collection(collectionName == 'posts' ? 'Posts' : 'SalePlants');

      try {
        // Get a snapshot of data for the current user, ordered by date in descending order
        QuerySnapshot userDataSnapshot = await userPostsRef.get();

        // Iterate through each data document and add data to the list
        for (final dataDoc in userDataSnapshot.docs) {
          final data = dataDoc.data() as Map<String, dynamic>;
          allData.add(data);
        }
      } catch (e) {
        // Handle errors when getting data for a user
        print('Error getting data for user $userId: $e');
      }
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  // Sort the list in descending order by date
  allData.sort((a, b) => b['date'].compareTo(a['date']));

  return allData;
}

Future<List<Map<String, dynamic>>> getAllUsersForStatistics() async {
  return await getAllUserDataForStatistics('users');
}

Future<List<Map<String, dynamic>>> getAllUserDataForStatistics(
    String collectionName) async {
  List<Map<String, dynamic>> allData = [];

  try {
    // Get a snapshot of all user documents
    final userUidsSnapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    // Iterate through each user document
    for (final userDoc in userUidsSnapshot.docs) {
      final userData = userDoc.data();

      // Add user data to the list
      allData.add(userData);
    }
  } catch (e) {
    // Handle errors when getting user documents
    print('Error getting user documents: $e');
  }

  return allData;
}

// Example usage for getting all posts
Future<List<Map<String, dynamic>>> getAllPosts() async {
  return await getAllData('posts', false, false);
}

// Example usage for getting all sell posts
Future<List<Map<String, dynamic>>> getAllSellPosts() async {
  return await getAllData('salePlants', false, false);
}

// Example usage for getting all posts
Future<List<Map<String, dynamic>>> getAllPostsForStatistics() async {
  return await getAllDataForStatistics('posts');
}

// Example usage for getting all sell posts
Future<List<Map<String, dynamic>>> getAllSellPostsForStatistics() async {
  return await getAllDataForStatistics('salePlants');
}

Future<List<Map<String, dynamic>>> getMyData(
    String collectionName, String userId) async {
  List<Map<String, dynamic>> myData = [];

  final userPostsRef = FirebaseFirestore.instance
      .collection(collectionName)
      .doc(userId)
      .collection(collectionName == 'posts' ? 'Posts' : 'SalePlants');

  try {
    // Get a snapshot of data for the current user, ordered by date in descending order
    QuerySnapshot userPostsSnapshot = await userPostsRef
        .where('posted', isEqualTo: true)
        .orderBy('date', descending: true)
        .get();

    // Iterate through each data document and add data to the list
    for (final dataDoc in userPostsSnapshot.docs) {
      final data = dataDoc.data() as Map<String, dynamic>;
      myData.add(data);
    }
  } catch (e) {
    // Handle errors when getting data for the user
    print('Error getting data for user $userId: $e');
  }

  // Sort the list in descending order by date
  myData.sort((a, b) => b['date'].compareTo(a['date']));

  return myData;
}

// Example usage for getting posts for the current user
Future<List<Map<String, dynamic>>> getMyPosts(String userId) async {
  return await getMyData('posts', userId);
}

// Example usage for getting sell posts for the current user
Future<List<Map<String, dynamic>>> getMySells(String userId) async {
  return await getMyData('salePlants', userId);
}

Future<List<Map<String, dynamic>>> getAllDataReport() async {
  List<Map<String, dynamic>> allData = [], allPost = [], allSale = [];
  allPost = await getAllData('posts', true, true);
  allSale = await getAllData('salePlants', true, true);
  allData.addAll(allPost);
  allData.addAll(allSale);

  // Sort the list in descending order by date
  allData.sort((a, b) => b['date'].compareTo(a['date']));

  return allData;
}

Future<List<Map<String, dynamic>>> getUsersData() async {
  try {
    // Reference to the Firestore collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query for all documents in the 'users' collection
    QuerySnapshot querySnapshot = await usersCollection.get();

    // List to store user data
    List<Map<String, dynamic>> userDataList = [];

    // Iterate through each user document
    querySnapshot.docs.forEach((DocumentSnapshot userDoc) {
      // Extract data from the user document
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Add the user data to the list
      userDataList.add(userData);
    });

    return userDataList;
  } catch (e) {
    print('Error getting user data: $e');
    return [];
  }
}
