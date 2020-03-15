package soloud

// Types
Soloud :: struct {}
Aligned_Float_Buffer :: struct {}
Tiny_Aligned_Float_Buffer :: struct {}
Audio_Collider :: struct {}
Audio_Attenuator :: struct {}
Audio_Source :: struct {}
Bassboost_Filter :: struct {}
Biquad_Resonant_Filter :: struct {}
Bus :: struct {}
Dc_Removal_Filter :: struct {}
Echo_Filter :: struct {}
Fader :: struct {}
Fft_Filter :: struct {}
Filter :: struct {}
Flanger_Filter :: struct {}
Freeverb_Filter :: struct {}
Lofi_Filter :: struct {}
Monotone :: struct {}
Noise :: struct {}
Openmpt :: struct {}
Queue :: struct {}
Robotize_Filter :: struct {}
Sfxr :: struct { using src: Audio_Source }
Speech :: struct { using src: Audio_Source }
Ted_Sid :: struct { using src: Audio_Source }
Vic :: struct { using src: Audio_Source }
Vizsn :: struct { using src: Audio_Source }
Wav :: struct { using src: Audio_Source }
Wave_Shaper_Filter :: struct {}
Wav_Stream :: struct { using src: Audio_Source }
File :: struct {}



// Constants
Soloud_Auto :: 0;
Soloud_Sdl1 :: 1;
Soloud_Sdl2 :: 2;
Soloud_Portaudio :: 3;
Soloud_Winmm :: 4;
Soloud_Xaudio2 :: 5;
Soloud_Wasapi :: 6;
Soloud_Alsa :: 7;
Soloud_Jack :: 8;
Soloud_Oss :: 9;
Soloud_Openal :: 10;
Soloud_Coreaudio :: 11;
Soloud_Opensles :: 12;
Soloud_Vita_Homebrew :: 13;
Soloud_Miniaudio :: 14;
Soloud_Nosound :: 15;
Soloud_Nulldriver :: 16;
Soloud_Backend_Max :: 17;
Soloud_Clip_Roundoff :: 1;
Soloud_Enable_Visualization :: 2;
Soloud_Left_Handed_3d :: 4;
Soloud_No_Fpu_Register_Change :: 8;
Soloud_Wave_Square :: 0;
Soloud_Wave_Saw :: 1;
Soloud_Wave_Sin :: 2;
Soloud_Wave_Triangle :: 3;
Soloud_Wave_Bounce :: 4;
Soloud_Wave_Jaws :: 5;
Soloud_Wave_Humps :: 6;
Soloud_Wave_Fsquare :: 7;
Soloud_Wave_Fsaw :: 8;
Soloud_Resampler_Point :: 0;
Soloud_Resampler_Linear :: 1;
Soloud_Resampler_Catmullrom :: 2;
Bassboostfilter_Wet :: 0;
Bassboostfilter_Boost :: 1;
Biquadresonantfilter_Lowpass :: 0;
Biquadresonantfilter_Highpass :: 1;
Biquadresonantfilter_Bandpass :: 2;
Biquadresonantfilter_Wet :: 0;
Biquadresonantfilter_Type :: 1;
Biquadresonantfilter_Frequency :: 2;
Biquadresonantfilter_Resonance :: 3;
Echofilter_Wet :: 0;
Echofilter_Delay :: 1;
Echofilter_Decay :: 2;
Echofilter_Filter :: 3;
Flangerfilter_Wet :: 0;
Flangerfilter_Delay :: 1;
Flangerfilter_Freq :: 2;
Freeverbfilter_Wet :: 0;
Freeverbfilter_Freeze :: 1;
Freeverbfilter_Roomsize :: 2;
Freeverbfilter_Damp :: 3;
Freeverbfilter_Width :: 4;
Lofifilter_Wet :: 0;
Lofifilter_Samplerate :: 1;
Lofifilter_Bitdepth :: 2;
Noise_White :: 0;
Noise_Pink :: 1;
Noise_Brownish :: 2;
Noise_Blueish :: 3;
Robotizefilter_Wet :: 0;
Robotizefilter_Freq :: 1;
Robotizefilter_Wave :: 2;
Sfxr_Coin :: 0;
Sfxr_Laser :: 1;
Sfxr_Explosion :: 2;
Sfxr_Powerup :: 3;
Sfxr_Hurt :: 4;
Sfxr_Jump :: 5;
Sfxr_Blip :: 6;
Speech_Kw_Saw :: 0;
Speech_Kw_Triangle :: 1;
Speech_Kw_Sin :: 2;
Speech_Kw_Square :: 3;
Speech_Kw_Pulse :: 4;
Speech_Kw_Noise :: 5;
Speech_Kw_Warble :: 6;
Vic_Pal :: 0;
Vic_Ntsc :: 1;
Vic_Bass :: 0;
Vic_Alto :: 1;
Vic_Soprano :: 2;
Vic_Noise :: 3;
Vic_Max_Regs :: 4;
Waveshaperfilter_Wet :: 0;
Waveshaperfilter_Amount :: 1;
