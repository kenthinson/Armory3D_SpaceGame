package arm;
import iron.Scene;
import iron.system.Time;
import iron.math.Vec4;

class EnemyController extends iron.Trait {
	private var health = 10;
	private var counterToFireNext = 0.0;
	//public function to deal damage to the Enemy. 
	//this function is to be called from other objects that are colliding with the enemy. 
	public function damage(amount:Int){
		health -= amount;
	}

	public function new() {
		super();

		// notifyOnInit(function() {
		// });

		notifyOnUpdate(function() {
			object.transform.rotate(Vec4.zAxis(), 0.05);

			counterToFireNext += Time.delta;
			if (counterToFireNext >= 0.1){
				Scene.active.spawnObject("EnemyBullet", object, function(enemyBullet:iron.object.Object){
					object.removeChild(enemyBullet,true);
				});
				counterToFireNext = 0.0;
			}


			//if the health of the Enemy reaches 0 then remove it from the game
			if(health <= 0){
				object.remove();
			}
		});

		// notifyOnRemove(function() {
		// });
	}
}
