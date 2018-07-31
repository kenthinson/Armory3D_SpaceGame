package arm;
import iron.system.Time;

class BulletController extends iron.Trait {
	public function new() {
		super();

		// notifyOnInit(function() {
		// });

		notifyOnUpdate(function() {
			object.transform.translate(0,1*Time.delta,0);
		});

		// notifyOnRemove(function() {
		// });
	}
}
