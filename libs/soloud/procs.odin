package soloud

when ODIN_OS == "windows" do foreign import lib "native/soloud_x64.dll";
when ODIN_OS == "darwin" do foreign import lib "native/libsoloud.dylib";

foreign lib {
	@(link_name = "Soloud_destroy")
	destroy :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_create")
	create :: proc() -> ^Soloud ---;

	@(link_name = "Soloud_init")
	init :: proc(soloud: ^Soloud) -> i32 ---;

	@(link_name = "Soloud_initEx")
	init_ex :: proc(soloud: ^Soloud, flags: u32, backend: u32, samplerate: u32, buffer_size: u32, channels: u32) -> i32 ---;

	@(link_name = "Soloud_deinit")
	deinit :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_getVersion")
	get_version :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getErrorString")
	get_error_string :: proc(soloud: ^Soloud, error_code: i32) -> cstring ---;

	@(link_name = "Soloud_getBackendId")
	get_backend_id :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getBackendString")
	get_backend_string :: proc(soloud: ^Soloud) -> cstring ---;

	@(link_name = "Soloud_getBackendChannels")
	get_backend_channels :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getBackendSamplerate")
	get_backend_samplerate :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getBackendBufferSize")
	get_backend_buffer_size :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_setSpeakerPosition")
	set_speaker_position :: proc(soloud: ^Soloud, channel: u32, x: f32, y: f32, z: f32) -> i32 ---;

	@(link_name = "Soloud_getSpeakerPosition")
	get_speaker_position :: proc(soloud: ^Soloud, channel: u32, x: ^f32, y: ^f32, z: ^f32) -> i32 ---;

	@(link_name = "Soloud_play")
	play :: proc(soloud: ^Soloud, sound: ^Audio_Source) -> u32 ---;

	@(link_name = "Soloud_playEx")
	play_ex :: proc(soloud: ^Soloud, sound: ^Audio_Source, volume: f32, pan: f32, paused: i32, bus: u32) -> u32 ---;

	@(link_name = "Soloud_playClocked")
	play_clocked :: proc(soloud: ^Soloud, sound_time: f64, sound: ^Audio_Source) -> u32 ---;

	@(link_name = "Soloud_playClockedEx")
	play_clocked_ex :: proc(soloud: ^Soloud, sound_time: f64, sound: ^Audio_Source, volume: f32, pan: f32, bus: u32) -> u32 ---;

	@(link_name = "Soloud_play3d")
	play3d :: proc(soloud: ^Soloud, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32) -> u32 ---;

	@(link_name = "Soloud_play3dEx")
	play3d_ex :: proc(soloud: ^Soloud, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32, vel_x: f32, vel_y: f32, vel_z: f32, volume: f32, paused: i32, bus: u32) -> u32 ---;

	@(link_name = "Soloud_play3dClocked")
	play3d_clocked :: proc(soloud: ^Soloud, sound_time: f64, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32) -> u32 ---;

	@(link_name = "Soloud_play3dClockedEx")
	play3d_clocked_ex :: proc(soloud: ^Soloud, sound_time: f64, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32, vel_x: f32, vel_y: f32, vel_z: f32, volume: f32, bus: u32) -> u32 ---;

	@(link_name = "Soloud_playBackground")
	play_background :: proc(soloud: ^Soloud, sound: ^Audio_Source) -> u32 ---;

	@(link_name = "Soloud_playBackgroundEx")
	play_background_ex :: proc(soloud: ^Soloud, sound: ^Audio_Source, volume: f32, paused: i32, bus: u32) -> u32 ---;

	@(link_name = "Soloud_seek")
	seek :: proc(soloud: ^Soloud, voice_handle: u32, seconds: f64) -> i32 ---;

	@(link_name = "Soloud_stop")
	stop :: proc(soloud: ^Soloud, voice_handle: u32) ---;

	@(link_name = "Soloud_stopAll")
	stop_all :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_stopAudioSource")
	stop_audio_source :: proc(soloud: ^Soloud, sound: ^Audio_Source) ---;

	@(link_name = "Soloud_countAudioSource")
	count_audio_source :: proc(soloud: ^Soloud, sound: ^Audio_Source) -> i32 ---;

	@(link_name = "Soloud_setFilterParameter")
	set_filter_parameter :: proc(soloud: ^Soloud, voice_handle: u32, filter_id: u32, attribute_id: u32, value: f32) ---;

	@(link_name = "Soloud_getFilterParameter")
	get_filter_parameter :: proc(soloud: ^Soloud, voice_handle: u32, filter_id: u32, attribute_id: u32) -> f32 ---;

	@(link_name = "Soloud_fadeFilterParameter")
	fade_filter_parameter :: proc(soloud: ^Soloud, voice_handle: u32, filter_id: u32, attribute_id: u32, to: f32, time: f64) ---;

	@(link_name = "Soloud_oscillateFilterParameter")
	oscillate_filter_parameter :: proc(soloud: ^Soloud, voice_handle: u32, filter_id: u32, attribute_id: u32, from: f32, to: f32, time: f64) ---;

	@(link_name = "Soloud_getStreamTime")
	get_stream_time :: proc(soloud: ^Soloud, voice_handle: u32) -> f64 ---;

	@(link_name = "Soloud_getStreamPosition")
	get_stream_position :: proc(soloud: ^Soloud, voice_handle: u32) -> f64 ---;

	@(link_name = "Soloud_getPause")
	get_pause :: proc(soloud: ^Soloud, voice_handle: u32) -> i32 ---;

	@(link_name = "Soloud_getVolume")
	get_volume :: proc(soloud: ^Soloud, voice_handle: u32) -> f32 ---;

	@(link_name = "Soloud_getOverallVolume")
	get_overall_volume :: proc(soloud: ^Soloud, voice_handle: u32) -> f32 ---;

	@(link_name = "Soloud_getPan")
	get_pan :: proc(soloud: ^Soloud, voice_handle: u32) -> f32 ---;

	@(link_name = "Soloud_getSamplerate")
	get_samplerate :: proc(soloud: ^Soloud, voice_handle: u32) -> f32 ---;

	@(link_name = "Soloud_getProtectVoice")
	get_protect_voice :: proc(soloud: ^Soloud, voice_handle: u32) -> i32 ---;

	@(link_name = "Soloud_getActiveVoiceCount")
	get_active_voice_count :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getVoiceCount")
	get_voice_count :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_isValidVoiceHandle")
	is_valid_voice_handle :: proc(soloud: ^Soloud, voice_handle: u32) -> i32 ---;

	@(link_name = "Soloud_getRelativePlaySpeed")
	get_relative_play_speed :: proc(soloud: ^Soloud, voice_handle: u32) -> f32 ---;

	@(link_name = "Soloud_getPostClipScaler")
	get_post_clip_scaler :: proc(soloud: ^Soloud) -> f32 ---;

	@(link_name = "Soloud_getMainResampler")
	get_main_resampler :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getGlobalVolume")
	get_global_volume :: proc(soloud: ^Soloud) -> f32 ---;

	@(link_name = "Soloud_getMaxActiveVoiceCount")
	get_max_active_voice_count :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getLooping")
	get_looping :: proc(soloud: ^Soloud, voice_handle: u32) -> i32 ---;

	@(link_name = "Soloud_getLoopPoint")
	get_loop_point :: proc(soloud: ^Soloud, voice_handle: u32) -> f64 ---;

	@(link_name = "Soloud_setLoopPoint")
	set_loop_point :: proc(soloud: ^Soloud, voice_handle: u32, loop_point: f64) ---;

	@(link_name = "Soloud_setLooping")
	set_looping :: proc(soloud: ^Soloud, voice_handle: u32, looping: i32) ---;

	@(link_name = "Soloud_setMaxActiveVoiceCount")
	set_max_active_voice_count :: proc(soloud: ^Soloud, aVoiceCount: u32) -> i32 ---;

	@(link_name = "Soloud_setInaudibleBehavior")
	set_inaudible_behavior :: proc(soloud: ^Soloud, voice_handle: u32, must_tick: i32, kill: i32) ---;

	@(link_name = "Soloud_setGlobalVolume")
	set_global_volume :: proc(soloud: ^Soloud, volume: f32) ---;

	@(link_name = "Soloud_setPostClipScaler")
	set_post_clip_scaler :: proc(soloud: ^Soloud, aScaler: f32) ---;

	@(link_name = "Soloud_setMainResampler")
	set_main_resampler :: proc(soloud: ^Soloud, aResampler: u32) ---;

	@(link_name = "Soloud_setPause")
	set_pause :: proc(soloud: ^Soloud, voice_handle: u32, aPause: i32) ---;

	@(link_name = "Soloud_setPauseAll")
	set_pause_all :: proc(soloud: ^Soloud, aPause: i32) ---;

	@(link_name = "Soloud_setRelativePlaySpeed")
	set_relative_play_speed :: proc(soloud: ^Soloud, voice_handle: u32, speed: f32) -> i32 ---;

	@(link_name = "Soloud_setProtectVoice")
	set_protect_voice :: proc(soloud: ^Soloud, voice_handle: u32, aProtect: i32) ---;

	@(link_name = "Soloud_setSamplerate")
	set_samplerate :: proc(soloud: ^Soloud, voice_handle: u32, aSamplerate: f32) ---;

	@(link_name = "Soloud_setPan")
	set_pan :: proc(soloud: ^Soloud, voice_handle: u32, pan: f32) ---;

	@(link_name = "Soloud_setPanAbsolute")
	set_pan_absolute :: proc(soloud: ^Soloud, voice_handle: u32, volume_l: f32, volume_r: f32) ---;

	@(link_name = "Soloud_setChannelVolume")
	set_channel_volume :: proc(soloud: ^Soloud, voice_handle: u32, channel: u32, volume: f32) ---;

	@(link_name = "Soloud_setVolume")
	set_volume :: proc(soloud: ^Soloud, voice_handle: u32, volume: f32) ---;

	@(link_name = "Soloud_setDelaySamples")
	set_delay_samples :: proc(soloud: ^Soloud, voice_handle: u32, samples: u32) ---;

	@(link_name = "Soloud_fadeVolume")
	fade_volume :: proc(soloud: ^Soloud, voice_handle: u32, to: f32, time: f64) ---;

	@(link_name = "Soloud_fadePan")
	fade_pan :: proc(soloud: ^Soloud, voice_handle: u32, to: f32, time: f64) ---;

	@(link_name = "Soloud_fadeRelativePlaySpeed")
	fade_relative_play_speed :: proc(soloud: ^Soloud, voice_handle: u32, to: f32, time: f64) ---;

	@(link_name = "Soloud_fadeGlobalVolume")
	fade_global_volume :: proc(soloud: ^Soloud, to: f32, time: f64) ---;

	@(link_name = "Soloud_schedulePause")
	schedule_pause :: proc(soloud: ^Soloud, voice_handle: u32, time: f64) ---;

	@(link_name = "Soloud_scheduleStop")
	schedule_stop :: proc(soloud: ^Soloud, voice_handle: u32, time: f64) ---;

	@(link_name = "Soloud_oscillateVolume")
	oscillate_volume :: proc(soloud: ^Soloud, voice_handle: u32, from: f32, to: f32, time: f64) ---;

	@(link_name = "Soloud_oscillatePan")
	oscillate_pan :: proc(soloud: ^Soloud, voice_handle: u32, from: f32, to: f32, time: f64) ---;

	@(link_name = "Soloud_oscillateRelativePlaySpeed")
	oscillate_relative_play_speed :: proc(soloud: ^Soloud, voice_handle: u32, from: f32, to: f32, time: f64) ---;

	@(link_name = "Soloud_oscillateGlobalVolume")
	oscillate_global_volume :: proc(soloud: ^Soloud, from: f32, to: f32, time: f64) ---;

	@(link_name = "Soloud_setGlobalFilter")
	set_global_filter :: proc(soloud: ^Soloud, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Soloud_setVisualizationEnable")
	set_visualization_enable :: proc(soloud: ^Soloud, enable: i32) ---;

	@(link_name = "Soloud_calcFFT")
	calc_f_f_t :: proc(soloud: ^Soloud) -> ^f32 ---;

	@(link_name = "Soloud_getWave")
	get_wave :: proc(soloud: ^Soloud) -> ^f32 ---;

	@(link_name = "Soloud_getApproximateVolume")
	get_approximate_volume :: proc(soloud: ^Soloud, channel: u32) -> f32 ---;

	@(link_name = "Soloud_getLoopCount")
	get_loop_count :: proc(soloud: ^Soloud, voice_handle: u32) -> u32 ---;

	@(link_name = "Soloud_getInfo")
	get_info :: proc(soloud: ^Soloud, voice_handle: u32, aInfoKey: u32) -> f32 ---;

	@(link_name = "Soloud_createVoiceGroup")
	create_voice_group :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_destroyVoiceGroup")
	destroy_voice_group :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 ---;

	@(link_name = "Soloud_addVoiceToGroup")
	add_voice_to_group :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32, voice_handle: u32) -> i32 ---;

	@(link_name = "Soloud_isVoiceGroup")
	is_voice_group :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 ---;

	@(link_name = "Soloud_isVoiceGroupEmpty")
	is_voice_group_empty :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 ---;

	@(link_name = "Soloud_update3dAudio")
	update3d_audio :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_set3dSoundSpeed")
	set3d_sound_speed :: proc(soloud: ^Soloud, speed: f32) -> i32 ---;

	@(link_name = "Soloud_get3dSoundSpeed")
	get3d_sound_speed :: proc(soloud: ^Soloud) -> f32 ---;

	@(link_name = "Soloud_set3dListenerParameters")
	set3d_listener_parameters :: proc(soloud: ^Soloud, pos_x: f32, pos_y: f32, pos_z: f32, at_x: f32, at_y: f32, at_z: f32, up_x: f32, up_y: f32, up_z: f32) ---;

	@(link_name = "Soloud_set3dListenerParametersEx")
	set3d_listener_parameters_ex :: proc(soloud: ^Soloud, pos_x: f32, pos_y: f32, pos_z: f32, at_x: f32, at_y: f32, at_z: f32, up_x: f32, up_y: f32, up_z: f32, vel_x: f32, vel_y: f32, vel_z: f32) ---;

	@(link_name = "Soloud_set3dListenerPosition")
	set3d_listener_position :: proc(soloud: ^Soloud, pos_x: f32, pos_y: f32, pos_z: f32) ---;

	@(link_name = "Soloud_set3dListenerAt")
	set3d_listener_at :: proc(soloud: ^Soloud, at_x: f32, at_y: f32, at_z: f32) ---;

	@(link_name = "Soloud_set3dListenerUp")
	set3d_listener_up :: proc(soloud: ^Soloud, up_x: f32, up_y: f32, up_z: f32) ---;

	@(link_name = "Soloud_set3dListenerVelocity")
	set3d_listener_velocity :: proc(soloud: ^Soloud, vel_x: f32, vel_y: f32, vel_z: f32) ---;

	@(link_name = "Soloud_set3dSourceParameters")
	set3d_source_parameters :: proc(soloud: ^Soloud, voice_handle: u32, pos_x: f32, pos_y: f32, pos_z: f32) ---;

	@(link_name = "Soloud_set3dSourceParametersEx")
	set3d_source_parameters_ex :: proc(soloud: ^Soloud, voice_handle: u32, pos_x: f32, pos_y: f32, pos_z: f32, vel_x: f32, vel_y: f32, vel_z: f32) ---;

	@(link_name = "Soloud_set3dSourcePosition")
	set3d_source_position :: proc(soloud: ^Soloud, voice_handle: u32, pos_x: f32, pos_y: f32, pos_z: f32) ---;

	@(link_name = "Soloud_set3dSourceVelocity")
	set3d_source_velocity :: proc(soloud: ^Soloud, voice_handle: u32, vel_x: f32, vel_y: f32, vel_z: f32) ---;

	@(link_name = "Soloud_set3dSourceMinMaxDistance")
	set3d_source_min_max_distance :: proc(soloud: ^Soloud, voice_handle: u32, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Soloud_set3dSourceAttenuation")
	set3d_source_attenuation :: proc(soloud: ^Soloud, voice_handle: u32, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Soloud_set3dSourceDopplerFactor")
	set3d_source_doppler_factor :: proc(soloud: ^Soloud, voice_handle: u32, doppler_effect: f32) ---;

	@(link_name = "Soloud_mix")
	mix :: proc(soloud: ^Soloud, aBuffer: ^f32, samples: u32) ---;

	@(link_name = "Soloud_mixSigned16")
	mix_signed16 :: proc(soloud: ^Soloud, aBuffer: ^i16, samples: u32) ---;

	@(link_name = "BassboostFilter_destroy")
	bassboostfilter_destroy :: proc(bassboostfilter: ^Bassboost_Filter) ---;

	@(link_name = "BassboostFilter_getParamCount")
	bassboostfilter_getparamcount :: proc(bassboostfilter: ^Bassboost_Filter) -> i32 ---;

	@(link_name = "BassboostFilter_getParamName")
	bassboostfilter_getparamname :: proc(bassboostfilter: ^Bassboost_Filter, param_index: u32) -> cstring ---;

	@(link_name = "BassboostFilter_getParamType")
	bassboostfilter_getparamtype :: proc(bassboostfilter: ^Bassboost_Filter, param_index: u32) -> u32 ---;

	@(link_name = "BassboostFilter_getParamMax")
	bassboostfilter_getparammax :: proc(bassboostfilter: ^Bassboost_Filter, param_index: u32) -> f32 ---;

	@(link_name = "BassboostFilter_getParamMin")
	bassboostfilter_getparammin :: proc(bassboostfilter: ^Bassboost_Filter, param_index: u32) -> f32 ---;

	@(link_name = "BassboostFilter_setParams")
	bassboostfilter_setparams :: proc(bassboostfilter: ^Bassboost_Filter, boose: f32) -> i32 ---;

	@(link_name = "BassboostFilter_create")
	bassboostfilter_create :: proc() -> ^Bassboost_Filter ---;

	@(link_name = "BiquadResonantFilter_destroy")
	biquadresonantfilter_destroy :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter) ---;

	@(link_name = "BiquadResonantFilter_getParamCount")
	biquadresonantfilter_getparamcount :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter) -> i32 ---;

	@(link_name = "BiquadResonantFilter_getParamName")
	biquadresonantfilter_getparamname :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter, param_index: u32) -> cstring ---;

	@(link_name = "BiquadResonantFilter_getParamType")
	biquadresonantfilter_getparamtype :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter, param_index: u32) -> u32 ---;

	@(link_name = "BiquadResonantFilter_getParamMax")
	biquadresonantfilter_getparammax :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter, param_index: u32) -> f32 ---;

	@(link_name = "BiquadResonantFilter_getParamMin")
	biquadresonantfilter_getparammin :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter, param_index: u32) -> f32 ---;

	@(link_name = "BiquadResonantFilter_create")
	biquadresonantfilter_create :: proc() -> ^Biquad_Resonant_Filter ---;

	@(link_name = "BiquadResonantFilter_setParams")
	biquadresonantfilter_setparams :: proc(biquad_resonant_filter: ^Biquad_Resonant_Filter, type: i32, aFrequency: f32, aResonance: f32) -> i32 ---;

	@(link_name = "Bus_destroy")
	bus_destroy :: proc(bus: ^Bus) ---;

	@(link_name = "Bus_create")
	bus_create :: proc() -> ^Bus ---;

	@(link_name = "Bus_setFilter")
	bus_setfilter :: proc(bus: ^Bus, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Bus_play")
	bus_play :: proc(bus: ^Bus, sound: ^Audio_Source) -> u32 ---;

	@(link_name = "Bus_playEx")
	bus_playex :: proc(bus: ^Bus, sound: ^Audio_Source, volume: f32, pan: f32, paused: i32) -> u32 ---;

	@(link_name = "Bus_playClocked")
	bus_playclocked :: proc(bus: ^Bus, sound_time: f64, sound: ^Audio_Source) -> u32 ---;

	@(link_name = "Bus_playClockedEx")
	bus_playclockedex :: proc(bus: ^Bus, sound_time: f64, sound: ^Audio_Source, volume: f32, pan: f32) -> u32 ---;

	@(link_name = "Bus_play3d")
	bus_play3d :: proc(bus: ^Bus, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32) -> u32 ---;

	@(link_name = "Bus_play3dEx")
	bus_play3dex :: proc(bus: ^Bus, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32, vel_x: f32, vel_y: f32, vel_z: f32, volume: f32, paused: i32) -> u32 ---;

	@(link_name = "Bus_play3dClocked")
	bus_play3dclocked :: proc(bus: ^Bus, sound_time: f64, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32) -> u32 ---;

	@(link_name = "Bus_play3dClockedEx")
	bus_play3dclockedex :: proc(bus: ^Bus, sound_time: f64, sound: ^Audio_Source, pos_x: f32, pos_y: f32, pos_z: f32, vel_x: f32, vel_y: f32, vel_z: f32, volume: f32) -> u32 ---;

	@(link_name = "Bus_setChannels")
	bus_setchannels :: proc(bus: ^Bus, channels: u32) -> i32 ---;

	@(link_name = "Bus_setVisualizationEnable")
	bus_setvisualizationenable :: proc(bus: ^Bus, enable: i32) ---;

	@(link_name = "Bus_annexSound")
	bus_annexsound :: proc(bus: ^Bus, voice_handle: u32) ---;

	@(link_name = "Bus_calcFFT")
	bus_calcfft :: proc(bus: ^Bus) -> ^f32 ---;

	@(link_name = "Bus_getWave")
	bus_getwave :: proc(bus: ^Bus) -> ^f32 ---;

	@(link_name = "Bus_getApproximateVolume")
	bus_getapproximatevolume :: proc(bus: ^Bus, channel: u32) -> f32 ---;

	@(link_name = "Bus_getActiveVoiceCount")
	bus_getactivevoicecount :: proc(bus: ^Bus) -> u32 ---;

	@(link_name = "Bus_getResampler")
	bus_getresampler :: proc(bus: ^Bus) -> u32 ---;

	@(link_name = "Bus_setResampler")
	bus_setresampler :: proc(bus: ^Bus, aResampler: u32) ---;

	@(link_name = "Bus_setVolume")
	bus_setvolume :: proc(bus: ^Bus, volume: f32) ---;

	@(link_name = "Bus_setLooping")
	bus_setlooping :: proc(bus: ^Bus, loop: i32) ---;

	@(link_name = "Bus_set3dMinMaxDistance")
	bus_set3dminmaxdistance :: proc(bus: ^Bus, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Bus_set3dAttenuation")
	bus_set3dattenuation :: proc(bus: ^Bus, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Bus_set3dDopplerFactor")
	bus_set3ddopplerfactor :: proc(bus: ^Bus, doppler_effect: f32) ---;

	@(link_name = "Bus_set3dListenerRelative")
	bus_set3dlistenerrelative :: proc(bus: ^Bus, listener_relative: i32) ---;

	@(link_name = "Bus_set3dDistanceDelay")
	bus_set3ddistancedelay :: proc(bus: ^Bus, distance_delay: i32) ---;

	@(link_name = "Bus_set3dCollider")
	bus_set3dcollider :: proc(bus: ^Bus, collider: ^Audio_Collider) ---;

	@(link_name = "Bus_set3dColliderEx")
	bus_set3dcolliderex :: proc(bus: ^Bus, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Bus_set3dAttenuator")
	bus_set3dattenuator :: proc(bus: ^Bus, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Bus_setInaudibleBehavior")
	bus_setinaudiblebehavior :: proc(bus: ^Bus, must_tick: i32, kill: i32) ---;

	@(link_name = "Bus_setLoopPoint")
	bus_setlooppoint :: proc(bus: ^Bus, loop_point: f64) ---;

	@(link_name = "Bus_getLoopPoint")
	bus_getlooppoint :: proc(bus: ^Bus) -> f64 ---;

	@(link_name = "Bus_stop")
	bus_stop :: proc(bus: ^Bus) ---;

	@(link_name = "DCRemovalFilter_destroy")
	dcremovalfilter_destroy :: proc(dc_removal_filter: ^Dc_Removal_Filter) ---;

	@(link_name = "DCRemovalFilter_create")
	dcremovalfilter_create :: proc() -> ^Dc_Removal_Filter ---;

	@(link_name = "DCRemovalFilter_setParams")
	dcremovalfilter_setparams :: proc(dc_removal_filter: ^Dc_Removal_Filter) -> i32 ---;

	@(link_name = "DCRemovalFilter_setParamsEx")
	dcremovalfilter_setparamsex :: proc(dc_removal_filter: ^Dc_Removal_Filter, length: f32) -> i32 ---;

	@(link_name = "DCRemovalFilter_getParamCount")
	dcremovalfilter_getparamcount :: proc(dc_removal_filter: ^Dc_Removal_Filter) -> i32 ---;

	@(link_name = "DCRemovalFilter_getParamName")
	dcremovalfilter_getparamname :: proc(dc_removal_filter: ^Dc_Removal_Filter, param_index: u32) -> cstring ---;

	@(link_name = "DCRemovalFilter_getParamType")
	dcremovalfilter_getparamtype :: proc(dc_removal_filter: ^Dc_Removal_Filter, param_index: u32) -> u32 ---;

	@(link_name = "DCRemovalFilter_getParamMax")
	dcremovalfilter_getparammax :: proc(dc_removal_filter: ^Dc_Removal_Filter, param_index: u32) -> f32 ---;

	@(link_name = "DCRemovalFilter_getParamMin")
	dcremovalfilter_getparammin :: proc(dc_removal_filter: ^Dc_Removal_Filter, param_index: u32) -> f32 ---;

	@(link_name = "EchoFilter_destroy")
	echofilter_destroy :: proc(echo_filter: ^Echo_Filter) ---;

	@(link_name = "EchoFilter_getParamCount")
	echofilter_getparamcount :: proc(echo_filter: ^Echo_Filter) -> i32 ---;

	@(link_name = "EchoFilter_getParamName")
	echofilter_getparamname :: proc(echo_filter: ^Echo_Filter, param_index: u32) -> cstring ---;

	@(link_name = "EchoFilter_getParamType")
	echofilter_getparamtype :: proc(echo_filter: ^Echo_Filter, param_index: u32) -> u32 ---;

	@(link_name = "EchoFilter_getParamMax")
	echofilter_getparammax :: proc(echo_filter: ^Echo_Filter, param_index: u32) -> f32 ---;

	@(link_name = "EchoFilter_getParamMin")
	echofilter_getparammin :: proc(echo_filter: ^Echo_Filter, param_index: u32) -> f32 ---;

	@(link_name = "EchoFilter_create")
	echofilter_create :: proc() -> ^Echo_Filter ---;

	@(link_name = "EchoFilter_setParams")
	echofilter_setparams :: proc(echo_filter: ^Echo_Filter, aDelay: f32) -> i32 ---;

	@(link_name = "EchoFilter_setParamsEx")
	echofilter_setparamsex :: proc(echo_filter: ^Echo_Filter, aDelay: f32, aDecay: f32, filter: f32) -> i32 ---;

	@(link_name = "FFTFilter_destroy")
	fftfilter_destroy :: proc(fft_filter: ^Fft_Filter) ---;

	@(link_name = "FFTFilter_create")
	fftfilter_create :: proc() -> ^Fft_Filter ---;

	@(link_name = "FFTFilter_getParamCount")
	fftfilter_getparamcount :: proc(fft_filter: ^Fft_Filter) -> i32 ---;

	@(link_name = "FFTFilter_getParamName")
	fftfilter_getparamname :: proc(fft_filter: ^Fft_Filter, param_index: u32) -> cstring ---;

	@(link_name = "FFTFilter_getParamType")
	fftfilter_getparamtype :: proc(fft_filter: ^Fft_Filter, param_index: u32) -> u32 ---;

	@(link_name = "FFTFilter_getParamMax")
	fftfilter_getparammax :: proc(fft_filter: ^Fft_Filter, param_index: u32) -> f32 ---;

	@(link_name = "FFTFilter_getParamMin")
	fftfilter_getparammin :: proc(fft_filter: ^Fft_Filter, param_index: u32) -> f32 ---;

	@(link_name = "FlangerFilter_destroy")
	flangerfilter_destroy :: proc(flanger_filter: ^Flanger_Filter) ---;

	@(link_name = "FlangerFilter_getParamCount")
	flangerfilter_getparamcount :: proc(flanger_filter: ^Flanger_Filter) -> i32 ---;

	@(link_name = "FlangerFilter_getParamName")
	flangerfilter_getparamname :: proc(flanger_filter: ^Flanger_Filter, param_index: u32) -> cstring ---;

	@(link_name = "FlangerFilter_getParamType")
	flangerfilter_getparamtype :: proc(flanger_filter: ^Flanger_Filter, param_index: u32) -> u32 ---;

	@(link_name = "FlangerFilter_getParamMax")
	flangerfilter_getparammax :: proc(flanger_filter: ^Flanger_Filter, param_index: u32) -> f32 ---;

	@(link_name = "FlangerFilter_getParamMin")
	flangerfilter_getparammin :: proc(flanger_filter: ^Flanger_Filter, param_index: u32) -> f32 ---;

	@(link_name = "FlangerFilter_create")
	flangerfilter_create :: proc() -> ^Flanger_Filter ---;

	@(link_name = "FlangerFilter_setParams")
	flangerfilter_setparams :: proc(flanger_filter: ^Flanger_Filter, aDelay: f32, aFreq: f32) -> i32 ---;

	@(link_name = "FreeverbFilter_destroy")
	freeverbfilter_destroy :: proc(freeverb_filter: ^Freeverb_Filter) ---;

	@(link_name = "FreeverbFilter_getParamCount")
	freeverbfilter_getparamcount :: proc(freeverb_filter: ^Freeverb_Filter) -> i32 ---;

	@(link_name = "FreeverbFilter_getParamName")
	freeverbfilter_getparamname :: proc(freeverb_filter: ^Freeverb_Filter, param_index: u32) -> cstring ---;

	@(link_name = "FreeverbFilter_getParamType")
	freeverbfilter_getparamtype :: proc(freeverb_filter: ^Freeverb_Filter, param_index: u32) -> u32 ---;

	@(link_name = "FreeverbFilter_getParamMax")
	freeverbfilter_getparammax :: proc(freeverb_filter: ^Freeverb_Filter, param_index: u32) -> f32 ---;

	@(link_name = "FreeverbFilter_getParamMin")
	freeverbfilter_getparammin :: proc(freeverb_filter: ^Freeverb_Filter, param_index: u32) -> f32 ---;

	@(link_name = "FreeverbFilter_create")
	freeverbfilter_create :: proc() -> ^Freeverb_Filter ---;

	@(link_name = "FreeverbFilter_setParams")
	freeverbfilter_setparams :: proc(freeverb_filter: ^Freeverb_Filter, aMode: f32, aRoomSize: f32, aDamp: f32, aWidth: f32) -> i32 ---;

	@(link_name = "LofiFilter_destroy")
	lofifilter_destroy :: proc(lofi_filter: ^Lofi_Filter) ---;

	@(link_name = "LofiFilter_getParamCount")
	lofifilter_getparamcount :: proc(lofi_filter: ^Lofi_Filter) -> i32 ---;

	@(link_name = "LofiFilter_getParamName")
	lofifilter_getparamname :: proc(lofi_filter: ^Lofi_Filter, param_index: u32) -> cstring ---;

	@(link_name = "LofiFilter_getParamType")
	lofifilter_getparamtype :: proc(lofi_filter: ^Lofi_Filter, param_index: u32) -> u32 ---;

	@(link_name = "LofiFilter_getParamMax")
	lofifilter_getparammax :: proc(lofi_filter: ^Lofi_Filter, param_index: u32) -> f32 ---;

	@(link_name = "LofiFilter_getParamMin")
	lofifilter_getparammin :: proc(lofi_filter: ^Lofi_Filter, param_index: u32) -> f32 ---;

	@(link_name = "LofiFilter_create")
	lofifilter_create :: proc() -> ^Lofi_Filter ---;

	@(link_name = "LofiFilter_setParams")
	lofifilter_setparams :: proc(lofi_filter: ^Lofi_Filter, aSampleRate: f32, aBitdepth: f32) -> i32 ---;

	@(link_name = "Monotone_destroy")
	monotone_destroy :: proc(monotone: ^Monotone) ---;

	@(link_name = "Monotone_create")
	monotone_create :: proc() -> ^Monotone ---;

	@(link_name = "Monotone_setParams")
	monotone_setparams :: proc(monotone: ^Monotone, aHardwareChannels: i32) -> i32 ---;

	@(link_name = "Monotone_setParamsEx")
	monotone_setparamsex :: proc(monotone: ^Monotone, aHardwareChannels: i32, aWaveform: i32) -> i32 ---;

	@(link_name = "Monotone_load")
	monotone_load :: proc(monotone: ^Monotone, filename: cstring) -> i32 ---;

	@(link_name = "Monotone_loadMem")
	monotone_loadmem :: proc(monotone: ^Monotone, mem: ^byte, length: u32) -> i32 ---;

	@(link_name = "Monotone_loadMemEx")
	monotone_loadmemex :: proc(monotone: ^Monotone, mem: ^byte, length: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "Monotone_loadFile")
	monotone_loadfile :: proc(monotone: ^Monotone, aFile: ^File) -> i32 ---;

	@(link_name = "Monotone_setVolume")
	monotone_setvolume :: proc(monotone: ^Monotone, volume: f32) ---;

	@(link_name = "Monotone_setLooping")
	monotone_setlooping :: proc(monotone: ^Monotone, loop: i32) ---;

	@(link_name = "Monotone_set3dMinMaxDistance")
	monotone_set3dminmaxdistance :: proc(monotone: ^Monotone, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Monotone_set3dAttenuation")
	monotone_set3dattenuation :: proc(monotone: ^Monotone, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Monotone_set3dDopplerFactor")
	monotone_set3ddopplerfactor :: proc(monotone: ^Monotone, doppler_effect: f32) ---;

	@(link_name = "Monotone_set3dListenerRelative")
	monotone_set3dlistenerrelative :: proc(monotone: ^Monotone, listener_relative: i32) ---;

	@(link_name = "Monotone_set3dDistanceDelay")
	monotone_set3ddistancedelay :: proc(monotone: ^Monotone, distance_delay: i32) ---;

	@(link_name = "Monotone_set3dCollider")
	monotone_set3dcollider :: proc(monotone: ^Monotone, collider: ^Audio_Collider) ---;

	@(link_name = "Monotone_set3dColliderEx")
	monotone_set3dcolliderex :: proc(monotone: ^Monotone, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Monotone_set3dAttenuator")
	monotone_set3dattenuator :: proc(monotone: ^Monotone, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Monotone_setInaudibleBehavior")
	monotone_setinaudiblebehavior :: proc(monotone: ^Monotone, must_tick: i32, kill: i32) ---;

	@(link_name = "Monotone_setLoopPoint")
	monotone_setlooppoint :: proc(monotone: ^Monotone, loop_point: f64) ---;

	@(link_name = "Monotone_getLoopPoint")
	monotone_getlooppoint :: proc(monotone: ^Monotone) -> f64 ---;

	@(link_name = "Monotone_setFilter")
	monotone_setfilter :: proc(monotone: ^Monotone, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Monotone_stop")
	monotone_stop :: proc(monotone: ^Monotone) ---;

	@(link_name = "Noise_destroy")
	noise_destroy :: proc(noise: ^Noise) ---;

	@(link_name = "Noise_create")
	noise_create :: proc() -> ^Noise ---;

	@(link_name = "Noise_setOctaveScale")
	noise_setoctavescale :: proc(noise: ^Noise, aOct0: f32, aOct1: f32, aOct2: f32, aOct3: f32, aOct4: f32, aOct5: f32, aOct6: f32, aOct7: f32, aOct8: f32, aOct9: f32) ---;

	@(link_name = "Noise_setType")
	noise_settype :: proc(noise: ^Noise, type: i32) ---;

	@(link_name = "Noise_setVolume")
	noise_setvolume :: proc(noise: ^Noise, volume: f32) ---;

	@(link_name = "Noise_setLooping")
	noise_setlooping :: proc(noise: ^Noise, loop: i32) ---;

	@(link_name = "Noise_set3dMinMaxDistance")
	noise_set3dminmaxdistance :: proc(noise: ^Noise, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Noise_set3dAttenuation")
	noise_set3dattenuation :: proc(noise: ^Noise, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Noise_set3dDopplerFactor")
	noise_set3ddopplerfactor :: proc(noise: ^Noise, doppler_effect: f32) ---;

	@(link_name = "Noise_set3dListenerRelative")
	noise_set3dlistenerrelative :: proc(noise: ^Noise, listener_relative: i32) ---;

	@(link_name = "Noise_set3dDistanceDelay")
	noise_set3ddistancedelay :: proc(noise: ^Noise, distance_delay: i32) ---;

	@(link_name = "Noise_set3dCollider")
	noise_set3dcollider :: proc(noise: ^Noise, collider: ^Audio_Collider) ---;

	@(link_name = "Noise_set3dColliderEx")
	noise_set3dcolliderex :: proc(noise: ^Noise, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Noise_set3dAttenuator")
	noise_set3dattenuator :: proc(noise: ^Noise, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Noise_setInaudibleBehavior")
	noise_setinaudiblebehavior :: proc(noise: ^Noise, must_tick: i32, kill: i32) ---;

	@(link_name = "Noise_setLoopPoint")
	noise_setlooppoint :: proc(noise: ^Noise, loop_point: f64) ---;

	@(link_name = "Noise_getLoopPoint")
	noise_getlooppoint :: proc(noise: ^Noise) -> f64 ---;

	@(link_name = "Noise_setFilter")
	noise_setfilter :: proc(noise: ^Noise, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Noise_stop")
	noise_stop :: proc(noise: ^Noise) ---;

	@(link_name = "Openmpt_destroy")
	openmpt_destroy :: proc(aOpenmpt: ^Openmpt) ---;

	@(link_name = "Openmpt_create")
	openmpt_create :: proc() -> ^Openmpt ---;

	@(link_name = "Openmpt_load")
	openmpt_load :: proc(aOpenmpt: ^Openmpt, filename: cstring) -> i32 ---;

	@(link_name = "Openmpt_loadMem")
	openmpt_loadmem :: proc(aOpenmpt: ^Openmpt, mem: ^byte, length: u32) -> i32 ---;

	@(link_name = "Openmpt_loadMemEx")
	openmpt_loadmemex :: proc(aOpenmpt: ^Openmpt, mem: ^byte, length: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "Openmpt_loadFile")
	openmpt_loadfile :: proc(aOpenmpt: ^Openmpt, aFile: ^File) -> i32 ---;

	@(link_name = "Openmpt_setVolume")
	openmpt_setvolume :: proc(aOpenmpt: ^Openmpt, volume: f32) ---;

	@(link_name = "Openmpt_setLooping")
	openmpt_setlooping :: proc(aOpenmpt: ^Openmpt, loop: i32) ---;

	@(link_name = "Openmpt_set3dMinMaxDistance")
	openmpt_set3dminmaxdistance :: proc(aOpenmpt: ^Openmpt, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Openmpt_set3dAttenuation")
	openmpt_set3dattenuation :: proc(aOpenmpt: ^Openmpt, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Openmpt_set3dDopplerFactor")
	openmpt_set3ddopplerfactor :: proc(aOpenmpt: ^Openmpt, doppler_effect: f32) ---;

	@(link_name = "Openmpt_set3dListenerRelative")
	openmpt_set3dlistenerrelative :: proc(aOpenmpt: ^Openmpt, listener_relative: i32) ---;

	@(link_name = "Openmpt_set3dDistanceDelay")
	openmpt_set3ddistancedelay :: proc(aOpenmpt: ^Openmpt, distance_delay: i32) ---;

	@(link_name = "Openmpt_set3dCollider")
	openmpt_set3dcollider :: proc(aOpenmpt: ^Openmpt, collider: ^Audio_Collider) ---;

	@(link_name = "Openmpt_set3dColliderEx")
	openmpt_set3dcolliderex :: proc(aOpenmpt: ^Openmpt, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Openmpt_set3dAttenuator")
	openmpt_set3dattenuator :: proc(aOpenmpt: ^Openmpt, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Openmpt_setInaudibleBehavior")
	openmpt_setinaudiblebehavior :: proc(aOpenmpt: ^Openmpt, must_tick: i32, kill: i32) ---;

	@(link_name = "Openmpt_setLoopPoint")
	openmpt_setlooppoint :: proc(aOpenmpt: ^Openmpt, loop_point: f64) ---;

	@(link_name = "Openmpt_getLoopPoint")
	openmpt_getlooppoint :: proc(aOpenmpt: ^Openmpt) -> f64 ---;

	@(link_name = "Openmpt_setFilter")
	openmpt_setfilter :: proc(aOpenmpt: ^Openmpt, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Openmpt_stop")
	openmpt_stop :: proc(aOpenmpt: ^Openmpt) ---;

	@(link_name = "Queue_destroy")
	queue_destroy :: proc(aQueue: ^Queue) ---;

	@(link_name = "Queue_create")
	queue_create :: proc() -> ^Queue ---;

	@(link_name = "Queue_play")
	queue_play :: proc(aQueue: ^Queue, sound: ^Audio_Source) -> i32 ---;

	@(link_name = "Queue_getQueueCount")
	queue_getqueuecount :: proc(aQueue: ^Queue) -> u32 ---;

	@(link_name = "Queue_isCurrentlyPlaying")
	queue_iscurrentlyplaying :: proc(aQueue: ^Queue, sound: ^Audio_Source) -> i32 ---;

	@(link_name = "Queue_setParamsFromAudioSource")
	queue_setparamsfromaudiosource :: proc(aQueue: ^Queue, sound: ^Audio_Source) -> i32 ---;

	@(link_name = "Queue_setParams")
	queue_setparams :: proc(aQueue: ^Queue, aSamplerate: f32) -> i32 ---;

	@(link_name = "Queue_setParamsEx")
	queue_setparamsex :: proc(aQueue: ^Queue, aSamplerate: f32, channels: u32) -> i32 ---;

	@(link_name = "Queue_setVolume")
	queue_setvolume :: proc(aQueue: ^Queue, volume: f32) ---;

	@(link_name = "Queue_setLooping")
	queue_setlooping :: proc(aQueue: ^Queue, loop: i32) ---;

	@(link_name = "Queue_set3dMinMaxDistance")
	queue_set3dminmaxdistance :: proc(aQueue: ^Queue, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Queue_set3dAttenuation")
	queue_set3dattenuation :: proc(aQueue: ^Queue, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Queue_set3dDopplerFactor")
	queue_set3ddopplerfactor :: proc(aQueue: ^Queue, doppler_effect: f32) ---;

	@(link_name = "Queue_set3dListenerRelative")
	queue_set3dlistenerrelative :: proc(aQueue: ^Queue, listener_relative: i32) ---;

	@(link_name = "Queue_set3dDistanceDelay")
	queue_set3ddistancedelay :: proc(aQueue: ^Queue, distance_delay: i32) ---;

	@(link_name = "Queue_set3dCollider")
	queue_set3dcollider :: proc(aQueue: ^Queue, collider: ^Audio_Collider) ---;

	@(link_name = "Queue_set3dColliderEx")
	queue_set3dcolliderex :: proc(aQueue: ^Queue, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Queue_set3dAttenuator")
	queue_set3dattenuator :: proc(aQueue: ^Queue, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Queue_setInaudibleBehavior")
	queue_setinaudiblebehavior :: proc(aQueue: ^Queue, must_tick: i32, kill: i32) ---;

	@(link_name = "Queue_setLoopPoint")
	queue_setlooppoint :: proc(aQueue: ^Queue, loop_point: f64) ---;

	@(link_name = "Queue_getLoopPoint")
	queue_getlooppoint :: proc(aQueue: ^Queue) -> f64 ---;

	@(link_name = "Queue_setFilter")
	queue_setfilter :: proc(aQueue: ^Queue, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Queue_stop")
	queue_stop :: proc(aQueue: ^Queue) ---;

	@(link_name = "RobotizeFilter_destroy")
	robotizefilter_destroy :: proc(aRobotizeFilter: ^Robotize_Filter) ---;

	@(link_name = "RobotizeFilter_getParamCount")
	robotizefilter_getparamcount :: proc(aRobotizeFilter: ^Robotize_Filter) -> i32 ---;

	@(link_name = "RobotizeFilter_getParamName")
	robotizefilter_getparamname :: proc(aRobotizeFilter: ^Robotize_Filter, param_index: u32) -> cstring ---;

	@(link_name = "RobotizeFilter_getParamType")
	robotizefilter_getparamtype :: proc(aRobotizeFilter: ^Robotize_Filter, param_index: u32) -> u32 ---;

	@(link_name = "RobotizeFilter_getParamMax")
	robotizefilter_getparammax :: proc(aRobotizeFilter: ^Robotize_Filter, param_index: u32) -> f32 ---;

	@(link_name = "RobotizeFilter_getParamMin")
	robotizefilter_getparammin :: proc(aRobotizeFilter: ^Robotize_Filter, param_index: u32) -> f32 ---;

	@(link_name = "RobotizeFilter_setParams")
	robotizefilter_setparams :: proc(aRobotizeFilter: ^Robotize_Filter, aFreq: f32, aWaveform: i32) ---;

	@(link_name = "RobotizeFilter_create")
	robotizefilter_create :: proc() -> ^Robotize_Filter ---;

	@(link_name = "Sfxr_destroy")
	sfxr_destroy :: proc(sfxr: ^Sfxr) ---;

	@(link_name = "Sfxr_create")
	sfxr_create :: proc() -> ^Sfxr ---;

	@(link_name = "Sfxr_resetParams")
	sfxr_resetparams :: proc(sfxr: ^Sfxr) ---;

	@(link_name = "Sfxr_loadParams")
	sfxr_loadparams :: proc(sfxr: ^Sfxr, filename: cstring) -> i32 ---;

	@(link_name = "Sfxr_loadParamsMem")
	sfxr_loadparamsmem :: proc(sfxr: ^Sfxr, mem: ^byte, length: u32) -> i32 ---;

	@(link_name = "Sfxr_loadParamsMemEx")
	sfxr_loadparamsmemex :: proc(sfxr: ^Sfxr, mem: ^byte, length: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "Sfxr_loadParamsFile")
	sfxr_loadparamsfile :: proc(sfxr: ^Sfxr, aFile: ^File) -> i32 ---;

	@(link_name = "Sfxr_loadPreset")
	sfxr_loadpreset :: proc(sfxr: ^Sfxr, preset_no: Sfxr_Preset, rand_speed: i32) -> i32 ---;

	@(link_name = "Sfxr_setVolume")
	sfxr_setvolume :: proc(sfxr: ^Sfxr, volume: f32) ---;

	@(link_name = "Sfxr_setLooping")
	sfxr_setlooping :: proc(sfxr: ^Sfxr, loop: i32) ---;

	@(link_name = "Sfxr_set3dMinMaxDistance")
	sfxr_set3dminmaxdistance :: proc(sfxr: ^Sfxr, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Sfxr_set3dAttenuation")
	sfxr_set3dattenuation :: proc(sfxr: ^Sfxr, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Sfxr_set3dDopplerFactor")
	sfxr_set3ddopplerfactor :: proc(sfxr: ^Sfxr, doppler_effect: f32) ---;

	@(link_name = "Sfxr_set3dListenerRelative")
	sfxr_set3dlistenerrelative :: proc(sfxr: ^Sfxr, listener_relative: i32) ---;

	@(link_name = "Sfxr_set3dDistanceDelay")
	sfxr_set3ddistancedelay :: proc(sfxr: ^Sfxr, distance_delay: i32) ---;

	@(link_name = "Sfxr_set3dCollider")
	sfxr_set3dcollider :: proc(sfxr: ^Sfxr, collider: ^Audio_Collider) ---;

	@(link_name = "Sfxr_set3dColliderEx")
	sfxr_set3dcolliderex :: proc(sfxr: ^Sfxr, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Sfxr_set3dAttenuator")
	sfxr_set3dattenuator :: proc(sfxr: ^Sfxr, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Sfxr_setInaudibleBehavior")
	sfxr_setinaudiblebehavior :: proc(sfxr: ^Sfxr, must_tick: i32, kill: i32) ---;

	@(link_name = "Sfxr_setLoopPoint")
	sfxr_setlooppoint :: proc(sfxr: ^Sfxr, loop_point: f64) ---;

	@(link_name = "Sfxr_getLoopPoint")
	sfxr_getlooppoint :: proc(sfxr: ^Sfxr) -> f64 ---;

	@(link_name = "Sfxr_setFilter")
	sfxr_setfilter :: proc(sfxr: ^Sfxr, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Sfxr_stop")
	sfxr_stop :: proc(sfxr: ^Sfxr) ---;

	@(link_name = "Speech_destroy")
	speech_destroy :: proc(aSpeech: ^Speech) ---;

	@(link_name = "Speech_create")
	speech_create :: proc() -> ^Speech ---;

	@(link_name = "Speech_setText")
	speech_settext :: proc(aSpeech: ^Speech, text: cstring) -> i32 ---;

	@(link_name = "Speech_setParams")
	speech_setparams :: proc(aSpeech: ^Speech) -> i32 ---;

	@(link_name = "Speech_setParamsEx")
	speech_setparamsex :: proc(aSpeech: ^Speech, aBaseFrequency: u32, aBaseSpeed: f32, aBaseDeclination: f32, aBaseWaveform: i32) -> i32 ---;

	@(link_name = "Speech_setVolume")
	speech_setvolume :: proc(aSpeech: ^Speech, volume: f32) ---;

	@(link_name = "Speech_setLooping")
	speech_setlooping :: proc(aSpeech: ^Speech, loop: i32) ---;

	@(link_name = "Speech_set3dMinMaxDistance")
	speech_set3dminmaxdistance :: proc(aSpeech: ^Speech, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Speech_set3dAttenuation")
	speech_set3dattenuation :: proc(aSpeech: ^Speech, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Speech_set3dDopplerFactor")
	speech_set3ddopplerfactor :: proc(aSpeech: ^Speech, doppler_effect: f32) ---;

	@(link_name = "Speech_set3dListenerRelative")
	speech_set3dlistenerrelative :: proc(aSpeech: ^Speech, listener_relative: i32) ---;

	@(link_name = "Speech_set3dDistanceDelay")
	speech_set3ddistancedelay :: proc(aSpeech: ^Speech, distance_delay: i32) ---;

	@(link_name = "Speech_set3dCollider")
	speech_set3dcollider :: proc(aSpeech: ^Speech, collider: ^Audio_Collider) ---;

	@(link_name = "Speech_set3dColliderEx")
	speech_set3dcolliderex :: proc(aSpeech: ^Speech, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Speech_set3dAttenuator")
	speech_set3dattenuator :: proc(aSpeech: ^Speech, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Speech_setInaudibleBehavior")
	speech_setinaudiblebehavior :: proc(aSpeech: ^Speech, must_tick: i32, kill: i32) ---;

	@(link_name = "Speech_setLoopPoint")
	speech_setlooppoint :: proc(aSpeech: ^Speech, loop_point: f64) ---;

	@(link_name = "Speech_getLoopPoint")
	speech_getlooppoint :: proc(aSpeech: ^Speech) -> f64 ---;

	@(link_name = "Speech_setFilter")
	speech_setfilter :: proc(aSpeech: ^Speech, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Speech_stop")
	speech_stop :: proc(aSpeech: ^Speech) ---;

	@(link_name = "TedSid_destroy")
	tedsid_destroy :: proc(aTedSid: ^Ted_Sid) ---;

	@(link_name = "TedSid_create")
	tedsid_create :: proc() -> ^Ted_Sid ---;

	@(link_name = "TedSid_load")
	tedsid_load :: proc(aTedSid: ^Ted_Sid, filename: cstring) -> i32 ---;

	@(link_name = "TedSid_loadToMem")
	tedsid_loadtomem :: proc(aTedSid: ^Ted_Sid, filename: cstring) -> i32 ---;

	@(link_name = "TedSid_loadMem")
	tedsid_loadmem :: proc(aTedSid: ^Ted_Sid, mem: ^byte, length: u32) -> i32 ---;

	@(link_name = "TedSid_loadMemEx")
	tedsid_loadmemex :: proc(aTedSid: ^Ted_Sid, mem: ^byte, length: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "TedSid_loadFileToMem")
	tedsid_loadfiletomem :: proc(aTedSid: ^Ted_Sid, aFile: ^File) -> i32 ---;

	@(link_name = "TedSid_loadFile")
	tedsid_loadfile :: proc(aTedSid: ^Ted_Sid, aFile: ^File) -> i32 ---;

	@(link_name = "TedSid_setVolume")
	tedsid_setvolume :: proc(aTedSid: ^Ted_Sid, volume: f32) ---;

	@(link_name = "TedSid_setLooping")
	tedsid_setlooping :: proc(aTedSid: ^Ted_Sid, loop: i32) ---;

	@(link_name = "TedSid_set3dMinMaxDistance")
	tedsid_set3dminmaxdistance :: proc(aTedSid: ^Ted_Sid, min_distance: f32, max_distance: f32) ---;

	@(link_name = "TedSid_set3dAttenuation")
	tedsid_set3dattenuation :: proc(aTedSid: ^Ted_Sid, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "TedSid_set3dDopplerFactor")
	tedsid_set3ddopplerfactor :: proc(aTedSid: ^Ted_Sid, doppler_effect: f32) ---;

	@(link_name = "TedSid_set3dListenerRelative")
	tedsid_set3dlistenerrelative :: proc(aTedSid: ^Ted_Sid, listener_relative: i32) ---;

	@(link_name = "TedSid_set3dDistanceDelay")
	tedsid_set3ddistancedelay :: proc(aTedSid: ^Ted_Sid, distance_delay: i32) ---;

	@(link_name = "TedSid_set3dCollider")
	tedsid_set3dcollider :: proc(aTedSid: ^Ted_Sid, collider: ^Audio_Collider) ---;

	@(link_name = "TedSid_set3dColliderEx")
	tedsid_set3dcolliderex :: proc(aTedSid: ^Ted_Sid, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "TedSid_set3dAttenuator")
	tedsid_set3dattenuator :: proc(aTedSid: ^Ted_Sid, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "TedSid_setInaudibleBehavior")
	tedsid_setinaudiblebehavior :: proc(aTedSid: ^Ted_Sid, must_tick: i32, kill: i32) ---;

	@(link_name = "TedSid_setLoopPoint")
	tedsid_setlooppoint :: proc(aTedSid: ^Ted_Sid, loop_point: f64) ---;

	@(link_name = "TedSid_getLoopPoint")
	tedsid_getlooppoint :: proc(aTedSid: ^Ted_Sid) -> f64 ---;

	@(link_name = "TedSid_setFilter")
	tedsid_setfilter :: proc(aTedSid: ^Ted_Sid, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "TedSid_stop")
	tedsid_stop :: proc(aTedSid: ^Ted_Sid) ---;

	@(link_name = "Vic_destroy")
	vic_destroy :: proc(vic: ^Vic) ---;

	@(link_name = "Vic_create")
	vic_create :: proc() -> ^Vic ---;

	@(link_name = "Vic_setModel")
	vic_setmodel :: proc(vic: ^Vic, model: i32) ---;

	@(link_name = "Vic_getModel")
	vic_getmodel :: proc(vic: ^Vic) -> i32 ---;

	@(link_name = "Vic_setRegister")
	vic_setregister :: proc(vic: ^Vic, reg: i32, value: byte) ---;

	@(link_name = "Vic_getRegister")
	vic_getregister :: proc(vic: ^Vic, reg: i32) -> byte ---;

	@(link_name = "Vic_setVolume")
	vic_setvolume :: proc(vic: ^Vic, volume: f32) ---;

	@(link_name = "Vic_setLooping")
	vic_setlooping :: proc(vic: ^Vic, loop: i32) ---;

	@(link_name = "Vic_set3dMinMaxDistance")
	vic_set3dminmaxdistance :: proc(vic: ^Vic, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Vic_set3dAttenuation")
	vic_set3dattenuation :: proc(vic: ^Vic, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Vic_set3dDopplerFactor")
	vic_set3ddopplerfactor :: proc(vic: ^Vic, doppler_effect: f32) ---;

	@(link_name = "Vic_set3dListenerRelative")
	vic_set3dlistenerrelative :: proc(vic: ^Vic, listener_relative: i32) ---;

	@(link_name = "Vic_set3dDistanceDelay")
	vic_set3ddistancedelay :: proc(vic: ^Vic, distance_delay: i32) ---;

	@(link_name = "Vic_set3dCollider")
	vic_set3dcollider :: proc(vic: ^Vic, collider: ^Audio_Collider) ---;

	@(link_name = "Vic_set3dColliderEx")
	vic_set3dcolliderex :: proc(vic: ^Vic, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Vic_set3dAttenuator")
	vic_set3dattenuator :: proc(vic: ^Vic, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Vic_setInaudibleBehavior")
	vic_setinaudiblebehavior :: proc(vic: ^Vic, must_tick: i32, kill: i32) ---;

	@(link_name = "Vic_setLoopPoint")
	vic_setlooppoint :: proc(vic: ^Vic, loop_point: f64) ---;

	@(link_name = "Vic_getLoopPoint")
	vic_getlooppoint :: proc(vic: ^Vic) -> f64 ---;

	@(link_name = "Vic_setFilter")
	vic_setfilter :: proc(vic: ^Vic, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Vic_stop")
	vic_stop :: proc(vic: ^Vic) ---;

	@(link_name = "Vizsn_destroy")
	vizsn_destroy :: proc(aVizsn: ^Vizsn) ---;

	@(link_name = "Vizsn_create")
	vizsn_create :: proc() -> ^Vizsn ---;

	@(link_name = "Vizsn_setText")
	vizsn_settext :: proc(aVizsn: ^Vizsn, text: cstring) ---;

	@(link_name = "Vizsn_setVolume")
	vizsn_setvolume :: proc(aVizsn: ^Vizsn, volume: f32) ---;

	@(link_name = "Vizsn_setLooping")
	vizsn_setlooping :: proc(aVizsn: ^Vizsn, loop: i32) ---;

	@(link_name = "Vizsn_set3dMinMaxDistance")
	vizsn_set3dminmaxdistance :: proc(aVizsn: ^Vizsn, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Vizsn_set3dAttenuation")
	vizsn_set3dattenuation :: proc(aVizsn: ^Vizsn, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Vizsn_set3dDopplerFactor")
	vizsn_set3ddopplerfactor :: proc(aVizsn: ^Vizsn, doppler_effect: f32) ---;

	@(link_name = "Vizsn_set3dListenerRelative")
	vizsn_set3dlistenerrelative :: proc(aVizsn: ^Vizsn, listener_relative: i32) ---;

	@(link_name = "Vizsn_set3dDistanceDelay")
	vizsn_set3ddistancedelay :: proc(aVizsn: ^Vizsn, distance_delay: i32) ---;

	@(link_name = "Vizsn_set3dCollider")
	vizsn_set3dcollider :: proc(aVizsn: ^Vizsn, collider: ^Audio_Collider) ---;

	@(link_name = "Vizsn_set3dColliderEx")
	vizsn_set3dcolliderex :: proc(aVizsn: ^Vizsn, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Vizsn_set3dAttenuator")
	vizsn_set3dattenuator :: proc(aVizsn: ^Vizsn, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Vizsn_setInaudibleBehavior")
	vizsn_setinaudiblebehavior :: proc(aVizsn: ^Vizsn, must_tick: i32, kill: i32) ---;

	@(link_name = "Vizsn_setLoopPoint")
	vizsn_setlooppoint :: proc(aVizsn: ^Vizsn, loop_point: f64) ---;

	@(link_name = "Vizsn_getLoopPoint")
	vizsn_getlooppoint :: proc(aVizsn: ^Vizsn) -> f64 ---;

	@(link_name = "Vizsn_setFilter")
	vizsn_setfilter :: proc(aVizsn: ^Vizsn, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Vizsn_stop")
	vizsn_stop :: proc(aVizsn: ^Vizsn) ---;

	@(link_name = "Wav_destroy")
	wav_destroy :: proc(wav: ^Wav) ---;

	@(link_name = "Wav_create")
	wav_create :: proc() -> ^Wav ---;

	@(link_name = "Wav_load")
	wav_load :: proc(wav: ^Wav, filename: cstring) -> i32 ---;

	@(link_name = "Wav_loadMem")
	wav_loadmem :: proc(wav: ^Wav, mem: ^byte, length: u32) -> i32 ---;

	@(link_name = "Wav_loadMemEx")
	wav_loadmemex :: proc(wav: ^Wav, mem: ^byte, length: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "Wav_loadFile")
	wav_loadfile :: proc(wav: ^Wav, aFile: ^File) -> i32 ---;

	@(link_name = "Wav_loadRawWave8")
	wav_loadrawwave8 :: proc(wav: ^Wav, mem: ^byte, length: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave8Ex")
	wav_loadrawwave8ex :: proc(wav: ^Wav, mem: ^byte, length: u32, aSamplerate: f32, channels: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave16")
	wav_loadrawwave16 :: proc(wav: ^Wav, mem: ^i16, length: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave16Ex")
	wav_loadrawwave16ex :: proc(wav: ^Wav, mem: ^i16, length: u32, aSamplerate: f32, channels: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave")
	wav_loadrawwave :: proc(wav: ^Wav, mem: ^f32, length: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWaveEx")
	wav_loadrawwaveex :: proc(wav: ^Wav, mem: ^f32, length: u32, aSamplerate: f32, channels: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "Wav_getLength")
	wav_getlength :: proc(wav: ^Wav) -> f64 ---;

	@(link_name = "Wav_setVolume")
	wav_setvolume :: proc(wav: ^Wav, volume: f32) ---;

	@(link_name = "Wav_setLooping")
	wav_setlooping :: proc(wav: ^Wav, loop: i32) ---;

	@(link_name = "Wav_set3dMinMaxDistance")
	wav_set3dminmaxdistance :: proc(wav: ^Wav, min_distance: f32, max_distance: f32) ---;

	@(link_name = "Wav_set3dAttenuation")
	wav_set3dattenuation :: proc(wav: ^Wav, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "Wav_set3dDopplerFactor")
	wav_set3ddopplerfactor :: proc(wav: ^Wav, doppler_effect: f32) ---;

	@(link_name = "Wav_set3dListenerRelative")
	wav_set3dlistenerrelative :: proc(wav: ^Wav, listener_relative: i32) ---;

	@(link_name = "Wav_set3dDistanceDelay")
	wav_set3ddistancedelay :: proc(wav: ^Wav, distance_delay: i32) ---;

	@(link_name = "Wav_set3dCollider")
	wav_set3dcollider :: proc(wav: ^Wav, collider: ^Audio_Collider) ---;

	@(link_name = "Wav_set3dColliderEx")
	wav_set3dcolliderex :: proc(wav: ^Wav, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "Wav_set3dAttenuator")
	wav_set3dattenuator :: proc(wav: ^Wav, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "Wav_setInaudibleBehavior")
	wav_setinaudiblebehavior :: proc(wav: ^Wav, must_tick: i32, kill: i32) ---;

	@(link_name = "Wav_setLoopPoint")
	wav_setlooppoint :: proc(wav: ^Wav, loop_point: f64) ---;

	@(link_name = "Wav_getLoopPoint")
	wav_getlooppoint :: proc(wav: ^Wav) -> f64 ---;

	@(link_name = "Wav_setFilter")
	wav_setfilter :: proc(wav: ^Wav, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "Wav_stop")
	wav_stop :: proc(wav: ^Wav) ---;

	@(link_name = "WaveShaperFilter_destroy")
	waveshaperfilter_destroy :: proc(wave_shpe_filter: ^Wave_Shaper_Filter) ---;

	@(link_name = "WaveShaperFilter_setParams")
	waveshaperfilter_setparams :: proc(wave_shpe_filter: ^Wave_Shaper_Filter, aAmount: f32) -> i32 ---;

	@(link_name = "WaveShaperFilter_create")
	waveshaperfilter_create :: proc() -> ^Wave_Shaper_Filter ---;

	@(link_name = "WaveShaperFilter_getParamCount")
	waveshaperfilter_getparamcount :: proc(wave_shpe_filter: ^Wave_Shaper_Filter) -> i32 ---;

	@(link_name = "WaveShaperFilter_getParamName")
	waveshaperfilter_getparamname :: proc(wave_shpe_filter: ^Wave_Shaper_Filter, param_index: u32) -> cstring ---;

	@(link_name = "WaveShaperFilter_getParamType")
	waveshaperfilter_getparamtype :: proc(wave_shpe_filter: ^Wave_Shaper_Filter, param_index: u32) -> u32 ---;

	@(link_name = "WaveShaperFilter_getParamMax")
	waveshaperfilter_getparammax :: proc(wave_shpe_filter: ^Wave_Shaper_Filter, param_index: u32) -> f32 ---;

	@(link_name = "WaveShaperFilter_getParamMin")
	waveshaperfilter_getparammin :: proc(wave_shpe_filter: ^Wave_Shaper_Filter, param_index: u32) -> f32 ---;

	@(link_name = "WavStream_destroy")
	wavstream_destroy :: proc(wav_stream: ^Wav_Stream) ---;

	@(link_name = "WavStream_create")
	wavstream_create :: proc() -> ^Wav_Stream ---;

	@(link_name = "WavStream_load")
	wavstream_load :: proc(wav_stream: ^Wav_Stream, filename: cstring) -> i32 ---;

	@(link_name = "WavStream_loadMem")
	wavstream_loadmem :: proc(wav_stream: ^Wav_Stream, data: ^byte, data_len: u32) -> i32 ---;

	@(link_name = "WavStream_loadMemEx")
	wavstream_loadmemex :: proc(wav_stream: ^Wav_Stream, data: ^byte, data_len: u32, copy: i32, take_ownership: i32) -> i32 ---;

	@(link_name = "WavStream_loadToMem")
	wavstream_loadtomem :: proc(wav_stream: ^Wav_Stream, filename: cstring) -> i32 ---;

	@(link_name = "WavStream_loadFile")
	wavstream_loadfile :: proc(wav_stream: ^Wav_Stream, aFile: ^File) -> i32 ---;

	@(link_name = "WavStream_loadFileToMem")
	wavstream_loadfiletomem :: proc(wav_stream: ^Wav_Stream, aFile: ^File) -> i32 ---;

	@(link_name = "WavStream_getLength")
	wavstream_getlength :: proc(wav_stream: ^Wav_Stream) -> f64 ---;

	@(link_name = "WavStream_setVolume")
	wavstream_setvolume :: proc(wav_stream: ^Wav_Stream, volume: f32) ---;

	@(link_name = "WavStream_setLooping")
	wavstream_setlooping :: proc(wav_stream: ^Wav_Stream, loop: i32) ---;

	@(link_name = "WavStream_set3dMinMaxDistance")
	wavstream_set3dminmaxdistance :: proc(wav_stream: ^Wav_Stream, min_distance: f32, max_distance: f32) ---;

	@(link_name = "WavStream_set3dAttenuation")
	wavstream_set3dattenuation :: proc(wav_stream: ^Wav_Stream, attenuation_model: u32, atten_rolloff_factor: f32) ---;

	@(link_name = "WavStream_set3dDopplerFactor")
	wavstream_set3ddopplerfactor :: proc(wav_stream: ^Wav_Stream, doppler_effect: f32) ---;

	@(link_name = "WavStream_set3dListenerRelative")
	wavstream_set3dlistenerrelative :: proc(wav_stream: ^Wav_Stream, listener_relative: i32) ---;

	@(link_name = "WavStream_set3dDistanceDelay")
	wavstream_set3ddistancedelay :: proc(wav_stream: ^Wav_Stream, distance_delay: i32) ---;

	@(link_name = "WavStream_set3dCollider")
	wavstream_set3dcollider :: proc(wav_stream: ^Wav_Stream, collider: ^Audio_Collider) ---;

	@(link_name = "WavStream_set3dColliderEx")
	wavstream_set3dcolliderex :: proc(wav_stream: ^Wav_Stream, collider: ^Audio_Collider, user_data: i32) ---;

	@(link_name = "WavStream_set3dAttenuator")
	wavstream_set3dattenuator :: proc(wav_stream: ^Wav_Stream, attenuator: ^Audio_Attenuator) ---;

	@(link_name = "WavStream_setInaudibleBehavior")
	wavstream_setinaudiblebehavior :: proc(wav_stream: ^Wav_Stream, must_tick: i32, kill: i32) ---;

	@(link_name = "WavStream_setLoopPoint")
	wavstream_setlooppoint :: proc(wav_stream: ^Wav_Stream, loop_point: f64) ---;

	@(link_name = "WavStream_getLoopPoint")
	wavstream_getlooppoint :: proc(wav_stream: ^Wav_Stream) -> f64 ---;

	@(link_name = "WavStream_setFilter")
	wavstream_setfilter :: proc(wav_stream: ^Wav_Stream, filter_id: u32, filter: ^Filter) ---;

	@(link_name = "WavStream_stop")
	wavstream_stop :: proc(wav_stream: ^Wav_Stream) ---;
}

