import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/models/post.dart';
import 'package:riverpod_api_calling/state/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            PostState state = ref.watch(postsProvider);
            if (state is InitialPostState) {
              return Text("Press Float Button To Fetch Data");
            }
            if (state is PostsLoadingState) {
              return CircularProgressIndicator();
            }
            if (state is ErrorPostState) {
              return Text(state.message);
            }
            if (state is PostsLoadedState) {
              return _buildListView(state);
            }

            return Text("No Results Found");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postsProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(PostsLoadedState state) {
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        Post post = state.posts[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(post.id.toString()),
          ),
          title: Text(post.title),
        );
      },
    );
  }
}
