import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:logger/logger.dart';

class TextFieldChatBotMessage extends StatefulWidget {
  const TextFieldChatBotMessage({super.key});

  @override
  _TextFieldChatBotMessageState createState() =>
      _TextFieldChatBotMessageState();
}

class _TextFieldChatBotMessageState extends State<TextFieldChatBotMessage> {
  final TextEditingController _controller = TextEditingController();
  final Logger logger = Logger();

  void _onSend() {
    if (_controller.text.trim().isNotEmpty) {
      logger.d("ChatBot: ${_controller.text}");
      _controller.clear();
      FocusScope.of(context).unfocus(); // 키패드 내리기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: secondaryBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '메시지 입력',
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: mainGrey,
                fontSize: 16,
              ),
              onEditingComplete: _onSend, // 키패드 완료 버튼 눌렀을 때 호출
            ),
          ),
          GestureDetector(
            onTap: _onSend, // 이미지 클릭 시 호출
            child: SvgPicture.asset(
              'assets/image/icon_arrow_up.svg',
              width: 34,
              height: 34,
            ),
          ),
        ],
      ),
    );
  }
}