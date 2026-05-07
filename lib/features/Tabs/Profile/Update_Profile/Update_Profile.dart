import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/core/models/user_model.dart';
import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/Tabs/Profile/Widgets/Custom_Elevated_Button.dart';
import 'package:recipes/features/Tabs/Profile/Widgets/Custom_Info_Preview.dart';

class UpdateProfile extends StatelessWidget {
   UpdateProfile({super.key});
  Icon Person_icon = Icon(Icons.person,color: ColorsManger.white,);
  Icon Phone_icon = Icon(Icons.phone,color: ColorsManger.white,);
  IconButton arrow_back = IconButton(
      onPressed: (){}, icon: Icon(Icons.arrow_back_rounded));
   late String Delete_text="Delete Account";
   late String Update_text="Update Data";
   late Color red_button = ColorsManger.red;
   late Color yellow_button = ColorsManger.yellow;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Avatar',
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: .w500),
        ),
        leading: arrow_back,
      ),


      backgroundColor: ColorsManger.black,


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
           Center(
             child: Padding(
               padding: EdgeInsets.all(35.sp),
               child: Image.asset(AssetsManger.avatarEight),
             ),
           ),
         InfoPreview(name: UserModel.currentUser!.name,icon: Person_icon,),
         InfoPreview(name:UserModel.currentUser!.phoneNumber,icon: Phone_icon,),
          SizedBox(height: 20.h,),
          Padding(
            padding:  EdgeInsets.only(left: 20.w),
            child: InkWell(
                onTap: (){},
                child: Text("Reset Password",style: GoogleFonts.roboto(color: ColorsManger.white,fontSize: 20,fontWeight: FontWeight.normal),)),
          ),
          Spacer(),
          CustomElevatedButton(text: Delete_text,color: red_button,),
          CustomElevatedButton(text: Update_text,color: yellow_button,text_color:ColorsManger.black,),
        ],
      ),
    );
  }
}
