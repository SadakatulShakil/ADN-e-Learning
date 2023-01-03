import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radda_moodle_learning/ApiModel/assignmentDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/badges_response.dart';
import 'package:radda_moodle_learning/ApiModel/calendar_events_response.dart';
import 'package:radda_moodle_learning/ApiModel/contact_request_response.dart';
import 'package:radda_moodle_learning/ApiModel/eventCreateResponse.dart';
import 'package:radda_moodle_learning/ApiModel/gradeDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/group_message_response.dart';
import 'package:radda_moodle_learning/ApiModel/quizAccessInformation.dart';
import 'package:radda_moodle_learning/ApiModel/quiz_attempt_summery.dart';
import 'package:radda_moodle_learning/ApiModel/quiz_question_response.dart';
import 'package:radda_moodle_learning/ApiModel/quiz_submit_response.dart';
import 'package:radda_moodle_learning/ApiModel/start_quiz_attempt_response.dart';
import '../ApiModel/View_Notification.dart';
import '../ApiModel/allChatsHolderResponse.dart';
import '../ApiModel/assignmentResponse.dart';
import '../ApiModel/categoryResponse.dart';
import '../ApiModel/contactsListReponse.dart';
import '../ApiModel/courseContentResponse.dart';
import '../ApiModel/courseDetailsReponse.dart';
import '../ApiModel/gradeResponse.dart';
import '../ApiModel/loginResponse.dart';
import '../ApiModel/monthly_calendar_response.dart';
import '../ApiModel/notificationResponse.dart';
import '../ApiModel/profileInfoResponse.dart';
import '../ApiModel/profileResponse.dart';
import '../ApiModel/recentCoursesResponse.dart';
import '../ApiModel/search_response.dart';
import '../ApiModel/userCoursesList.dart';
import '../ApiModel/userDetailsResponse.dart';

class NetworkCall {
  final String baseUrl = "https://diginet-elearning.adnarchive.com/";//"https://www.raddaelearning.org/";
  final String loginUrl = "https://diginet-elearning.adnarchive.com/login/token.php?service=mobile_app_webservices&moodlewsrestformat=json&";//"https://www.raddaelearning.org/login/token.php?service=moodle_mobile_app&moodlewsrestformat=json&";
  final String apiKey = "cStSLnzMq2fo5LARbLAUiULslVJiWFRCkqwN6VsK7Xg6m19h3WgwWBv23eer8kl7DIEh";

  Future<LoginReponse?> LoginCall(String username, String password) async {
    String en_password = Uri.encodeComponent(password);
    String fullUrl = loginUrl+'username=$username&password=$en_password';
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
  Future<List<dynamic>?> UserSearchCall(String token ,String searchText) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_message_search_contacts&moodlewsrestformat=json&wstoken=$token&searchtext=$searchText';

    final userSearchData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("userSearchData_URL = " + fullUrl);
    print("userSearchData = " + userSearchData.body);
    if (userSearchData.statusCode == 200) {
      final jsonresponse = jsonDecode(userSearchData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> userSearchList = jsonresponse.map((element){
        return SearchUsersResponse.fromJson(element);
      }).toList();

      return userSearchList;
    } else {
      return null;
    }
  }

  Future<BadgesResponse?> BadgesResponseCall(String token, String userId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=core_badges_get_user_badges&moodlewsrestformat=json&userid=$userId&wstoken=$token';
    final userGradeResponseData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("BadgesResponse_URL = " + fullUrl);
    print("BadgesResponseData = " + userGradeResponseData.body);
    if (userGradeResponseData.statusCode == 200) {
      return BadgesResponse.fromJson(jsonDecode(userGradeResponseData.body));
    } else {
      return null;
    }
  }

  Future<dynamic> VideoUrlCall(String token, String url) async {
    String fullUrl = '$url&token=$token';
    final VideoUrlCallData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("BadgesResponse_URL = " + fullUrl);
    print("BadgesResponseData = " + VideoUrlCallData.body);
    if (VideoUrlCallData.statusCode == 200) {
      return VideoUrlCallData.body;
    } else {
      return null;
    }
  }
  Future<dynamic> SendMessageCall(String token, String message, String receiverId) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wsfunction=core_message_send_instant_messages&moodlewsrestformat=json&wstoken=$token&messages[0][touserid]=$receiverId&messages[0][text]=$message&messages[0][textformat]=0';
    final SendMessageData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("SendMessageData_URL = " + fullUrl);
    print("SendMessageData = " + SendMessageData.body);
    if (SendMessageData.statusCode == 200) {
      return SendMessageData.body;
    } else {
      return null;
    }
  }

