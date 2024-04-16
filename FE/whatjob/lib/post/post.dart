import 'package:flutter/material.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/model/post.dart';
import 'package:whatjob/post/postDetail.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  final PostClass post;
  final String token;
  final String roleName;
  final String email;
  final Employee employee;

  const Post(
      {super.key,
      required this.post,
      required this.token,
      required this.roleName,
      required this.email,
      required this.employee});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    final String _avatar = widget.post.companyLogo;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_avatar),
                                onError: (exception, stackTrace) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.post.companyName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "5 phút trước",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Comfortaa",
                                  color: AppColors.gray),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/svg/menu.svg',
                          height: 5,
                          width: 5,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.post.name,
                            style: const TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.post.description,
                            style: const TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppColors.green, // Màu của viền

                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Mức lương: ${widget.post.salary}",
                              style: const TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Image.network(
              widget.post.image,
              fit: BoxFit.fitWidth,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 55,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Liên Hệ",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostDetail(
                                logo: widget.post.companyLogo,
                                companyName: widget.post.companyName,
                                postId: widget.post.id,
                                token: widget.token,
                                email: widget.email,
                                roleName: widget.roleName,
                                employee: widget.employee,
                              )),
                    );
                  },
                  child: Container(
                    height: 55,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        color: AppColors.green),
                    child: const Center(
                        child: Text(
                      "Chi tiết",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
