import 'package:flutter/material.dart';
import 'package:jamesboard/theme/Colors.dart';
import '../../../widget/image/ImageCommonUserCircle.dart';

class ChatBubbleChatBot extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;
  final String? imageUrl;

  const ChatBubbleChatBot({
    Key? key,
    required this.message,
    required this.isMe,
    required this.time,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // 상대방 프로필 & 이름 (상대 채팅일 경우만)
        if (!isMe) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageCommonUserCircle(imageUrl: 'assets/image/icon_agent_q.png'),
              const SizedBox(width: 8),
              const Text(
                'Q',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'PretendardBold',
                  color: mainWhite,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4), // 이름과 메시지 간격
        ],

        // 메시지 + 이미지 + 시간
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end, // 챗 버블과 시간을 하단 정렬
          children: [
            if (!isMe) const SizedBox(width: 38), // 상대방 메시지일 때 프로필 공간 확보
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // 이미지가 있는 경우
                  if (imageUrl != null)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  // 메시지 버블 + 시간
                  Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end, // 시간을 하단에 배치
                    children: [
                      // 내 채팅인 경우 시간 먼저, 메시지 버블 나중
                      if (isMe) ...[
                        // 시간 텍스트 먼저 표시
                        Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 4), // 여백 조정
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 12,
                              color: mainGrey,
                              fontFamily: 'PretendardBold',
                            ),
                          ),
                        ),
                        // 메시지 버블
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isMe ? mainGrey : secondaryBlack,
                            borderRadius: BorderRadius.only(
                              topLeft: isMe ? const Radius.circular(10) : Radius.zero,
                              topRight: isMe ? Radius.zero : const Radius.circular(10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            message,
                            style: TextStyle(
                              color: mainWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                      // 상대방 채팅일 때 시간 텍스트 후에 메시지 버블
                      if (!isMe) ...[
                        // 메시지 버블
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isMe ? mainGrey : secondaryBlack,
                            borderRadius: BorderRadius.only(
                              topLeft: isMe ? const Radius.circular(10) : Radius.zero,
                              topRight: isMe ? Radius.zero : const Radius.circular(10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            message,
                            style: TextStyle(
                              color: mainWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // 시간 텍스트 나중에 표시
                        Align(
                          alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft, // 하단 정렬
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4), // 여백 조정
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 12,
                                color: mainGrey,
                                fontFamily: 'PretendardBold',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
