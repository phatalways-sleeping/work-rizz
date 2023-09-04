part of 'tasklist_view.dart';

class ListTag extends StatelessWidget {
  const ListTag({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverToBoxAdapter(
      child: Container(
        height: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(margin: EdgeInsets.only(left: context.mediaQuery.size.width * RATIO_PADDING + 5.0),child: ProjectTag(color: GREEN, name: 'Demo'));
          },
        ),
      ),
    );
  }
}