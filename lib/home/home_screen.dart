import 'package:flutter/material.dart';
import '../home/conversation_page.dart';
import '../home/contacts_page.dart';
import 'package:flutter_apptest/constants.dart' show Constants,AppColors;

enum Actionitems{
  GROUP_CHAT,ADD_FRIEND,QR_SCAN,PAYMENT,HELP
}
//底部导航栏的view格式
class NavigationIconView{
  final BottomNavigationBarItem item;
  NavigationIconView({Key key,String title, IconData icon, IconData activeIcon}):
      item = BottomNavigationBarItem(
        icon: Icon(icon),
        activeIcon:Icon(activeIcon),
        title: Text(title),
        backgroundColor: Colors.white,
      );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationViews;//声明_navigationViews
  int _currentIndex = 0;//代表选中底部导航栏具体的哪一个tab
  List<Widget> _pages;
  PageController _pageController;
  @override
  void initState(){
    super.initState();//初始化_navigationViews
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        title: '微信',
        icon: IconData(0xe608,fontFamily: Constants.IconFontFamily),
        activeIcon:IconData(0xe603,fontFamily:Constants.IconFontFamily),
      ),
      NavigationIconView(
        title: '通讯录',
        icon: IconData(0xe601,fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe656,fontFamily: Constants.IconFontFamily),
      ),
      NavigationIconView(
        title: '发现',
        icon: IconData(0xe600,fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe671,fontFamily: Constants.IconFontFamily),
      ),
      NavigationIconView(
        title: '我',
        icon: IconData(0xe6c0,fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe626,fontFamily: Constants.IconFontFamily),
      ),
    ];
    _pageController = PageController(initialPage: _currentIndex);//初始化pagecontroller，通过controller来管理page
    _pages=[
      Container(child: ConversationPage(),),
      Container(child: ContactsPage(),),
      Container(color: Colors.amber,),
      Container(color: Colors.red,),
    ];
  }

  _buildPopupMunuItem(int iconname,String title){
    return Row(
      children: <Widget>[
        Icon(IconData(iconname,fontFamily: Constants.IconFontFamily),size: 22.0,color: const Color(AppColors.AppBarPopupMenuColor),),
        Container(width: 12.0,),
        Text(title,style: TextStyle(color: Color(AppColors.AppBarPopupMenuColor)),),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive), //选中后的颜色
      items: _navigationViews.map<BottomNavigationBarItem>((NavigationIconView view){
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve:Curves.easeInOut);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("WeChat") ,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(IconData(0xe65e,fontFamily: Constants.IconFontFamily),size: 22.0,),
          onPressed: (){print('click search');}
          ),
//          IconButton(icon: Icon(Icons.add,size: 22.0,),
//              onPressed: (){print('click add');}
//          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return <PopupMenuItem<Actionitems>>[
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe69e, "发起群聊"),
                  value: Actionitems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe638, "添加朋友"),
                  value: Actionitems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe61b, "扫一扫"),
                  value: Actionitems.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe62a, "收付款"),
                  value: Actionitems.PAYMENT,
                ),
                PopupMenuItem(
                  child: _buildPopupMunuItem(0xe63d, "帮助与反馈"),
                  value: Actionitems.HELP,
                ),
              ];
            },
            icon: Icon(IconData(0xe60e,fontFamily: Constants.IconFontFamily),size: 22.0,),
            onSelected:(Actionitems selected){print("click $selected");}
          ),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context,int index){
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}