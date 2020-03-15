package main

import "core:fmt"
import "shared:engine/libs/sdl2"
import "shared:engine/libs/soloud"

main :: proc() {
	sdl2.init(.Audio);

	so := soloud.create();
	fmt.println("so", soloud.init(so));

	wav := soloud.wav_create();
	fmt.println("wav load", soloud.wav_load(wav, "assets/skid.wav"));
	soloud.wav_setvolume(wav, 0.4);
	fmt.println("wav play", soloud.play(so, wav));

	sfx := soloud.sfxr_create();
	soloud.sfxr_loadpreset(sfx, .Explosion, 5);
	soloud.play(so, sfx);

	soloud.sfxr_loadpreset(sfx, .Laser, 5);
	soloud.play(so, sfx);

	soloud.sfxr_loadpreset(sfx, .Coin, 5);
	soloud.play(so, sfx);

	sdl2.delay(2000);
}
