import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'package:task_managing_application/states/avatar_bloc/avatar_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/widgets.dart';

import 'future_avatar_widget.dart';

class AvatarWidgetWithBadge extends StatefulWidget {
  const AvatarWidgetWithBadge({
    super.key,
    required this.onTap,
    this.badgeTextStyle,
    this.avatarRatio = 0.06,
    this.radiusRatio = 0.03,
  });
  final void Function(BuildContext context) onTap;
  final TextStyle? badgeTextStyle;
  final double radiusRatio;
  final double avatarRatio;

  @override
  State<AvatarWidgetWithBadge> createState() => _AvatarWidgetWithBadgeState();
}

class _AvatarWidgetWithBadgeState extends State<AvatarWidgetWithBadge> {
  @override
  void initState() {
    context.read<AvatarBloc>().add(const AvatarSubscribeToUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvatarBloc, AvatarState>(
      builder: (context, state) {
        if (state is AvatarInitial) {
          return const Center(
            child: CustomCircularProgressIndicator(
              size: 52.0,
            ),
          );
        }
        if (state is AvatarError) {
          return const Center(
            child: CustomErrorIcon(),
          );
        }
        return FutureBuilder(
            future: context.read<AvatarBloc>().imageUrlFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomErrorIcon(),
                );
              }
              if (snapshot.hasData) {
                return badges.Badge(
                  position: badges.BadgePosition.topEnd(end: -4.0),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: context.colorScheme.error,
                    borderRadius: BorderRadius.circular(
                      context.mediaQuery.size.height *
                          widget.radiusRatio *
                          0.08,
                    ),
                    elevation: 4.0,
                    padding: const EdgeInsets.all(6.0),
                  ),
                  badgeAnimation: const badges.BadgeAnimation.scale(
                    animationDuration: Duration(milliseconds: 800),
                  ),
                  badgeContent: DefaultTextStyle.merge(
                    style: context.textTheme.bodySmall,
                    child: Text(
                      state.notifications!.length.toString(),
                      style: widget.badgeTextStyle ??
                          TextStyle(
                            color: context.colorScheme.onSecondary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  onTap: () => widget.onTap(context),
                  child: FutureAvatarWidget(
                    avatarRatio: widget.avatarRatio,
                    radiusRatio: widget.radiusRatio,
                    imageUrl: snapshot.data!,
                  ),
                );
              }
              return const SizedBox.shrink();
            });
      },
    );
  }
}
