import 'package:flutter/material.dart';
import '../constants.dart' show AppColors,AppStyles,Constants;
import '../model/Conversation.dart' show mockConversations,Conversation;

class _ConversationItem extends StatelessWidget {
   _ConversationItem({Key key,this.conversation})
      : assert(conversation != null ),
      super(key: key);

  final Conversation conversation;
  var tapPos;

  _showMenu(BuildContext context, Offset tapPos) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromLTRB(tapPos.dx, tapPos.dy,
        overlay.size.width - tapPos.dx, overlay.size.height - tapPos.dy);
    showMenu<String>(
        context: context,
        position: position,
        items: <PopupMenuItem<String>>[
          PopupMenuItem(
            child: Text(Constants.MENU_MARK_AS_UNREAD_VALUE),
            value: Constants.MENU_MARK_AS_UNREAD,
          ),
          PopupMenuItem(
            child: Text(Constants.MENU_PIN_TO_TOP_VALUE),
            value: Constants.MENU_PIN_TO_TOP,
          ),
          PopupMenuItem(
            child: Text(Constants.MENU_DELETE_CONVERSATION_VALUE),
            value: Constants.MENU_DELETE_CONVERSATION,
          ),
        ]).then<String>((String selected) {
      switch (selected) {
        default:
          print('当前选中的是：$selected');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget avatar;//根据网络或本地获取头像图片widget
    Widget unreadMsgCountText ;//未读消息的小圆标widget
    Widget avatarContainer ;//将头像图片和小圆标放在一起的widget
    Widget muteIcon;//勿扰模式图标
    if(conversation.isAvatarFromNet()){
      avatar = Image.network(conversation.avatar,width: Constants.ConversationAvatarSize,height: Constants.ConversationAvatarSize,);
    }else{
      avatar = Image.asset(conversation.avatar,width: Constants.ConversationAvatarSize,height: Constants.ConversationAvatarSize,);
    }
    if(conversation.unreadMsgCount>0){
      unreadMsgCountText = Container(//未读消息的小圆标widget
        width: Constants.UnReadMsgNotifyDotSize,
        height: Constants.UnReadMsgNotifyDotSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.UnReadMsgNotifyDotSize/2.0),
          color: Color(AppColors.NotifyDotBg),
        ),
        child: Text(conversation.unreadMsgCount.toString(),style: AppStyles.UnreadMsgCountDotStyle,),
      );
      //将头像图片和小圆标放在一起的widget
      avatarContainer = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            right:-6.0,
            top: -6.0,
            child: unreadMsgCountText,
          ),
        ],
      );
    }else{
      avatarContainer = avatar;
    }
      //勿扰模式图标
    muteIcon = Icon(IconData(0xe755,fontFamily: Constants.IconFontFamily,),color: Color(AppColors.ConversationMuteIcon),size: Constants.ConversationMuteIconSize,);

    var _rightarea=<Widget>[
      Text(conversation.updateAt,style: AppStyles.DesStyle,),
      Container(height: 8.0,)
    ];
    if(conversation.isMute) _rightarea.add(muteIcon);
    else _rightarea.add(
      //防止上面时间下沉，添加一个透明的图标，保证不管有没有静音，时间显示位置固定
        Icon(IconData(0xe755,fontFamily: Constants.IconFontFamily,),color: Colors.transparent,size: Constants.ConversationMuteIconSize,));

    return InkWell(
      onTap: (){
        print('click${conversation.title}');
//        Navigator.pushNamed(context, Routes.Conversation,
//            arguments: ConversationDetailArgs(title: conversation.title));
        },
      onTapDown: (TapDownDetails details) {
        tapPos = details.globalPosition;
      },
      onLongPress:(){
        _showMenu(context, tapPos);} ,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border:Border(
                bottom: BorderSide(
                  color: Color(AppColors.DividerColor),
                  width: Constants.DividerWidth,
                )
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            avatarContainer,
            Container(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(conversation.title,style:AppStyles.TitleStyle),
                  Text(conversation.des,style: AppStyles.DesStyle,),
                ],
              ),
            ),
            Column(
                children: _rightarea
            )
          ],
        ),
      )
    );
  }
}

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return _ConversationItem(conversation: mockConversations[index],);
      },
      itemCount: mockConversations.length,
    );
  }
}
