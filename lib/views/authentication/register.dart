import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/authentication/login.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
const List<String> list = <String>[
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming',
];
/*Alabama,
Alaska,
Arizona,
Arkansas,
California,
Colorado,
Connecticut,
Delaware,
Florida,
Georgia,
Hawaii,
Idaho,
Illinois,
Indiana,
Iowa,
Kansas,
Kentucky,
Louisiana,
Maine,
Maryland,
Massachusetts,
Michigan,
Minnesota,
Mississippi,
Missouri,
Montana,
Nebraska,
Nevada,
New Hampshire,
New Jersey,
New Mexico,
New York,
North Carolina,
North Dakota,
Ohio,
Oklahoma,
Oregon,
Pennsylvania,
Rhode Island,
South Carolina,
South Dakota,
Tennessee,
Texas,
Utah,
Vermont,
Virginia,
Washington,
West Virginia,
Wisconsin,
Wyoming,*/
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address1controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController mailingAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  bool _isHidden = false;
  bool _isHidden2 = false;
  bool _isChecked = false;
  List<Categories> categorieslist = [
    Categories(icon: 'assets/icons/gas_station2.svg', name: 'Gas Staion', bg: '#EEE9FF',isChecked: false),
    Categories(icon: 'assets/icons/health_and_fitness.svg', name: 'Health & Fitness', bg: '#FFE5DA',isChecked: false),
    Categories(icon: 'assets/icons/lifestyle.svg', name: 'Lifestyle', bg: '#F5FFD9',isChecked: false),
    Categories(icon: 'assets/icons/restaurant.svg', name: 'Restaurant', bg: '#D9FFDD',isChecked: false),
    Categories(icon: 'assets/icons/shopping.svg', name: 'Shopping', bg: '#FCD9FF',isChecked: false),
  ];
  List<String> allSelectedItems = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1,bottom: 10.0),
                alignment: Alignment.center,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/profile.png',
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              'assets/icons/camera.svg',
                              height: 15.0,
                              width: 15.0,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                controller: nameController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: phoneController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Select Category',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  categoryAlert(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*Text(
                      allSelectedItems.toString().replaceAll('[', '').replaceAll(']', ''),
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 16.0
                      ),
                    ),*/
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () => categoryAlert(context),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: TextFormField(
                          controller: categoriesController,
                          cursorColor: AppColors.primary,
                          readOnly: true,
                          onTap: () => categoryAlert(context),
                          decoration: InputDecoration(
                            hintText: 'Select Category',
                            hintStyle: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0
                            ),
                            labelStyle: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0
                            ),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(
                        'assets/icons/right.svg'
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10.0),
              const Divider(
                thickness: 0.2,
                color: AppColors.secondary,
              ),
              TextFormField(
                controller: address1controller,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  labelText: 'Address Line 1 *',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: address2controller,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  labelText: 'Address Line 2 *',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: cityController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  labelText: 'City *',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'State',
                style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
              ),
              const SizedBox(height: 10.0),
              const DropdownButtonExample(),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: mailingAddressController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  labelText: 'Mailing Address',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                obscureText: _isHidden == true ? true : false,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                  suffixIcon: InkWell(
                    onTap: () {
                      _isHidden = !_isHidden;
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _isHidden == false
                        ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                        : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: cPasswordController,
                obscureText: _isHidden2 == true ? true : false,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                  suffixIcon: InkWell(
                    onTap: () {
                      _isHidden2 = !_isHidden2;
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _isHidden2 == false
                        ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                        : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      child: _isChecked == true ?
                      SvgPicture.asset('assets/icons/checked.svg') :
                      SvgPicture.asset('assets/icons/uncheck.svg'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'I Agree to ',style: TextStyle(color: AppColors.black)),
                        TextSpan(
                            text: 'Terms of Services',
                            style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () => registerAlert(context),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Already have an account? ',style: TextStyle(color: AppColors.black)),
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(color: AppColors.primary)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void categoryAlert(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
              backgroundColor: AppColors.white,
              title: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Select your category',
                      style: TextStyle(color: AppColors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2/2,
                        childAspectRatio: 8/9,
                      ),
                      itemCount: categorieslist.length,
                      itemBuilder: (BuildContext context, int index) {
                        final splitted = categorieslist[index].bg!.split('#');
                        String color = '0xFF${splitted[1].toLowerCase()}';
                        return InkWell(
                          onTap: () {
                            categorieslist[index].isChecked = !categorieslist[index].isChecked;
                            if(categorieslist[index].isChecked == true){
                              allSelectedItems.add(categorieslist[index].name.toString());
                              String splitted = allSelectedItems.toString().replaceAll('[', '').replaceAll(']', '');
                              categoriesController.text = splitted;
                            }else{
                              allSelectedItems.remove(categorieslist[index].name.toString());
                              String splitted = allSelectedItems.toString().replaceAll('[', '').replaceAll(']', '');
                              categoriesController.text = splitted;
                            }
                            setState(() {});
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     type: PageTransitionType.rightToLeftWithFade,
                            //     alignment: Alignment.topCenter,
                            //     duration: const Duration(milliseconds: 1000),
                            //     isIos: true,
                            //     child: const Vendors(),
                            //   ),
                            // );
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Padding(
                            padding:  const EdgeInsets.only(top: 0.0,bottom: 0.0,/*right: 5.0,left: 5.0,*/),
                            child: Container(
                              height: 170.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    // padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color:  Color(int.parse(color)),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          categorieslist[index].icon.toString(),
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: categorieslist[index].isChecked == true ?
                                            Colors.black.withOpacity(0.2) :
                                            Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height,
                                          padding: const EdgeInsets.all(15.0),
                                          child: categorieslist[index].isChecked == true ?
                                          SvgPicture.asset(
                                            'assets/icons/right_tick.svg',
                                            width: 30.0,
                                            height: 30.0,
                                            fit: BoxFit.contain,
                                          ) : Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Text(
                                    categorieslist[index].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Future registerAlert(context) {
    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: MediaQuery.of(context).size.height * 0.18),
        content: Container(
          // padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/success.svg',height: 120.0,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Congratulation',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              const Text(
                'You have successfully changed your password',
                style: TextStyle(
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
                // maxLines: 3,
                // overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 1000),
                            isIos: true,
                            child: const Login(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                        ),
                        child: const Text(
                          'OK',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Categories{
  String? icon;
  String? name;
  String? bg;
  bool isChecked = false;
  Categories({required this.icon,required this.name,required this.bg,required this.isChecked});
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: SvgPicture.asset('assets/icons/down.svg',width: 20.0),
      elevation: 16,
      style: const TextStyle(color: AppColors.black,fontSize: 16.0,fontFamily: 'Poppins'),
      underline: Container(
        height: 1,
        color: AppColors.border,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
