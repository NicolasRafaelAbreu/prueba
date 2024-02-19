final LoginController loginController = Get.put(LoginController());




class LoginController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  // final carService = Get.find<CarService>();
  // final appraiserService = Get.find<AppraiserService>();
  //final appraiserController = Get.put(AppraiserController());
  String email = '';
  String password = '';
  String newPassword = '';
  String code = '';

  Future<bool> login() async {
    return await authService.login(email, password);
  }

  Future<bool> requestCode() async {
    return await authService.requestCode(email);
  }

  // Future setUpApp() async {
  //   await carService.getMarcas();
  //   await appraiserService.getCarsByStateId('1');
  // }
}





class AuthService extends GetxService {
  late User user;

  final box = GetStorage('User');

  Future<AuthService> init() async {
    return this;
  }

  Future<bool> login(String email, String password) async {
    final NotificationService notificationService = Get.find<NotificationService>();

    // try {
    final Uri url = Uri.parse('${Urls.baseUrl}/auth/login');

    var body = {'email': email, 'password': password};
    var response = await http.post(url, body: body);
    debugPrint('respone: $response');
    debugPrint('response body: ${response.body}');
    if (response.statusCode == 200) {
      user = userFromJson(response.body);
      box.write('user', response.body);
      box.write('token', user.token);
      await notificationService.firebaseHandleSubscribe();
      return true;
    } else {
      return false;
    }
    // } catch (e) {
    //   return false;
    // }
  }

  UserClass loadUser() {
    user = userFromJson(box.read('user'));
    return user.userData;
  }

  Future<bool> requestCode(String email) async {
    try {
      final Uri url = Uri.parse('${Urls.baseUrl}/auth/recover_password');

      var body = {'email': email};
      var response = await http.post(url, body: body);
      debugPrint('respone: $response');
      debugPrint('response body: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getPasswordToken(String email) async {
    try {
      final Uri url = Uri.parse('${Urls.baseUrl}/users/recover_password/email?email=$email');

      var response = await http.get(url);
      debugPrint('respone: $response');
      debugPrint('response body: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassword(String email, String password) async {
    try {
      final Uri url = Uri.parse('${Urls.baseUrl}/users/change_password');

      var body = {
        'email': email,
        'password': password,
      };
      var response = await http.post(url, body: body);
      debugPrint('respone: $response');
      debugPrint('response body: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(Map<String, dynamic> body) async {
    try {
      final Uri url = Uri.parse('${Urls.baseUrl}/users/register');

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      debugPrint('body: $body');
      debugPrint('headers: ${json.encode(body)}');
      var response = await http.post(url, headers: headers, body: json.encode(body));
      debugPrint('response body: ${response.body}');
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('error: $e');
      return false;
    }
  }

  Future<bool> deleteAccount(String userId) async {
    String token = box.read('token');

    try {
      final Uri url = Uri.parse('${Urls.baseUrl}/users/delete/$userId');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var response = await http.delete(url, headers: headers);
      debugPrint('response body: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('error: $e');
      return false;
    }
  }

  // bool userPermissions(String name) {
  //   for (int i = 0; i < user.roleId.permissions.length; i++) {
  //     if (user.roleId.permissions[i].name == name) return true;
  //   }
  //   return false;
  // }

  // Future<(bool, List<SellerUser>)> getSellerList() async {
  //   String token = box.read('token');

  //   try {
  //     final Uri url = Uri.parse('${Urls.baseUrl}/users/seller_by_company');

  //     Map<String, String> headers = {
  //       'Authorization': 'Bearer $token',
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //     };

  //     var response = await http.get(url, headers: headers);
  //     debugPrint('response body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       List<SellerUser> listSellerUser = sellerUserFromJson(response.body);
  //       return (true, listSellerUser);
  //     } else {
  //       return (false, <SellerUser>[]);
  //     }
  //   } catch (e) {
  //     debugPrint('error: $e');
  //     return (false, <SellerUser>[]);
  //   }
  // }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // Even if the cell phone rotates, keep the app vertical
  await initialConfig(); ->> aca va la funcion
  runApp(const MainApp());
}

Future<void> initialConfig() async {
  await Get.putAsync(() => AuthService().init());
}
