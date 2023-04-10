import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/profile_model.dart';
import 'package:gas_station_merchant/models/update_profile_model.dart';
import 'package:gas_station_merchant/views/home/change_password.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gas_station_merchant/models/categories_model.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
// apis

const List<String> listF = <String>[
  'Daily',
  'Monthly',
  'Quarterly',
  'Yearly',
];
String? dropdownValueF;
class UpdateProfile extends StatefulWidget {
  Data userData;
  UpdateProfile({Key? key,required this.userData}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController mailingAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController federalController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  List<CategoriesData> categoriesList = [];
  List<int> allSelectedItems = [];
  List<String> allSelectedItems2 = [];
  List<int>? catIds = [];
  late String authToken;
  late String userId;
  List<String> categoryNamesStrList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullNameController.text = widget.userData.fullName!.isNotEmpty ? widget.userData.fullName! : "";
    emailController.text = widget.userData.email!.isNotEmpty ? widget.userData.email! : "";
    aboutController.text = widget.userData.about == null ? "" : widget.userData.about!.isNotEmpty ? widget.userData.about! : "";
    phoneController.text = widget.userData.mobileNumber!.isNotEmpty ? widget.userData.mobileNumber! : "";
    address1Controller.text = widget.userData.address1!.isNotEmpty ? widget.userData.address1! : "";
    address2controller.text = widget.userData.address2 == null ? "" : widget.userData.address2!.isNotEmpty ? widget.userData.address2! : "";
    mailingAddressController.text = widget.userData.mailingAddress == null ? "" : widget.userData.mailingAddress!.isNotEmpty ? widget.userData.mailingAddress! : "";
    federalController.text = widget.userData.federalIdentifyNum!.isNotEmpty ? widget.userData.federalIdentifyNum! : "";
    taxController.text = widget.userData.salesTaxIdentifyNum!.isNotEmpty ? widget.userData.salesTaxIdentifyNum! : "";
    categoriesApi(context);
    catIds!.addAll(widget.userData.categoryIds!.toList());
    // allSelectedItems.addAll(widget.userData.categoryIds!.toList());
    print('widget.userData.categoryIds is --------------$catIds');
    print('catIds is --------------${catIds!.length}');
    dropdownValueF = widget.userData.withdrawalFrequency;
    print("dropdownValueF is --------------$dropdownValueF");
    authToken = prefs.getString('authToken')!;
    userId = prefs.getString('userId')!;
    print('my auth token is >>>>> $authToken');
    print('my user id is >>>>> $userId');

    // setCategrynameComma();

    setState(() {});
  }

  // setCategrynameComma(){
  //   for(int i = 0; i < widget.userData.category!.length; i ++){
  //     categoryNamesStrList.add(widget.userData.category![i].name!);
  //   }
  //   print("categoryNamesStrList length --------${categoryNamesStrList.length}");
  //   categoryNames = categoryNamesStrList.toString().replaceAll("[", "").replaceAll("]", "");
  //   print("categoryNames is --------$categoryNames");
  //   categoriesController.text = categoryNames!;
  //   setState(() {
  //
  //   });
  // }

