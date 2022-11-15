import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radda_moodle_learning/ApiModel/assignmentDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/calendar_events_response.dart';
import 'package:radda_moodle_learning/ApiModel/contact_request_response.dart';
import 'package:radda_moodle_learning/ApiModel/gradeDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/group_message_response.dart';
import 'package:radda_moodle_learning/ApiModel/quiz_attempt_summery.dart';
import 'package:radda_moodle_learning/ApiModel/quiz_question_response.dart';
import 'package:radda_moodle_learning/ApiModel/start_quiz_attempt_response.dart';
import '../ApiModel/allChatsHolderResponse.dart';
import '../ApiModel/assignmentResponse.dart';
import '../ApiModel/categoryResponse.dart';
import '../ApiModel/courseContentResponse.dart';
import '../ApiModel/courseDetailsReponse.dart';
import '../ApiModel/gradeResponse.dart';
import '../ApiModel/loginResponse.dart';
import '../ApiModel/monthly_calendar_response.dart';
import '../ApiModel/notificationResponse.dart';
import '../ApiModel/profileInfoResponse.dart';
import '../ApiModel/profileResponse.dart';
import '../ApiModel/recentCoursesResponse.dart';
import '../ApiModel/userCoursesList.dart';
import '../ApiModel/userDetailsResponse.dart';

class NetworkCall {
  final String baseUrl = "https://diginet-elarning.adnarchive.com/";//"https://www.raddaelearning.org/";
  final String loginUrl = "https://diginet-elarning.adnarchive.com/login/token.php?service=moodle_mobile_app&moodlewsrestformat=json&";//"https://www.raddaelearning.org/login/token.php?service=moodle_mobile_app&moodlewsrestformat=json&";
  final String apiKey = "cStSLnzMq2fo5LARbLAUiULslVJiWFRCkqwN6VsK7Xg6m19h3WgwWBv23eer8kl7DIEh";

  Future<LoginReponse?> LoginCall(String username, String password) async {
    String fullUrl = loginUrl+'username=$username&password=$password';
    final loginResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("loginResponseData_URL = " + fullUrl);
    print("loginResponseData = " + loginResponseData.body);
    if (loginResponseData.statusCode == 200) {
      return LoginReponse.fromJson(jsonDecode(loginResponseData.body));
    } else {
      return null;
    }
  }

