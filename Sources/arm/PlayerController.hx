package arm;
import iron.system.Input;

class PlayerController extends iron.Trait {
	public function new() {
		super();

		// notifyOnInit(function() {
		// });

		//called every frame 
		notifyOnUpdate(function() {

			//true if left keyboard key is pressed down
			if(Input.getKeyboard().down("left")){
				object.transform.translate(-0.1,0,0);
				object.transform.setRotation(0,-10,0);
			}

			//true if right keyboard key is pressed down
			if(Input.getKeyboard().down("right")){
				object.transform.translate(0.1,0,0);
				object.transform.setRotation(0,10,0);
			}

			//true if both right and left keys are not pressed down
			if(!Input.getKeyboard().down("right") && !Input.getKeyboard().down("left")){
				object.transform.setRotation(0,0,0);
			}

			//true if up keyboard key is pressed down
			if(Input.getKeyboard().down("up")){
				object.transform.translate(0,0.1,0);
			}

			//true if down keyboard key is pressed down
			if(Input.getKeyboard().down("down")){
				object.transform.translate(0,-0.1,0);
				
			}
		});

		// notifyOnRemove(function() {
		// });
	}
}
