import 'package:flutter/material.dart';
import 'package:flutter_apptest/model/contacts.dart' show Contact,ContactsPageData;
import '../constants.dart'show Constants,AppColors,AppStyles;
//一个小contact的样式
class _ContactItem extends StatelessWidget {
  //构造函数 一个contact需要的参数
  _ContactItem({
    @required this.avatar,
    @required this.title,
    this.groupTitle,
    this.onPressed,
  });
  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback onPressed;

  bool _isAvatarFromNet(){
    if(this.avatar.indexOf('http')==0||this.avatar.indexOf('https')==0) return true;
    return false;
  }
  @override
  Widget build(BuildContext context) {
    Widget _avatarIcon;
    if(_isAvatarFromNet()){
      _avatarIcon = Image.network(avatar,width: Constants.ContactAvatarSize,height: Constants.ContactAvatarSize,);
    }else{
      _avatarIcon = Image.asset(avatar,width: Constants.ContactAvatarSize,height: Constants.ContactAvatarSize,);
    }
    //列表项主体
    Widget _body = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: Constants.DividerWidth,color: Color(AppColors.DividerColor))
          )
      ),
      child: Row(
        children: <Widget>[
          _avatarIcon,
          SizedBox(width: 10.0,),
          Text(title),
          SizedBox(width: 10.0,),
        ],
      ),
    );
    //添加了分组标签的列表项
    Widget _itemBody;
    if(this.groupTitle != null){
      _itemBody =Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 5.0,bottom: 5.0),
            color: const Color(AppColors.ContactGroupTitleBg),
            alignment: Alignment.centerLeft,
            child: Text(this.groupTitle,style: AppStyles.GroupTitleItemTextStyle,),
          ),
          _body,
        ],
      );
    }else{
      _itemBody = _body;
    }

    return _itemBody;
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}
class _ContactsPageState extends State<ContactsPage> {
  final ContactsPageData data = ContactsPageData.mock();
  final List<Contact> _contacts = [];
  final List<_ContactItem> _functionButtons =[
    _ContactItem(avatar: 'assets/images/ic_new_friend.png',
      title:'新的朋友',
      onPressed: (){ print('新的朋友');},
     ),
    _ContactItem(avatar: 'assets/images/ic_group_chat.png',
      title:'群聊',
      onPressed: (){ print('群聊');},
    ),
    _ContactItem(avatar: 'assets/images/ic_tag.png',
      title:'标签',
      onPressed: (){ print('标签');},
    ),
    _ContactItem(avatar: 'assets/images/ic_public_account.png',
      title:'添加公众号',
      onPressed: (){ print('添加公众号');},
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contacts..addAll(data.contacts)..addAll(data.contacts)..addAll(data.contacts);
    _contacts.sort((Contact a,Contact b)=> a.nameIndex.compareTo(b.nameIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context,int index){
          if(index< _functionButtons.length){
            return _functionButtons[index];
          }
          int _contactIndex = index - _functionButtons.length;
          Contact _contact = _contacts[_contactIndex];
          bool _isGroupTitle = true;
          if(_contactIndex >= 1 && _contact.nameIndex == _contacts[_contactIndex-1].nameIndex){
            _isGroupTitle = false;
          }
          return _ContactItem(
            avatar: _contact.avatar,
            title: _contact.name,
            groupTitle: _isGroupTitle ? _contact.nameIndex : null,);
        },
        itemCount: _contacts.length + _functionButtons.length,
      ),
    );
  }
}