  Future<dynamic> SendGroupMessageCall(String token, String message, String conversationId) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wstoken=$token&wsfunction=core_message_send_messages_to_conversation&conversationid=$conversationId&moodlewsrestformat=json&messages[0][text]=$message&messages[0][textformat]=0';
    final SendGroupMessageData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("SendGroupMessageData_URL = " + fullUrl);
    print("SendGroupMessageData = " + SendGroupMessageData.body);
    if (SendGroupMessageData.statusCode == 200) {
      return SendGroupMessageData.body;
    } else {
      return null;
    }
  }


  Future<dynamic> ResetPasswordMailCall(String token, String email) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wsfunction=core_auth_request_password_reset&moodlewsrestformat=json&wstoken=$token&email=$email';
    final ResetPasswordMailData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("ResetPasswordMailCall_URL = " + fullUrl);
    print("ResetPasswordMailData = " + ResetPasswordMailData.body);
    if (ResetPasswordMailData.statusCode == 200) {
      return ResetPasswordMailData.body;
    } else {
      return null;
    }
  }

  Future<dynamic> activityViewCall(String token, String pageId) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wsfunction=mod_page_view_page&moodlewsrestformat=json&wstoken=$token&pageid=$pageId';
    final activityViewCallData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("activityViewCall_URL = " + fullUrl);
    print("activityViewCallData = " + activityViewCallData.body);
    if (activityViewCallData.statusCode == 200) {
      return activityViewCallData.body;
    } else {
      return null;
    }
  }

  Future<QuizAccessInformation?> QuizAccessInformationCall(String token, String quizId) async {
    String fullUrl = baseUrl+'/webservice/rest/server.php?wsfunction=mod_quiz_get_quiz_access_information&quizid=$quizId&moodlewsrestformat=json&wstoken=$token';
    final quizAccessInformationData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("quizAccessInformationData_URL = " + fullUrl);
    print("quizAccessInformationDataData = " + quizAccessInformationData.body);
    if (quizAccessInformationData.statusCode == 200) {
      return QuizAccessInformation.fromJson(jsonDecode(quizAccessInformationData.body));
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> ContactsListCall(String token ,String userid) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_message_get_user_contacts&moodlewsrestformat=json&wstoken=$token&userid=$userid';

    final contactsData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("contactsData_URL = " + fullUrl);
    print("contactsData = " + contactsData.body);
    if (contactsData.statusCode == 200) {
      final jsonresponse = jsonDecode(contactsData.body);
      //print("Courses------------>"+ jsonresponse['courses'].toString());
      List<dynamic> contactsDataList = jsonresponse.map((element){
        return ContactsList.fromJson(element);
      }).toList();

      return contactsDataList;
    } else {
      return null;
    }
  }
  Future<dynamic> ContactRequestAcceptCall(String token, String currentId, String requestedUserId) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wsfunction=core_message_confirm_contact_request&moodlewsrestformat=json&wstoken=$token&userid=$requestedUserId&requesteduserid=$currentId';
    final contactRequestAcceptData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("ResetPasswordMailCall_URL = " + fullUrl);
    print("ResetPasswordMailData = " + contactRequestAcceptData.body);
    if (contactRequestAcceptData.statusCode == 200) {
      return contactRequestAcceptData.body;
    } else {
      return null;
    }
  }
  Future<dynamic> ContactRequestDeclineCall(String token, String currentId, String requestedUserId) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wsfunction=core_message_decline_contact_request&moodlewsrestformat=json&wstoken=$token&userid=$requestedUserId&requesteduserid=$currentId';
    final contactRequestDeclineData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("ResetPasswordMailCall_URL = " + fullUrl);
    print("ResetPasswordMailData = " + contactRequestDeclineData.body);
    if (contactRequestDeclineData.statusCode == 200) {
      return contactRequestDeclineData.body;
    } else {
      return null;
    }
  }

  Future<dynamic> CreateContactRequestCall(String token, String currentId, String requestedUserId) async {
    String fullUrl = '$baseUrl/webservice/rest/server.php?wsfunction=core_message_create_contact_request&moodlewsrestformat=json&wstoken=$token&userid=$requestedUserId&requesteduserid=$currentId';
    final CreateContactRequestData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("ResetPasswordMailCall_URL = " + fullUrl);
    print("ResetPasswordMailData = " + CreateContactRequestData.body);
    if (CreateContactRequestData.statusCode == 200) {
      return CreateContactRequestData.body;
    } else {
      return null;
    }
  }

  Future<QuizSubmitResponse?> QuizSubmitCall(String token, String userId) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=mod_quiz_process_attempt&moodlewsrestformat=json&wstoken=85c57d2af41859b8d651de98ce1fba07&attemptid=493&data[0][name]=q521:1_choice3&data[0][value]=1&data[1][name]=q521:2_choice1&data[1][value]=1&data[2][name]=q521:3_choice1&data[2][value]=1&data[3][name]=q521:4_choice1&data[3][value]=1&data[4][name]=q521:5_answer&data[4][value]=1';

    final QuizSubmitData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("QuizSubmitData_URL = " + fullUrl);
    print("QuizSubmitDataData = " + QuizSubmitData.body);
    if (QuizSubmitData.statusCode == 200) {
      return QuizSubmitResponse.fromJson(jsonDecode(QuizSubmitData.body));
    } else {
      return null;
    }
  }

  Future<EventCreateResponse?> EventCreateCall(String token, String name, String description, String timestart, String format, String timeduration, String visible, String sequence, String courseid, String groupid, String eventtype) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_calendar_create_calendar_events&moodlewsrestformat=json&wstoken=$token&events[0][name]=$name&events[0][description]=$description&events[0][timestart]=$timestart&events[0][format]=$format&events[0][timeduration]=$timeduration&events[0][visible]=$visible&events[0][sequence]=$sequence&events[0][courseid]=$courseid&events[0][groupid]=$groupid&events[0][eventtype]=$eventtype';

    final EventCreateData = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("EventCreateData_URL = " + fullUrl);
    print("EventCreateData = " + EventCreateData.body);
    if (EventCreateData.statusCode == 200) {
      return EventCreateResponse.fromJson(jsonDecode(EventCreateData.body));
    } else {
      return null;
    }
  }
  Future<ViewNotificationResponse?> ViewNotificationCall(String token, String notificationid) async {
    String fullUrl = baseUrl+'webservice/rest/server.php?wsfunction=core_message_mark_notification_read&moodlewsrestformat=json&wstoken=$token&notificationid=$notificationid';

    final ViewNotificationCall = await http.get(Uri.parse(fullUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },);
    print("EventCreateData_URL = " + fullUrl);
    print("EventCreateData = " + ViewNotificationCall.body);
    if (ViewNotificationCall.statusCode == 200) {
      return ViewNotificationResponse.fromJson(jsonDecode(ViewNotificationCall.body));
    } else {
      return null;
    }
  }

}
