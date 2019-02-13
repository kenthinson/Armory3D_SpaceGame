package arm;
import iron.system.Time;
import iron.object.Object;
import armory.trait.physics.PhysicsWorld;
import armory.trait.physics.RigidBody;

class BulletController extends iron.Trait {
	private var totalAliveTime = 0.0;
	private var physics:armory.trait.physics.PhysicsWorld;
	public function new() {
		super();

		notifyOnInit(function() {
			physics = armory.trait.physics.PhysicsWorld.active;
		});

		notifyOnUpdate(function() {
			//count total alive time
			totalAliveTime += Time.delta;
			//move bullet forward
			object.transform.translate(0,10*Time.delta,0);

			//Check rigidbody physics world for collision
			//getting all the collisions with the bullet
			var rigidBodies = physics.getContacts(object.getTrait(RigidBody));
			//if we have rigid bodies
			if(rigidBodies != null){
				//loop through each rigidBody
				for(rigidBody in rigidBodies){
					//check if the object that is attached to this rigidBody has a name of Enemy
					if(rigidBody.object.name == "Enemy"){
						// remove the bullet
						rigidBody.object.getTrait(EnemyController).damage(1);
						object.remove();
					}
					if(rigidBody.object.name == "EnemyBullet"){
						rigidBody.object.getTrait(EnemyBulletController).damage(1);
						object.remove();
					}
				}
			}



			//if in the game for 3 sec remove from the game
			if(totalAliveTime >= 3.0){
				object.remove();
			}

		});

		// notifyOnRemove(function() {
		// });
	}
}
