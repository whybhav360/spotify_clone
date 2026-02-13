// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
// import 'package:spotify_clone/core/configs/assets/app_images.dart';
// import 'package:spotify_clone/core/configs/theme/app_colors.dart';
//
// import '../../../common/widgets/appbar/app_bar.dart';
// import '../../../core/configs/assets/app_vectors.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(onPressed: () {}, icon: Icon(Icons.search)),
//                       Center(
//                         child: Transform.scale(
//                           scale: 0.8,
//                           child: SvgPicture.asset(AppVectors.logo),
//                         ),
//                       ),
//                       IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
//                     ],
//                   ),
//                   _homeTopCard(),
//                 ],
//               ),
//               _tabs(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _homeTopCard() {
//     return Center(
//       child: SizedBox(
//         height: 200,
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: SvgPicture.asset(AppVectors.homeTopCard),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 60),
//                 child: Image.asset(AppImages.homeArtist),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _tabs() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
//       child: TabBar(
//         isScrollable: true,
//         indicatorColor: AppColors.primary,
//         labelColor: context.isDarkMode ? Colors.white : Colors.black,
//         controller: _tabController,
//         tabs: [
//           Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//           ),
//           Text(
//             'Videos',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//           ),
//           Text(
//             'Artists',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//           ),
//           Text(
//             'Podcasts',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
