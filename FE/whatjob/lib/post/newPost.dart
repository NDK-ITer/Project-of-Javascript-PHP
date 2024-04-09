import 'package:flutter/material.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:intl/intl.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _endSubmissionController =
      TextEditingController();
  final TextEditingController _workAddressController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _countEmployeeController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _feildController = TextEditingController();

  late DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _endSubmissionController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.green,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                          child: const Text(
                            "Đăng",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
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
                  const Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Công ty A - Trùm Đa Cấp",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Comfortaa",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TÊN",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: "Tên bài viết..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MÔ TẢ CÔNG VIỆC",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 8 * 20.0, // Giới hạn chiều cao
                          maxWidth:
                              double.infinity, // Giới hạn chiều rộng (vô hạn)
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.green, // Màu của viền
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: _jobDescriptionController,
                          decoration: const InputDecoration(
                            hintText: "Mô tả công việc..",
                            border: InputBorder.none,
                          ),
                          cursorColor: AppColors.green,
                          style: const TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 15,
                              fontFamily: "Comfortaa"),
                          maxLines: null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MỨC LƯƠNG",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _salaryController,
                        decoration: const InputDecoration(
                          hintText: "Mức lương..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "HẠN NỘP",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _endSubmissionController,
                        decoration: InputDecoration(
                          hintText: "dd/MM/yyyy",
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: const Icon(
                              Icons.calendar_today,
                              color: AppColors.green,
                            ),
                          ),
                        ),
                        cursorColor: AppColors.green,
                        readOnly: true,
                        style: const TextStyle(
                          color: AppColors.darkGreen,
                          fontSize: 15,
                          fontFamily: "Comfortaa",
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "KHU VỰC TUYỂN",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _workAddressController,
                        decoration: const InputDecoration(
                          hintText: "Khu vực tuyển..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "CẤP BẬC",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _levelController,
                        decoration: const InputDecoration(
                          hintText: "Cấp bậc..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "SỐ LƯỢNG TUYỂN",
                                style: TextStyle(
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.green, // Màu của viền
                                    width: 2.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: _countEmployeeController,
                                  decoration: const InputDecoration(
                                    hintText: "Số lượng tuyển..",
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.darkGreen,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "KINH NGHIỆM",
                                style: TextStyle(
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.green, // Màu của viền
                                    width: 2.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: _experienceController,
                                  decoration: const InputDecoration(
                                    hintText: "Kinh Nghiệm..",
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.darkGreen,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "BẰNG CẤP",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _degreeController,
                        decoration: const InputDecoration(
                          hintText: "Bằng cấp..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "NGÀNH NGHỀ",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _feildController,
                        decoration: const InputDecoration(
                          hintText: "Ngành nghề..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "HÌNH ẢNH",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Image.asset('assets/images/ava.jpg',
                          fit: BoxFit.fitWidth),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Chọn",
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 16,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.green),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
