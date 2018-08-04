package arm;

class EnemyController extends iron.Trait {
	private var health = 10;

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
			//if the health of the Enemy reaches 0 then remove it from the game
			if(health <= 0){
				object.remove();
			}
		});

		// notifyOnRemove(function() {
		// });
	}
}
