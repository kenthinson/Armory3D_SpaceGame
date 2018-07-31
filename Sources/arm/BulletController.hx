package arm;
import iron.system.Time;

class BulletController extends iron.Trait {
	private var totalAliveTime = 0.0;
	public function new() {
		super();

		// notifyOnInit(function() {
		// });

		notifyOnUpdate(function() {
			object.transform.translate(0,10*Time.delta,0);

			if(totalAliveTime >= 3.0){
				object.remove();
			}

			totalAliveTime += Time.delta;
		});

		// notifyOnRemove(function() {
		// });
	}
}
