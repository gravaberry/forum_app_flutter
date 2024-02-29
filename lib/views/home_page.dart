import 'package:flutter/material.dart';
import 'package:forum_app_flutter_v2/controllers/postController.dart';
import 'package:forum_app_flutter_v2/views/widget/post_data.dart';
import 'package:forum_app_flutter_v2/views/widget/post_field.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum APP'),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              await _postController.getAllPosts();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostFIeld(
                  hintText: 'What do you want to ask?',
                  controller: _textController,
                ),
                // const SizedBox(
                //   height: ,
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () async {
                    await _postController.createPost(
                      content: _textController.text.trim(),
                    );
                    _textController.clear();
                    _postController.getAllPosts();
                  },
                  child: Obx(() {
                    return _postController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Post');
                  }),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text('Posts'),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return _postController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _postController.posts.value.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: PostData(
                                post: _postController.posts.value[index],
                              ),
                            );
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
