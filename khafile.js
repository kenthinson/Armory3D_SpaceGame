// Auto-generated
let project = new Project('SpaceShooterblend');

project.addSources('Sources');
project.addLibrary("/Users/kent/Applications/Armory/blender.app/armsdk/armory");
project.addLibrary("/Users/kent/Applications/Armory/blender.app/armsdk/iron");
project.addLibrary("/Users/kent/Applications/Armory/blender.app/armsdk/lib/haxebullet");
project.addAssets("/Users/kent/Applications/Armory/blender.app/armsdk/lib/haxebullet/ammo/ammo.js", { notinlist: true });
project.addParameter('armory.trait.physics.bullet.RigidBody');
project.addParameter("--macro keep('armory.trait.physics.bullet.RigidBody')");
project.addParameter('arm.BulletController');
project.addParameter("--macro keep('arm.BulletController')");
project.addParameter('arm.EnemyController');
project.addParameter("--macro keep('arm.EnemyController')");
project.addParameter('armory.trait.physics.bullet.PhysicsWorld');
project.addParameter("--macro keep('armory.trait.physics.bullet.PhysicsWorld')");
project.addParameter('arm.PlayerController');
project.addParameter("--macro keep('arm.PlayerController')");
project.addShaders("build_SpaceShooterblend/compiled/Shaders/*.glsl");
project.addAssets("build_SpaceShooterblend/compiled/Assets/**", { notinlist: true });
project.addAssets("build_SpaceShooterblend/compiled/Shaders/*.arm", { notinlist: true });
project.addAssets("/Users/kent/Applications/Armory/blender.app/armsdk/armory/Assets/brdf.png", { notinlist: true });
project.addAssets("/Users/kent/Applications/Armory/blender.app/armsdk/armory/Assets/smaa_area.png", { notinlist: true });
project.addAssets("/Users/kent/Applications/Armory/blender.app/armsdk/armory/Assets/smaa_search.png", { notinlist: true });
project.addAssets("Bundled/laser.wav", { notinlist: true , quality: 0.8999999761581421});
project.addDefine('arm_deferred');
project.addDefine('arm_csm');
project.addDefine('rp_hdr');
project.addDefine('rp_renderer=Deferred');
project.addDefine('rp_depthprepass');
project.addDefine('rp_shadowmap');
project.addDefine('rp_shadowmap_cascade=1024');
project.addDefine('rp_shadowmap_cube=512');
project.addDefine('rp_background=World');
project.addDefine('rp_render_to_texture');
project.addDefine('rp_compositornodes');
project.addDefine('rp_antialiasing=SMAA');
project.addDefine('rp_supersampling=1');
project.addDefine('rp_ssgi=SSAO');
project.addDefine('rp_gi=Off');
project.addDefine('arm_physics');
project.addDefine('arm_bullet');
project.addDefine('arm_shaderload');
project.addDefine('arm_soundcompress');
project.addDefine('arm_skin');
project.addDefine('arm_particles_gpu');
project.addDefine('arm_particles');


resolve(project);
