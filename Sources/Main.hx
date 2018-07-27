// Auto-generated
package ;
class Main {
    public static inline var projectName = 'SpaceShooterblend';
    public static inline var projectPackage = 'arm';
    static var state:Int;
    #if js
    static function loadLib(name:String) {
        kha.Assets.loadBlobFromPath(name, function(b:kha.Blob) {
            untyped __js__("(1, eval)({0})", b.toString());
            state--;
            start();
        });
    }
    static function loadLibAmmo(name:String) {
        kha.Assets.loadBlobFromPath(name, function(b:kha.Blob) {
            var print = function(s:String) { trace(s); };
            var loaded = function() { state--; start(); };
            untyped __js__("(1, eval)({0})", b.toString());
            untyped __js__("Ammo({print:print}).then(loaded)");
        });
    }
    #end
    public static function main() {

        iron.object.BoneAnimation.skinMaxBones = 8;

        iron.object.LampObject.cascadeCount = 4;
        iron.object.LampObject.cascadeSplitFactor = 0.800000011920929;

        state = 1;
        #if (js && arm_bullet) state++; loadLibAmmo("ammo.js"); #end
        #if (js && arm_navigation) state++; loadLib("recast.js"); #end

        state--; start();
    }
    static function start() {
        if (state > 0) return;
        if (armory.data.Config.raw == null) armory.data.Config.raw = { };
        var config = armory.data.Config.raw;
        if (config.window_mode == null) config.window_mode = 0;
        if (config.window_resizable == null) config.window_resizable = false;
        if (config.window_minimizable == null) config.window_minimizable = true;
        if (config.window_maximizable == null) config.window_maximizable = false;
        if (config.window_w == null) config.window_w = 960;
        if (config.window_h == null) config.window_h = 540;
        if (config.window_msaa == null) config.window_msaa = 1;
        if (config.window_vsync == null) config.window_vsync = true;
        armory.object.Uniforms.register();
        var windowMode = config.window_mode == 0 ? kha.WindowMode.Window : kha.WindowMode.Fullscreen;
        #if (kha_version < 1807) // TODO: deprecated
        if (windowMode == kha.WindowMode.Fullscreen) { windowMode = kha.WindowMode.BorderlessWindow; config.window_w = kha.Display.width(0); config.window_h = kha.Display.height(0); }
        #end
        kha.System.init({title: projectName, width: config.window_w, height: config.window_h, samplesPerPixel: config.window_msaa, vSync: config.window_vsync, windowMode: windowMode, resizable: config.window_resizable, maximizable: config.window_maximizable, minimizable: config.window_minimizable}, function() {
            iron.App.init(function() {

                iron.Scene.setActive('Scene', function(object:iron.object.Object) {

                    iron.RenderPath.setActive(armory.renderpath.RenderPathCreator.get());

                });
            });
        });
    }
}
