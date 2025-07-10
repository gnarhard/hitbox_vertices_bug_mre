import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:removal_issue_mre/cave_wall_component.dart';

class MyGame extends FlameGame
    with SingleGameInstance, HasCollisionDetection, TapCallbacks {
  int textureIndex = 0;
  final List<String> textureKeys = [
    'concave1',
    'concave2',
    'convex_double',
    'convex1',
    'convex2',
    'flat1',
    'flat2',
    'mirror_start_end',
    'ramp_double',
    'ramp_triple',
  ];

  @override
  void onTapUp(TapUpEvent event) {
    textureIndex = (textureIndex + 1) % textureKeys.length;
    removeWall();
    addWall();
  }

  void removeWall() {
    world.children
        .query<CaveWallComponent>()
        .forEach((caveWall) => world.remove(caveWall));
  }

  Future<void> addWall() async {
    final sprite =
        await Sprite.load('${textureKeys.elementAt(textureIndex)}.png');
    world.add(
      CaveWallComponent(
        textureKeys.elementAt(textureIndex),
        anchor: Anchor.topLeft,
        size: sprite.srcSize,
        position: Vector2(size.x / 4, 0),
      )
        // ..flipHorizontallyAroundCenter()
        ..flipVerticallyAroundCenter()
        ..debugMode = true,
    );
    world.add(
      CaveWallComponent(
        textureKeys.elementAt(textureIndex),
        anchor: Anchor.bottomLeft,
        size: sprite.srcSize,
        position: Vector2(size.x / 4, size.y),
      )..debugMode = true,
    );
  }

  @override
  Future<void> onLoad() async {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();

    camera = CameraComponent.withFixedResolution(
      width: size.x,
      height: size.y,
      world: world,
      viewfinder: Viewfinder()..anchor = Anchor.topLeft,
    );

    add(camera);

    addWall();

    world.addAll([
      RectangleComponent.square(
        size: 16,
        paint: Paint()..color = Colors.white,
        anchor: Anchor.center,
        priority: 10,
        position: Vector2(0, 0),
        children: [
          RectangleHitbox.relative(Vector2(1, 1), parentSize: Vector2.all(16)),
          MoveEffect.by(Vector2(size.x, 0),
              EffectController(duration: 2, infinite: true)),
        ],
      ),
      RectangleComponent.square(
        size: 16,
        paint: Paint()..color = Colors.white,
        anchor: Anchor.center,
        priority: 10,
        position: Vector2(0, size.y - 16),
        children: [
          RectangleHitbox.relative(Vector2(1, 1), parentSize: Vector2.all(16)),
          MoveEffect.by(Vector2(size.x, 0),
              EffectController(duration: 2, infinite: true)),
        ],
      ),
    ]);
  }
}
