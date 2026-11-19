import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/post_cubit.dart';
import '../widgets/add_post.dart';
import '../widgets/PostCard.dart';

class DoctorPost extends StatefulWidget{
  @override
  State<DoctorPost> createState() => _postsState();

}

class _postsState extends State<DoctorPost> {
  bool hasNotifications = true;
  String? userProfileImageUrl = null;
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().loadPosts();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       scrolledUnderElevation: 0,
       toolbarHeight: 60,
       title: Row(
         children: [
           SizedBox(width: 10),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Healix", style: TextStyle(
                   color: Color(0xFF1AA6B0),
                   fontSize: 20,
                   fontWeight: FontWeight.bold)),
               Text("Your Health .. Our Priority", style: TextStyle(
                   color: Color(0xFF1AA6B0),
                   fontSize: 12)),
             ],
           ),
         ],
       ),
       actions: [
         Stack(
           alignment: Alignment.topRight,
           children: [
             const Padding(
               padding: EdgeInsets.only(top: 10, right: 4),
               child: Icon(Icons.notifications_none_rounded, color:Color(0xFF1AA6B0), size: 25),
             ),
             if (hasNotifications)
               Positioned(
                 right: 6,
                 top: 10,
                 child: Container(
                   width: 8,
                   height: 8,
                   decoration: const BoxDecoration(
                     color: Colors.redAccent,
                     shape: BoxShape.circle,
                   ),
                 ),
               ),
           ],
         ),
         SizedBox(width:12 ,),
         CircleAvatar(
           radius: 20,
           backgroundColor: Colors.grey,
           backgroundImage: userProfileImageUrl != null
               ? NetworkImage(userProfileImageUrl!)
               : null,
           child: userProfileImageUrl == null
               ? const Icon(Icons.person_rounded, color: Colors.white, size: 20)
               : null,
         ),
         SizedBox(width:12 ,),
       ],
     ),
     body: Container(
       width: double.infinity,
       height: double.infinity,
       decoration: BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter,
           colors: [
             Colors.white,
             Color(0xFFD5EAF4),
           ],
         ),
       ),
       child: SafeArea(
         child: Column(
           children: [
             Padding(
               padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     width: 48,
                     height: 48,
                     decoration: BoxDecoration(
                       color: Color(0xFF1AA6B0),
                       borderRadius: BorderRadius.circular(14),
                     ),
                     child: Icon(Icons.article_outlined, color: Colors.white),
                   ),
                   SizedBox(width: 12),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Medical Posts', style: TextStyle(
                             color: Color(0xFF1B4F7A),
                             fontSize: 22,
                             fontWeight: FontWeight.bold)),
                         Text('Share health knowledge, help your patients make better decisions.',
                             style: TextStyle(color: Color(0xFF6B8299), fontSize: 12)),
                       ],
                     ),
                   ),
                   SizedBox(width: 8),
                   GestureDetector(
                     onTap: () async {
                       final cubit = context.read<PostCubit>();

                       final published = await showModalBottomSheet<bool>(
                         context: context,
                         isScrollControlled: true,
                         backgroundColor: Colors.transparent,
                         builder: (context) => AddPostSheet(),
                       );

                       if (published == true) {
                         cubit.refreshPosts();
                       }
                     },
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                       decoration: BoxDecoration(
                         color: Color(0xFF1AA6B0),
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: Row(
                         children: [
                           Icon(Icons.add, color: Colors.white, size: 18),
                           SizedBox(width: 4),
                           Text('Add Post', style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w600)),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             SizedBox(height:10 ,),
             Padding(
               padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
               child: TextField(
                 controller: _searchController,
                 style: TextStyle(fontSize: 12),
                 textInputAction: TextInputAction.search,
                 onSubmitted: (value) {
                   FocusScope.of(context).unfocus();
                   context.read<PostCubit>().searchPosts(value);
                 },
                 decoration: InputDecoration(
                   hintText: 'Search for medicines, articles or posts...',
                   prefixIcon: Icon(Icons.search),
                   filled: true,
                   fillColor: Color(0xFFD5EAF4),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(25),
                     borderSide: BorderSide.none,
                   ),
                 ),
               ),
             ),
             SizedBox(height: 10,),
             Expanded(
               child: BlocBuilder<PostCubit, PostState>(
                 builder: (context, state) {
                   return switch (state) {
                     PostInitial() || PostLoading() => Center(
                       child: CircularProgressIndicator(
                         color: Colors.black54,
                       ),
                     ),

                     PostError(:final message) => Center(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text(message),
                           SizedBox(height: 12),
                           ElevatedButton(
                             onPressed: () => context.read<PostCubit>().loadPosts(),
                             child: Text('Retry'),
                           ),
                         ],
                       ),
                     ),


                     PostSuccess(:final posts) when posts.isEmpty => Center(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                            Text('No results found'),
                           SizedBox(height: 12),
                           ElevatedButton(
                             onPressed: () => context.read<PostCubit>().loadPosts(),
                             child:  Text('Retry'),
                           ),
                         ],
                       ),
                     ),

                     PostSuccess(:final posts, :final isLoadingMore) => RefreshIndicator(

                       onRefresh: () => context.read<PostCubit>().refreshPosts(),
                       color: Colors.black54,
                       child: NotificationListener<ScrollNotification>(
                         onNotification: (notification) {
                           final metrics = notification.metrics;
                           if (metrics.pixels >= metrics.maxScrollExtent - 300) {
                             context.read<PostCubit>().loadMore();
                           }
                           return false;
                         },
                         child: ListView.builder(
                           itemCount: posts.length + (isLoadingMore ? 1 : 0),
                           itemBuilder: (context, index) {
                             if (index == posts.length) {
                               return  Padding(
                                 padding: EdgeInsets.all(16),
                                 child: Center(child: CircularProgressIndicator(color: Colors.black54,)),
                               );
                             }
                             return PostCard(post: posts[index]);
                           },
                         ),
                       ),
                     ),
                   };
                 },
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }
}

