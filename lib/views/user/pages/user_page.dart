import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplikasi01/core/resources/dimentions.dart';
import 'package:aplikasi01/models/moment.dart';
import 'package:aplikasi01/views/authentication/bloc/authentication_bloc.dart';
import 'package:aplikasi01/views/user/widgets/follow_item.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:faker/faker.dart' as faker;

import '../../moment/widgets/post_item_square.dart';
import 'user_setting_page.dart';

class UserPage extends StatelessWidget {
  static const routeName = '/user';
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeUser = context.watch<AuthenticationBloc>().activeUser;
    final oFaker = faker.Faker();
    List<Moment> moments = List.generate(
      6,
      (index) => Moment(
        id: nanoid(),
        momentDate: oFaker.date.dateTime(),
        creatorUsername: oFaker.person.name(),
        location: oFaker.address.city(),
        imageUrl: 'https://picsum.photos/800/600?random=$index',
        caption: oFaker.lorem.sentence(),
        totalLikes: faker.random.integer(1000),
        totalComments: faker.random.integer(100),
        totalBookmarks: faker.random.integer(10),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: largeSize),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(smallSize),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(extraLargeSize),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      activeUser?.imageUrl ?? 'https://i.pravatar.cc/150',
                    ),
                  ),
                  title: Text(activeUser != null
                      ? '${activeUser.firstName} ${activeUser.lastName}'.trim()
                      : 'User Full Name'),
                  subtitle: Text(activeUser?.username ?? 'Username'),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, UserSettingPage.routeName);
                    },
                    icon: const Icon(
                      Icons.settings_rounded,
                    ),
                  ),
                ),
                const Divider(
                  indent: largeSize,
                  endIndent: largeSize,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    largeSize,
                    0,
                    largeSize,
                    largeSize,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FollowItem(
                        label: 'Posts',
                        value: moments.length.toString(),
                      ),
                      const FollowItem(
                        label: 'Bookmarks',
                        value: '0',
                      ),
                      FollowItem(
                        label: 'Followers',
                        value: '${activeUser?.followerCount ?? 0}',
                      ),
                      FollowItem(
                        label: 'Following',
                        value: '${activeUser?.followingCount ?? 0}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: mediumSize),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => PostItemSquare(
                momentId: moments[index].id!,
                imageUrl: moments[index].imageUrl,
              ),
              itemCount: moments.length,
            ),
          ),
          const SizedBox(height: largeSize),
        ],
      ),
    );
  }
}
