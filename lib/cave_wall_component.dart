import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class CaveWallComponent extends PositionComponent with CollisionCallbacks {
  final String textureKey;

  CaveWallComponent(
    this.textureKey, {
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });

  @override
  Future<void> onLoad() async {
    add(SpriteComponent(sprite: await Sprite.load('$textureKey.png')));

    addAll(getHitboxes(textureKey));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    for (final sprite in children.query<SpriteComponent>()) {
      sprite.add(ColorEffect(
          Colors.red, EffectController(duration: .1, reverseDuration: .1)));
    }
  }

  List<ShapeHitbox> getHitboxes(String textureKey) {
    final map = <String, List<ShapeHitbox> Function()>{
      'concave1': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.38),
                Vector2(-.5, -.15),
                Vector2(-.5, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
            PolygonHitbox.relative(
              [
                Vector2(-.5, 0),
                Vector2(-.5, -.15),
                Vector2(-.9, -.25),
                Vector2(-.9, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
            PolygonHitbox.relative(
              [
                Vector2(-.9, 0),
                Vector2(-.9, -.44),
                Vector2(-1, -.38),
                Vector2(-1, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'concave2': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.38),
                Vector2(-.2, -.38),
                Vector2(-.5, -.25),
                Vector2(-.5, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
            PolygonHitbox.relative(
              [
                Vector2(-.5, 0),
                Vector2(-.5, -.25),
                Vector2(-.9, -.25),
                Vector2(-.9, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
            PolygonHitbox.relative(
              [
                Vector2(-.9, 0),
                Vector2(-.9, -.25),
                Vector2(-1, -.38),
                Vector2(-1, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'convex1': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.38),
                Vector2(-.3, -1),
                Vector2(-.5, -1),
                Vector2(-.8, -.8),
                Vector2(-1, -.3),
                Vector2(-1, -0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'convex2': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.38),
                Vector2(-.3, -.7),
                Vector2(-.5, -.95),
                Vector2(-.8, -.7),
                Vector2(-1, -.3),
                Vector2(-1, -0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'flat1': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.45),
                Vector2(-1, -.45),
                Vector2(-1, -0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'flat2': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(-.1, -.58),
                Vector2(-1, -.45),
                Vector2(-1, -0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'concave_triple': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -1),
                Vector2(-.5, -.25),
                Vector2(-.5, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -1),
                Vector2(-.5, -.25),
                Vector2(-.5, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            )..flipHorizontally(),
          ],
      'convex_double': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.5),
                Vector2(-.5, -1),
                Vector2(-1, -.5),
                Vector2(-1, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'ramp_double': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.95),
                Vector2(-1, -.45),
                Vector2(-1, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'mirror_start_end': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -1),
                Vector2(-1, -.25),
                Vector2(-1, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
      'ramp_triple': () => <ShapeHitbox>[
            PolygonHitbox.relative(
              [
                Vector2(0, 0),
                Vector2(0, -.95),
                Vector2(-1, -.45),
                Vector2(-1, 0),
              ],
              parentSize: size * 2,
              isSolid: true,
              collisionType: CollisionType.active,
            ),
          ],
    };

    if (!map.containsKey(textureKey)) {
      throw Exception('No hitboxes found for $textureKey');
    }

    return map[textureKey]!.call();
  }
}
