package arm;
import iron.system.Input;
import iron.system.Time;

class PlayerController extends iron.Trait {
	private var timeSinceLastFire = 0.0;
	public function new() {
		super();

		// notifyOnInit(function() {
		// });

		//called every frame 
		notifyOnUpdate(function() {

			//true if left keyboard key is pressed down
			if(Input.getKeyboard().down("left")){
				object.transform.translate(-5*Time.delta,0,0);
				object.transform.setRotation(0,-10,0);
			}

			//true if right keyboard key is pressed down
			if(Input.getKeyboard().down("right")){
				object.transform.translate(5*Time.delta,0,0);
				object.transform.setRotation(0,10,0);
			}

			//true if both right and left keys are not pressed down
			if(!Input.getKeyboard().down("right") && !Input.getKeyboard().down("left")){
				object.transform.setRotation(0,0,0);
			}

			//true if up keyboard key is pressed down
			if(Input.getKeyboard().down("up")){
				object.transform.translate(0,5*Time.delta,0);
			}

			//true if down keyboard key is pressed down
			if(Input.getKeyboard().down("down")){
				object.transform.translate(0,-5*Time.delta,0);
				
			}

			

			//Fire bullets
			if(Input.getKeyboard().down("space")){
				if(timeSinceLastFire >= 0.2){
					iron.Scene.active.spawnObject("Bullet",null,function(bullet:iron.object.Object){
						bullet.transform.loc.set(object.transform.loc.x,object.transform.loc.y,object.transform.loc.z);
					});
					timeSinceLastFire = 0.0;
				}
				timeSinceLastFire += Time.delta;
			}

			if(Input.getKeyboard().started("space")){
				timeSinceLastFire = 10;
			}
		});

		// notifyOnRemove(function() {
		// });
	}
}
