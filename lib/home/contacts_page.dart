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
  });
  final String avatar;
  final String title;
  final String groupTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: Constants.DividerWidth,color: Color(AppColors.DividerColor))
        )
      ),
      child: Row(
        children: <Widget>[
          Image.network(avatar,width: Constants.ContactAvatarSize,height: Constants.ContactAvatarSize,),
          SizedBox(width: 10.0,),
          Text(title),
          SizedBox(width: 10.0,),
        ],
      ),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}
class _ContactsPageState extends State<ContactsPage> {
  final List<Contact> _contacts = ContactsPageData.mock().contacts;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context,int index){
          Contact _contact = _contacts[index];
          return _ContactItem(avatar: _contact.avatar,title: _contact.name,);
        },
        itemCount: _contacts.length,
      ),
    );
  }
}
