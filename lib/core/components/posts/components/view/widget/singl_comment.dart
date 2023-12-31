part of '../single_post_template.dart';

class _SingleComment extends StatelessWidget {
  const _SingleComment({
    super.key,
    required this.commentContent,
    required this.userApp,
  });
  final UserApp? userApp;

  final String commentContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (userApp != null) {
                Navigator.pushNamed(context, AppRoute.profile,
                    arguments: [userApp]);
              }
            },
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                CircleAvatar(
                  radius: 6.w,
                  backgroundColor: Colors.red.shade100,
                  backgroundImage: userApp?.imagePerson != null
                      ? NetworkImage(userApp!.imagePerson!)
                      : null,
                  child: userApp?.imagePerson != null
                      ? null
                      : const Center(
                          child: AppIcon(
                            icon: Icons.person,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(text: userApp?.name ?? 'Un know person'),
                ),
              ],
            ),
          ),
          AppText(text: commentContent),
        ],
      ),
    );
  }
}
