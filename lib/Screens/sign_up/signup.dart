import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:post_app/Screens/sign_up/select_hotel_name.dart';
import 'package:post_app/models/user.dart';
import 'package:post_app/Screens/example/general_widget.dart';
import 'package:post_app/Screens/example/global_method.dart';

// UserDetails user = UserDetails();

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
UserDetails user = UserDetails();

class _SignUpState extends State<SignUp> {
  late TextEditingController emailC = TextEditingController(text: hotelC.text);
  late TextEditingController passwordC = TextEditingController();
  late TextEditingController nameC = TextEditingController();
  late TextEditingController positionC = TextEditingController();
  late TextEditingController locationC = TextEditingController();
  late TextEditingController hotelC = TextEditingController();
  late TextEditingController dept = TextEditingController();
  // @override
  // void dispose() {
  //   emailC.dispose();
  //   passwordC.dispose();
  //   nameC.dispose();
  //   positionC.dispose();
  //   locationC.dispose();
  //   super.dispose();
  // }

  String hotelName = 'Choose Hotel Name';
  String hotelid = '';

  final RxMap<String, dynamic> _hotel =
      {'hotelName': 'Choose Hotel Name', 'hotelid': ''}.obs;
  // ignore: invalid_use_of_protected_member
  Map<String, dynamic> get hotel => _hotel.value;
  void setHotel(Map<String, dynamic> newData) => _hotel.value = newData;

  final validation = GlobalKey<FormState>();

  void validator() async {
    final isValid = validation.currentState!.validate();
    print(isValid);
    try {
      if (isValid) {
        setState(() {
          isLoading = true;
        });
        await auth.createUserWithEmailAndPassword(
            email: emailC.text.trim().toLowerCase(),
            password: passwordC.text.trim());
        FirebaseFirestore.instance.collection('users').doc(emailC.text).set({
          "name": nameC.text,
          "position": positionC.text,
          "hotelid": hotelid,
          "department": dept.text,
          "hotel": hotelName,
          "location": locationC.text,
          "email": emailC.text,
          "uid": auth.currentUser!.email,
          "acceptRequest": 0,
          "closeRequest": 0,
          "createRequest": 0,
          'ReceiveNotifWhenAccepted': true,
          'ReceiveNotifWhenClose': true,
          'isOnDuty': true,
          'token': [],
          "profileImage": "",
          "createdAt": DateTime.now()
        });
        Get.snackbar('Register', 'Register New Account Has Succeed');
        // Get.to(() => SignIn(), transition: Transition.leftToRight);

        final CollectionReference userData = FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(hotelC.text)
            .collection(dept.text)
            .doc(dept.text)
            .collection(nameC.text);
        final userData2 = await userData.doc(auth.currentUser!.email).get();
        final userData3 = userData2.data() as Map<String, dynamic>;

        user = UserDetails(
          email: userData3['email'],
          name: userData3['name'],
          position: userData3['position'],
          department: userData3['department'],
          hotel: userData3['hotel'],
          location: userData3['location'],
          receiveNotifWhenAccepted: userData3['receiveNotifWhenAccepted'],
          profileImage: userData3['imageProfile'],
        );
      }
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          isLoading = false;
        });
        print('The account already exists for that email.');
        GlobalMethod.showErrorDialog(
            error: "The account already exists for that email.", ctx: context);
        emailC.clear();
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  bool isObsecure = true;
  bool isLoading = false;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(),
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Register New Account",
                            style: TextStyle(fontSize: 35, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Already have an account?",
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Sign in Here",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: validation,
                          child: Column(
                            children: [
                              form(
                                  nameC,
                                  'Name',
                                  Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  TextInputType.name),
                              form(
                                  positionC,
                                  'Position',
                                  Icon(
                                    Icons.star,
                                    color: primaryColor,
                                  ),
                                  TextInputType.text),
                              form(
                                  dept,
                                  'Department',
                                  Icon(
                                    Icons.approval,
                                    color: primaryColor,
                                  ),
                                  TextInputType.text),
                              form(
                                  locationC,
                                  'Location',
                                  Icon(
                                    Icons.pin_drop,
                                    color: primaryColor,
                                  ),
                                  TextInputType.streetAddress),
                              form(
                                  emailC,
                                  'Email',
                                  Icon(
                                    Icons.message,
                                    color: primaryColor,
                                  ),
                                  TextInputType.emailAddress),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      controller: passwordC,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 5) {
                                          return "Please enter a valid password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: isObsecure,
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: primaryColor,
                                          ),
                                          errorBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "Password"),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObsecure = !isObsecure;
                                      });
                                    },
                                    child: isObsecure
                                        ? Icon(Icons.visibility_off_rounded,
                                            color: primaryColor)
                                        : Icon(Icons.visibility,
                                            color: primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              InkWell(
                                onTap: () async {
                                  Map<String, dynamic>? result = await Get.to(
                                      () => SelectHotelName(),
                                      transition: Transition.rightToLeft);
                                  if (result != null) {
                                    // setHotel(result);
                                    // _hotel.value = result;
                                    setState(() {
                                      hotelName = result['hotelName'];
                                      hotelid = result['hotelid'];
                                    });
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     PageTransition(
                                  //         child: SelectHotelName(),
                                  //         type:
                                  //             PageTransitionType.rightToLeft));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey.shade200,
                                        alignment: Alignment.center,
                                        height: size.height * 0.050,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(hotelName)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              GeneralButton(
                                buttonName: 'Sign Up',
                                height: size.height * 0.020,
                                primary: primaryColor,
                                onPressed: () {
                                  validator();
                                },
                                colorText: Colors.white,
                                widht: 150,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