  Future<UserDetailsReponse?> UserDetailsCall(String token) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_webservice_get_site_info&moodlewsrestformat=json&wstoken=$token';
    final userDetailsReponseeData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponseeData_URL = " + fullUrl);
    print("userDetailsReponseeData = " + userDetailsReponseeData.body);
    if (userDetailsReponseeData.statusCode == 200) {
      return UserDetailsReponse.fromJson(jsonDecode(userDetailsReponseeData.body));
    } else {
      return null;
    }
  }

  Future<ProfileResponse?> UserProfileCall(String token , String userId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=core_user_get_users_by_field&moodlewsrestformat=json&wstoken=$token&field=id&values[]=$userId';
    final userDetailsReponseeData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponseeData_URL = " + fullUrl);
    print("userDetailsReponseeData = " + userDetailsReponseeData.body);
    if (userDetailsReponseeData.statusCode == 200) {
      final jsonresponse = jsonDecode(userDetailsReponseeData.body);
      return ProfileResponse.fromJson(jsonresponse[0]);
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> UserCoursesListCall(String token ,String userId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?moodlewsrestformat=json&wstoken=$token&wsfunction=core_enrol_get_users_courses&userid=$userId&returnusercount=1';

    final userDetailsResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponsee_URL = " + fullUrl);
    print("userDetailsReponseeData = " + userDetailsResponseData.body);
    if (userDetailsResponseData.statusCode == 200) {
      final jsonresponse = jsonDecode(userDetailsResponseData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> userCoursesList = jsonresponse.map((element){
        return UserCoursesList.fromJson(element);
      }).toList();

      return userCoursesList;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> CategoryListCall(String token) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=core_course_get_categories&moodlewsrestformat=json&wstoken=$token';

    final categoryListData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponsee_URL = " + fullUrl);
    print("userDetailsReponseeData = " + categoryListData.body);
    if (categoryListData.statusCode == 200) {
      final jsonresponse = jsonDecode(categoryListData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> categoryList = jsonresponse.map((element){
        return Categories.fromJson(element);
      }).toList();

      return categoryList;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> RecentCoursesListCall(String token, String userId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=core_course_get_recent_courses&moodlewsrestformat=json&wstoken=$token&userid=$userId';

    final recentCoursesListData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponsee_URL = " + fullUrl);
    print("userDetailsReponseeData = " + recentCoursesListData.body);
    if (recentCoursesListData.statusCode == 200) {
      final jsonresponse = jsonDecode(recentCoursesListData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> recentCoursesList = jsonresponse.map((element){
        return RecentCoursesList.fromJson(element);
      }).toList();

      return recentCoursesList;
    } else {
      return null;
    }
  }

  Future<CourseContent?> UserCourseContentCall(String token, courseId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?moodlewsrestformat=json&wstoken=$token&wsfunction=core_course_get_courses_by_field&field=id&value=$courseId';
    final userCourseContentData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponseeData_URL = " + fullUrl);
    print("userDetailsReponseeData = " + userCourseContentData.body);
    if (userCourseContentData.statusCode == 200) {
      return CourseContent.fromJson(jsonDecode(userCourseContentData.body));
    } else {
      return null;
    }
  }

  Future<AssignmentResponse?> CourseAssignmentCall(String token, String courseId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=mod_assign_get_assignments&moodlewsrestformat=json&wstoken=$token&courseids[0]=$courseId';
    final courseAssignmentData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponseeData_URL = " + fullUrl);
    print("userDetailsReponseeData = " + courseAssignmentData.body);
    if (courseAssignmentData.statusCode == 200) {
      return AssignmentResponse.fromJson(jsonDecode(courseAssignmentData.body));
    } else {
      return null;
    }
  }

  Future<NotificationResponse?> UserUnReadNotificationCall(String token, String userId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_message_get_messages&moodlewsrestformat=json&wstoken=$token&useridto=$userId&useridfrom=0&type=notifications&read=0&newestfirst=1&limitfrom=0';
    final unReadNotificationData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponseeData_URL = " + fullUrl);
    print("userDetailsReponseeData = " + unReadNotificationData.body);
    if (unReadNotificationData.statusCode == 200) {
      return NotificationResponse.fromJson(jsonDecode(unReadNotificationData.body));
    } else {
      return null;
    }
  }
  Future<NotificationResponse?> UserReadNotificationCall(String token, String userId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_message_get_messages&moodlewsrestformat=json&wstoken=$token&useridto=$userId&useridfrom=0&type=notifications&read=1&newestfirst=1&limitfrom=0';
    final readNotificationData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userDetailsReponseeData_URL = " + fullUrl);
    print("userDetailsReponseeData = " + readNotificationData.body);
    if (readNotificationData.statusCode == 200) {
      return NotificationResponse.fromJson(jsonDecode(readNotificationData.body));
    } else {
      return null;
    }
  }

  Future<GradeResponse?> GradesCountCall(String token) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=gradereport_overview_get_course_grades&moodlewsrestformat=json&wstoken=$token';
    final userGradeResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userGradeResponseData_URL = " + fullUrl);
    print("userGradeResponseData = " + userGradeResponseData.body);
    if (userGradeResponseData.statusCode == 200) {
      return GradeResponse.fromJson(jsonDecode(userGradeResponseData.body));
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> CourseContentCall(String token ,String courseId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_course_get_contents&moodlewsrestformat=json&wstoken=$token&courseid=$courseId';

    final courseContentResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("courseContentResponseDataReponsee_URL = " + fullUrl);
    print("courseContentResponseDataReponseeData = " + courseContentResponseData.body);
    if (courseContentResponseData.statusCode == 200) {
      final jsonresponse = jsonDecode(courseContentResponseData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> courseContentList = jsonresponse.map((element){
        return CourseContentResponse.fromJson(element);
      }).toList();

      return courseContentList;
    } else {
      return null;
    }
  }

  Future<GradeDetailsResponse?> GradesDetailsCall(String token, String courseid, String userId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=gradereport_user_get_grade_items&moodlewsrestformat=json&wstoken=$token&courseid=$courseid&userid=$userId';
    final userGradeDetailsData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userGradeDetailsData_URL = " + fullUrl);
    print("userGradeDetailsData = " + userGradeDetailsData.body);
    if (userGradeDetailsData.statusCode == 200) {
      return GradeDetailsResponse.fromJson(jsonDecode(userGradeDetailsData.body));
    } else {
      return null;
    }
  }

  Future<AssignmentDetailsReponse?> AssignmentDetailsCall(String token, String assignmentId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=mod_assign_get_submission_status&moodlewsrestformat=json&wstoken=$token&assignid=$assignmentId';
    final userGradeDetailsData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userGradeDetailsData_URL = " + fullUrl);
    print("userGradeDetailsData = " + userGradeDetailsData.body);
    if (userGradeDetailsData.statusCode == 200) {
      return AssignmentDetailsReponse.fromJson(jsonDecode(userGradeDetailsData.body));
    } else {
      return null;
    }
  }
  Future<List<dynamic>?> ProfileInfoCall(String token ,String userId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wstoken=$token&wsfunction=core_user_get_users_by_field&field=id&values[0]=$userId&moodlewsrestformat=json';

    final profileInfoResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("profileInfoResponseData_URL = " + fullUrl);
    print("profileInfoResponseDataData = " + profileInfoResponseData.body);
    if (profileInfoResponseData.statusCode == 200) {
      final jsonresponse = jsonDecode(profileInfoResponseData.body);
      List<dynamic> profileContentList = jsonresponse.map((element){
        return ProfileInfoResponse.fromJson(element);
      }).toList();

      return profileContentList;
    } else {
      return null;
    }
  }
  Future<StartQuizAttemptResponse?> StartQuizAttemptCall(String token, String quizId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wstoken=$token&wsfunction=mod_quiz_start_attempt&quizid=$quizId&moodlewsrestformat=json';
    final startQuizAttemptResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("StartQuizAttemptResponse_URL = " + fullUrl);
    print("StartQuizAttemptResponse = " + startQuizAttemptResponseData.body);
    if (startQuizAttemptResponseData.statusCode == 200) {
      return StartQuizAttemptResponse.fromJson(jsonDecode(startQuizAttemptResponseData.body));
    } else {
      return null;
    }
  }
  Future<QuizAttemptSummery?> QuizAttemptSummeryCall(String token, String quizId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wstoken=$token&wsfunction=mod_quiz_get_user_attempts&quizid=$quizId&moodlewsrestformat=json';
    final quizAttemptSummeryData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("quizAttemptSummeryData_URL = " + fullUrl);
    print("quizAttemptSummeryData = " + quizAttemptSummeryData.body);
    if (quizAttemptSummeryData.statusCode == 200) {
      return QuizAttemptSummery.fromJson(jsonDecode(quizAttemptSummeryData.body));
    } else {
      return null;
    }
  }

  Future<QuizQuestionResponse?> QuizQuestionCall(String token, String attemptId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wstoken=$token&wsfunction=mod_quiz_get_attempt_data&attemptid=$attemptId&moodlewsrestformat=json&page=0';
    final quizQuestionData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("quizQuestionData_URL = " + fullUrl);
    print("quizQuestionData = " + quizQuestionData.body);
    if (quizQuestionData.statusCode == 200) {
      return QuizQuestionResponse.fromJson(jsonDecode(quizQuestionData.body));
    } else {
      return null;
    }
  }

  Future<CalendarEventsResponse?> CalendarEventsCall(String token) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wstoken=$token&wsfunction=core_calendar_get_calendar_upcoming_view&moodlewsrestformat=json';
    final calenderEventsData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("calenderEventsData_URL = " + fullUrl);
    print("calenderEventsData = " + calenderEventsData.body);
    if (calenderEventsData.statusCode == 200) {
      return CalendarEventsResponse.fromJson(jsonDecode(calenderEventsData.body));
    } else {
      return null;
    }
  }
  Future<MonthlyCalendarEventsResponse?> MonthlyCalendarEventsCall(String token, String year, String month) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wstoken=$token&wsfunction=core_calendar_get_calendar_monthly_view&moodlewsrestformat=json&year=$year&month=$month';
    final monthlyCalenderEventsData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("calenderEventsData_URL = " + fullUrl);
    print("calenderEventsData = " + monthlyCalenderEventsData.body);
    if (monthlyCalenderEventsData.statusCode == 200) {
      return MonthlyCalendarEventsResponse.fromJson(jsonDecode(monthlyCalenderEventsData.body));
    } else {
      return null;
    }
  }
  Future<AllChatsHolderResponse?> ChatHolderListCall(String token, String userId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=core_message_get_conversations&moodlewsrestformat=json&wstoken=$token&userid=$userId';

    final chatHolderListData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("chatHolderListReponsee_URL = " + fullUrl);
    print("chatHolderListReponseeData = " + chatHolderListData.body);
    if (chatHolderListData.statusCode == 200) {
      return AllChatsHolderResponse.fromJson(jsonDecode(chatHolderListData.body));
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> ContactRequestCall(String token ,String userId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_message_get_contact_requests&moodlewsrestformat=json&wstoken=$token&userid=$userId';

    final ContactRequestData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("ContactRequestDataReponsee_URL = " + fullUrl);
    print("ContactRequestDataData = " + ContactRequestData.body);
    if (ContactRequestData.statusCode == 200) {
      final jsonresponse = jsonDecode(ContactRequestData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> contactRequestList = jsonresponse.map((element){
        return ContactRequestResponse.fromJson(element);
      }).toList();

      return contactRequestList;
    } else {
      return null;
    }
  }

  Future<GroupMessageResponse?> GroupMessageCall(String token , String userId, String convId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=core_message_get_conversation_messages&moodlewsrestformat=json&wstoken=$token&currentuserid=$userId&convid=$convId&newest=1';
    final groupMessageResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("groupMessageData_URL = " + fullUrl);
    print("groupMessageData_URL = " + groupMessageResponseData.body);
    if (groupMessageResponseData.statusCode == 200) {
      return GroupMessageResponse.fromJson(jsonDecode(groupMessageResponseData.body));
    } else {
      return null;
    }
  }

}
