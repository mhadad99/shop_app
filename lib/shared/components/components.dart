
import 'package:flutter/material.dart';
// import 'package:news_app_fix/modules/web_view/web_view_screen.dart';
// import 'package:webview_flutter/webview_flutter.dart';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

// Widget buildArticleItem(article, context, {isSearch = false}) => InkWell(
//   onTap: (){
//     navigateTo(context, WebViewScreen(webController:WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(article['url']))));
//   },
//   child: Padding(
//     padding: const EdgeInsets.all(12.0),
//     child: Row(
//       children: [
//         Container(
//           width: 120,
//           height: 120,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: const DecorationImage(
//                 image: NetworkImage(
//                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWi7eHxwrwUrOPECeYlmte5Hr7bwnK8_Xp4X1J2sucDw&s'
//                 ),
//                 fit: BoxFit.cover,
//               )
//           ),
//
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//             child: SizedBox(
//               height: 120,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '${article['title']}',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//
//                   ),
//                   Text(
//                     '${article['publishedAt']}',
//                     style: const TextStyle(
//                       color: Colors.grey,
//
//                     ),
//                   )
//                 ],
//               ),
//             )
//         ),
//       ],
//     ),
//   ),
// );
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function function,
  bool isUpperCase = true,
  double radius = 0,
  required String text,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.blue),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmitted,
  Function? onChanged,
  Function? onTap,
  Function? validate,
  required String labelText,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmitted;
      },
      onChanged: (s) {
        onChanged!(s);
      },
      onTap: (){
        onTap;
      },
      validator: (s){
        validate!(s);
        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          labelText: labelText,
          // enabledBorder:
          //   OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          //focusedBorder: OutlineInputBorder(
          //  borderSide: BorderSide(color: Colors.deepOrange)),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: Icon(suffix))
              : null),
      obscureText: isPassword,
    );

Widget defaultAppbar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new)),
      title: const Text('add post'),
    );



void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
);
/*
void ShowToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WAERNING }

Color ChooseToastColor(ToastState state) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WAERNING:
      color = Colors.amber;
      break;
  }
  return color;
}
*/
/*
Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articlebuilder(list, context, {issearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => MyDivider(),
      itemCount: list.length),
  fallback: (context) => issearch
      ? Container()
      : Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrange,
      )),
);
*/
