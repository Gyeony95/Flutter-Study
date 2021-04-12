import 'package:flutter/material.dart';
import 'package:gh_toy/post/post_screen.dart';
import 'package:gh_toy/widget/common_button.dart';
import 'package:gh_toy/widget/common_text_form_field.dart';


class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {


  final _idFocusNode = FocusNode();
  final _pwFocusNode = FocusNode();

  TextEditingController _idTextEditingController;
  TextEditingController _pwTextEditingController;


  @override
  void initState() {
    super.initState();
    _idTextEditingController = TextEditingController()
      ..addListener(
              () {}
      );
    _pwTextEditingController = TextEditingController()
      ..addListener(
              () {}
      );

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextFormField(
          labelText: '아이디',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff5b5b5b),
          ),
          hintText: '아이디를 입력해주세요.',
          hintStyle: TextStyle(
            color: Color(0x66000000),
          ),
          isClearButtonEnabled: false,
          focusNode: _idFocusNode,
          controller: _idTextEditingController,
          textInputAction: TextInputAction.next,
          maxLength: 20,
          keyboardType: TextInputType.number,
          validator: (phoneNo) => phoneNo.isEmpty
              ? '아이디를 확인해주세요아이디'
              : null,
          onEditingComplete: () =>
              FocusScope.of(context)
                  .requestFocus(_idFocusNode),
        ),
        SizedBox(
          height: 10,
        ),
        CommonTextFormField(
          labelText: '비밀번호',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff5b5b5b),
          ),
          hintText: '비밀번호를 입력해주세요.',
          hintStyle: TextStyle(
            color: Color(0x66000000),
          ),
          isClearButtonEnabled: false,
          focusNode: _pwFocusNode,
          controller: _pwTextEditingController,
          textInputAction: TextInputAction.next,
          maxLength: 20,
          keyboardType: TextInputType.number,
          validator: (phoneNo) => phoneNo.isEmpty
              ? '비밀번호를 확인해주세요'
              : null,
          onEditingComplete: () =>
              FocusScope.of(context)
                  .requestFocus(_pwFocusNode),
        ),
        SizedBox(
          height: 10,
        ),
        CommonButton(
          text: '로그인',
          onPressed: (){
            Navigator.pushNamed(
                context, PostScreen.routeName);
          },
        )

      ],
    );
  }
}