  isSelectedcategory(){

    for(int i = 0; i < categoriesList.length; i ++){
      print("method start----${categoriesList[i].id}");
      for(int j = 0; j < widget.userData.categoryIds!.length; j ++){
        if(categoriesList[i].id! == widget.userData.categoryIds![j]){
          categoriesList[i].isChecked = true;
          setState(() {});
          print("categoriesList[i].isChecked is ---${categoriesList[i].isChecked}");
        }
      }
    }
  }
  isSelectedcategoryNames(){

    for(int i = 0; i < categoriesList.length; i ++){
      print("method start----${categoriesList[i].id}");
      for(int j = 0; j < widget.userData.category!.length; j ++){
        if(categoriesList[i].name! == widget.userData.category![j].name){
          allSelectedItems2.add(widget.userData.category![j].name!);
          allSelectedItems.add(widget.userData.category![j].id!);
          String splitted = allSelectedItems2.toString().replaceAll('[', "").replaceAll(']', "");
          categoriesController.text = splitted;
          setState(() {});
          print("splitted is ---$splitted");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
              child: SvgPicture.asset('assets/icons/left.svg',color: Colors.white,),
            ),
          ),
          title: const Text('Profile',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: MediaQuery.of(context).size.width * 0.1,),
              TextFormField(
                controller: fullNameController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
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
                      fontSize: 15.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                maxLines: 5,
                controller: aboutController,
                // textAlign: TextAlign.start,
                // textAlignVertical: TextAlignVertical.top,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'About',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
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
                  fontSize: 12.0,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  categoryAlert(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              TextFormField(
                controller: address1Controller,
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
                  // labelText: 'Address Line 2 *',
                  labelText: 'Address Line 2',
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
                'Withdrawal Frequency',
                style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
              ),
              const SizedBox(height: 10.0),
              const DropdownButtonExampleF(),
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
                controller: federalController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Federal Identification Number',
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
                controller: taxController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Sales Tax Identification Number',
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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const ChangePassword(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text(
                    'Change Password?',
                    style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  updateProfileApi(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
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
                      itemCount: categoriesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final splitted = categorieslist[index].bg!.split('#');
                        // String color = '0xFF${splitted[1].toLowerCase()}';
                        final splitted = '#EEE9FF'.split('#');
                        String color = '0xFF${splitted[1].toLowerCase()}';
                        // if(catIds!.contains(categoriesList[index].id)){
                        //   // print("yes");
                        //   categoriesList[index].isChecked = true;
                        // }
                        return InkWell(
                          onTap: () {
                            if(categoriesList[index].isChecked == null || categoriesList[index].isChecked == false){
                              categoriesList[index].isChecked = true;
                              allSelectedItems.add(int.parse(categoriesList[index].id.toString()));
                              allSelectedItems2.add(categoriesList[index].name.toString());
                              String splitted = allSelectedItems2.toString().replaceAll('[', "").replaceAll(']', "");
                              categoriesController.text = splitted;
                            }else{
                              categoriesList[index].isChecked = false;
                              allSelectedItems.remove(categoriesList[index].id);
                              allSelectedItems2.remove(categoriesList[index].name);
                              String splitted = allSelectedItems2.toString().replaceAll('[', "").replaceAll(']', "");
                              categoriesController.text = splitted;
                            }
                            print('allSelectedItems<int> is ---------$allSelectedItems');
                            print('allSelectedItems2<String> is ---------$allSelectedItems2');
                            setState(() {});
                            print("allSelectedItems.length is ----------${allSelectedItems.length}");
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
                                        Image.network(
                                          categoriesList[index].icon.toString(),
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: categoriesList[index].isChecked == true ?
                                            Colors.black.withOpacity(0.2) :
                                            Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height,
                                          padding: const EdgeInsets.all(15.0),
                                          child: categoriesList[index].isChecked == true ?
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
                                    categoriesList[index].name.toString(),
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
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if(allSelectedItems.isEmpty){
                              Utilities().toast("Please select at least one category");
                            }else {
                              Navigator.of(context).pop();
                            }
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.15, 10, MediaQuery.of(context).size.width * 0.15, 0),
                            // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(Radius.circular(19.0)),
                            ),
                            child: const Text(
                              'Done',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
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
            );
          },
        );
      },
    );
  }
  // categoriesapi api
  Future<void> categoriesApi(BuildContext context) async {
    // Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.categoriesUrl),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-CLIENT" : Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    // Loader.progressLoadingDialog(context, false);
    CategoriesModel res = await CategoriesModel.fromJson(jsonResponse);
    if (res.status == true) {
      categoriesList = res.data!;
      setState(() {});
      isSelectedcategory();
      isSelectedcategoryNames();
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // categoriesapi api
  // resetPassApi
  Future<void> updateProfileApi(BuildContext context) async {
    List<int>? finalCatIds;
    if(allSelectedItems.isEmpty){
      finalCatIds = catIds;
    }else{
      finalCatIds = allSelectedItems;
    }
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['full_name'] = fullNameController.text;
    request['email'] = emailController.text;
    request['country_code'] = "1";
    request['about'] = aboutController.text;
    request['mobile_number'] = phoneController.text;
    request['category_ids'] = finalCatIds;
    request['address_1'] = address1Controller.text;
    request['withdrawal_frequency'] = dropdownValueF;
    request['mailing_address'] = mailingAddressController.text;
    request['federal_identify_num'] = federalController.text;
    request['sales_tax_identify_num'] = taxController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.updateProfile),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    UpdateProfileModel res = await UpdateProfileModel.fromJson(jsonResponse);
    if(res.status == true){
      Utilities().toast(res.message);
      Navigator.of(context).pop();
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // resetPassApi
}

class DropdownButtonExampleF extends StatefulWidget {
  const DropdownButtonExampleF({super.key});

  @override
  State<DropdownButtonExampleF> createState() => _DropdownButtonExampleFState();
}

class _DropdownButtonExampleFState extends State<DropdownButtonExampleF> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValueF,
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
          dropdownValueF = value!;
        });
        print(dropdownValueF);
      },
      items: listF.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
