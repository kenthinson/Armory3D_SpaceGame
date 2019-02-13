package arm;
import iron.system.Time;
import iron.object.Object;
import iron.math.Vec4;

class EnemyBulletController extends iron.Trait {
	private var loc = new Vec4();
	private var vec = new Vec4();
	private var speed = 5.0;
	private var health = 1;

	public function damage(amount:Int){
		health -= amount;
	}

	public function new() {
		super();

		// notifyOnInit(function() {
		// });

		notifyOnUpdate(function() {
			var dt = Time.delta;

			loc.setFrom(object.transform.world.look());
			vec.x = loc.x * speed * dt;
			vec.y = loc.y * speed * dt;
			vec.z = loc.z * speed * dt;

			object.transform.loc.add(vec);
			object.transform.buildMatrix();

			if(health <= 0){
				object.remove();
			}
		});

		// notifyOnRemove(function() {
		// });
	}
}
