import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/post_model.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/custom_fun.dart';
import 'package:ubs/utils/sample_data.dart';

const double iconsSize = 40;

class RelatedAds extends StatelessWidget {
  final int mCateId;
  const RelatedAds({super.key, required this.mCateId});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    List<PostModel> postList = [];

    HomeController homeController = Get.find<HomeController>();
      homeController.fetchCatWiseAds(mCateId);

    for (int i = 0; i < addLists.length; i++) {
      postList.add(PostModel.fromJson(addLists[i]));
    }

    return Container(
      color: COLOR_WHITE,
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 270,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.catWiseAdsList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             PostDetails(adsPostData: postList[index])));
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
                    Image.network(
                      // postList[index].image1,
                      getLink(homeController.catWiseAdsList.value[index].pImg1),
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
                          '\$ ${homeController.catWiseAdsList.value[index].pPrice}',
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
                          icon: const Icon(
                            // postList[index].favorite == "no" ?
                            //  Icons.favorite_border :
                              Icons.favorite),
                        )
                      ],
                    ),
                    addVerticalSpace(2),
                    Text(
                      homeController.catWiseAdsList.value[index].pTitle,
                      style: textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    addVerticalSpace(2),
                    Text(
                      homeController.catWiseAdsList.value[index].pLocation,
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
      ),
    );
  }
}
