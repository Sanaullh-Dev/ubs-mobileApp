import 'package:flutter/material.dart';
import 'package:ubs/model/post_model.dart';
import 'package:ubs/pages/Post/post_details.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/sample_data.dart';

const double iconsSize = 40;

class RelatedAds extends StatelessWidget {
  const RelatedAds({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    List<PostModel> postList = [];

    for (int i = 0; i < addLists.length; i++) {
      postList.add(PostModel.fromJson(addLists[i]));
    }

    return Container(
      color: COLOR_WHITE,
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: postList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PostDetails(postData: postList[index])));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: COLOR_BORDER),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 12),
              // color: categoriesList[index]["color"],
              width: 215,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    postList[index].image1,
                    height: 150,
                    width: 210,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  addVerticalSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${postList[index].amount}',
                        style: textTheme.headline3,
                      ),
                      // Icon(Icons.favorite_border)
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        color: postList[index].favorite == "no"
                            ? Colors.black
                            : Colors.red,
                        onPressed: () {},
                        icon: Icon(postList[index].favorite == "no"
                            ? Icons.favorite_border
                            : Icons.favorite),
                      )
                    ],
                  ),
                  addVerticalSpace(2),
                  Text(
                    postList[index].name,
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  addVerticalSpace(2),
                  Text(
                    postList[index].location,
                    style: textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
