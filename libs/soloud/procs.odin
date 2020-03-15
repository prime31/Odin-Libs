package soloud

when ODIN_OS == "darwin" do foreign import lib "native/libsoloud.dylib";

foreign lib {
	@(link_name = "Soloud_destroy")
	destroy :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_create")
	create :: proc() -> ^Soloud ---;

	@(link_name = "Soloud_init")
	init :: proc(soloud: ^Soloud) -> i32 ---;

	@(link_name = "Soloud_initEx")
	init_ex :: proc(soloud: ^Soloud, aFlags: u32, aBackend: u32, aSamplerate: u32, aBufferSize: u32, aChannels: u32) -> i32 ---;

	@(link_name = "Soloud_deinit")
	deinit :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_getVersion")
	get_version :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getErrorString")
	get_error_string :: proc(soloud: ^Soloud, aErrorCode: i32) -> cstring ---;

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
	set_speaker_position :: proc(soloud: ^Soloud, aChannel: u32, aX: f32, aY: f32, aZ: f32) -> i32 ---;

	@(link_name = "Soloud_getSpeakerPosition")
	get_speaker_position :: proc(soloud: ^Soloud, aChannel: u32, aX: ^f32, aY: ^f32, aZ: ^f32) -> i32 ---;

	@(link_name = "Soloud_play")
	play :: proc(soloud: ^Soloud, aSound: ^Audio_Source) -> u32 ---;

	@(link_name = "Soloud_playEx")
	play_ex :: proc(soloud: ^Soloud, aSound: ^Audio_Source, aVolume: f32, aPan: f32, aPaused: i32, aBus: u32) -> u32 ---;

	@(link_name = "Soloud_playClocked")
	play_clocked :: proc(soloud: ^Soloud, aSoundTime: f64, aSound: ^Audio_Source) -> u32 ---;

	@(link_name = "Soloud_playClockedEx")
	play_clocked_ex :: proc(soloud: ^Soloud, aSoundTime: f64, aSound: ^Audio_Source, aVolume: f32, aPan: f32, aBus: u32) -> u32 ---;

	@(link_name = "Soloud_play3d")
	play3d :: proc(soloud: ^Soloud, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---;

	@(link_name = "Soloud_play3dEx")
	play3d_ex :: proc(soloud: ^Soloud, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32, aVelX: f32, aVelY: f32, aVelZ: f32, aVolume: f32, aPaused: i32, aBus: u32) -> u32 ---;

	@(link_name = "Soloud_play3dClocked")
	play3d_clocked :: proc(soloud: ^Soloud, aSoundTime: f64, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---;

	@(link_name = "Soloud_play3dClockedEx")
	play3d_clocked_ex :: proc(soloud: ^Soloud, aSoundTime: f64, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32, aVelX: f32, aVelY: f32, aVelZ: f32, aVolume: f32, aBus: u32) -> u32 ---;

	@(link_name = "Soloud_playBackground")
	play_background :: proc(soloud: ^Soloud, aSound: ^Audio_Source) -> u32 ---;

	@(link_name = "Soloud_playBackgroundEx")
	play_background_ex :: proc(soloud: ^Soloud, aSound: ^Audio_Source, aVolume: f32, aPaused: i32, aBus: u32) -> u32 ---;

	@(link_name = "Soloud_seek")
	seek :: proc(soloud: ^Soloud, aVoiceHandle: u32, aSeconds: f64) -> i32 ---;

	@(link_name = "Soloud_stop")
	stop :: proc(soloud: ^Soloud, aVoiceHandle: u32) ---;

	@(link_name = "Soloud_stopAll")
	stop_all :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_stopAudioSource")
	stop_audio_source :: proc(soloud: ^Soloud, aSound: ^Audio_Source) ---;

	@(link_name = "Soloud_countAudioSource")
	count_audio_source :: proc(soloud: ^Soloud, aSound: ^Audio_Source) -> i32 ---;

	@(link_name = "Soloud_setFilterParameter")
	set_filter_parameter :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32, aValue: f32) ---;

	@(link_name = "Soloud_getFilterParameter")
	get_filter_parameter :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32) -> f32 ---;

	@(link_name = "Soloud_fadeFilterParameter")
	fade_filter_parameter :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_oscillateFilterParameter")
	oscillate_filter_parameter :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFilterId: u32, aAttributeId: u32, aFrom: f32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_getStreamTime")
	get_stream_time :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f64 ---;

	@(link_name = "Soloud_getStreamPosition")
	get_stream_position :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f64 ---;

	@(link_name = "Soloud_getPause")
	get_pause :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> i32 ---;

	@(link_name = "Soloud_getVolume")
	get_volume :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f32 ---;

	@(link_name = "Soloud_getOverallVolume")
	get_overall_volume :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f32 ---;

	@(link_name = "Soloud_getPan")
	get_pan :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f32 ---;

	@(link_name = "Soloud_getSamplerate")
	get_samplerate :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f32 ---;

	@(link_name = "Soloud_getProtectVoice")
	get_protect_voice :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> i32 ---;

	@(link_name = "Soloud_getActiveVoiceCount")
	get_active_voice_count :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getVoiceCount")
	get_voice_count :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_isValidVoiceHandle")
	is_valid_voice_handle :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> i32 ---;

	@(link_name = "Soloud_getRelativePlaySpeed")
	get_relative_play_speed :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f32 ---;

	@(link_name = "Soloud_getPostClipScaler")
	get_post_clip_scaler :: proc(soloud: ^Soloud) -> f32 ---;

	@(link_name = "Soloud_getMainResampler")
	get_main_resampler :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getGlobalVolume")
	get_global_volume :: proc(soloud: ^Soloud) -> f32 ---;

	@(link_name = "Soloud_getMaxActiveVoiceCount")
	get_max_active_voice_count :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_getLooping")
	get_looping :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> i32 ---;

	@(link_name = "Soloud_getLoopPoint")
	get_loop_point :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> f64 ---;

	@(link_name = "Soloud_setLoopPoint")
	set_loop_point :: proc(soloud: ^Soloud, aVoiceHandle: u32, aLoopPoint: f64) ---;

	@(link_name = "Soloud_setLooping")
	set_looping :: proc(soloud: ^Soloud, aVoiceHandle: u32, aLooping: i32) ---;

	@(link_name = "Soloud_setMaxActiveVoiceCount")
	set_max_active_voice_count :: proc(soloud: ^Soloud, aVoiceCount: u32) -> i32 ---;

	@(link_name = "Soloud_setInaudibleBehavior")
	set_inaudible_behavior :: proc(soloud: ^Soloud, aVoiceHandle: u32, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Soloud_setGlobalVolume")
	set_global_volume :: proc(soloud: ^Soloud, aVolume: f32) ---;

	@(link_name = "Soloud_setPostClipScaler")
	set_post_clip_scaler :: proc(soloud: ^Soloud, aScaler: f32) ---;

	@(link_name = "Soloud_setMainResampler")
	set_main_resampler :: proc(soloud: ^Soloud, aResampler: u32) ---;

	@(link_name = "Soloud_setPause")
	set_pause :: proc(soloud: ^Soloud, aVoiceHandle: u32, aPause: i32) ---;

	@(link_name = "Soloud_setPauseAll")
	set_pause_all :: proc(soloud: ^Soloud, aPause: i32) ---;

	@(link_name = "Soloud_setRelativePlaySpeed")
	set_relative_play_speed :: proc(soloud: ^Soloud, aVoiceHandle: u32, aSpeed: f32) -> i32 ---;

	@(link_name = "Soloud_setProtectVoice")
	set_protect_voice :: proc(soloud: ^Soloud, aVoiceHandle: u32, aProtect: i32) ---;

	@(link_name = "Soloud_setSamplerate")
	set_samplerate :: proc(soloud: ^Soloud, aVoiceHandle: u32, aSamplerate: f32) ---;

	@(link_name = "Soloud_setPan")
	set_pan :: proc(soloud: ^Soloud, aVoiceHandle: u32, aPan: f32) ---;

	@(link_name = "Soloud_setPanAbsolute")
	set_pan_absolute :: proc(soloud: ^Soloud, aVoiceHandle: u32, aLVolume: f32, aRVolume: f32) ---;

	@(link_name = "Soloud_setChannelVolume")
	set_channel_volume :: proc(soloud: ^Soloud, aVoiceHandle: u32, aChannel: u32, aVolume: f32) ---;

	@(link_name = "Soloud_setVolume")
	set_volume :: proc(soloud: ^Soloud, aVoiceHandle: u32, aVolume: f32) ---;

	@(link_name = "Soloud_setDelaySamples")
	set_delay_samples :: proc(soloud: ^Soloud, aVoiceHandle: u32, aSamples: u32) ---;

	@(link_name = "Soloud_fadeVolume")
	fade_volume :: proc(soloud: ^Soloud, aVoiceHandle: u32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_fadePan")
	fade_pan :: proc(soloud: ^Soloud, aVoiceHandle: u32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_fadeRelativePlaySpeed")
	fade_relative_play_speed :: proc(soloud: ^Soloud, aVoiceHandle: u32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_fadeGlobalVolume")
	fade_global_volume :: proc(soloud: ^Soloud, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_schedulePause")
	schedule_pause :: proc(soloud: ^Soloud, aVoiceHandle: u32, aTime: f64) ---;

	@(link_name = "Soloud_scheduleStop")
	schedule_stop :: proc(soloud: ^Soloud, aVoiceHandle: u32, aTime: f64) ---;

	@(link_name = "Soloud_oscillateVolume")
	oscillate_volume :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFrom: f32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_oscillatePan")
	oscillate_pan :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFrom: f32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_oscillateRelativePlaySpeed")
	oscillate_relative_play_speed :: proc(soloud: ^Soloud, aVoiceHandle: u32, aFrom: f32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_oscillateGlobalVolume")
	oscillate_global_volume :: proc(soloud: ^Soloud, aFrom: f32, aTo: f32, aTime: f64) ---;

	@(link_name = "Soloud_setGlobalFilter")
	set_global_filter :: proc(soloud: ^Soloud, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Soloud_setVisualizationEnable")
	set_visualization_enable :: proc(soloud: ^Soloud, aEnable: i32) ---;

	@(link_name = "Soloud_calcFFT")
	calc_f_f_t :: proc(soloud: ^Soloud) -> ^f32 ---;

	@(link_name = "Soloud_getWave")
	get_wave :: proc(soloud: ^Soloud) -> ^f32 ---;

	@(link_name = "Soloud_getApproximateVolume")
	get_approximate_volume :: proc(soloud: ^Soloud, aChannel: u32) -> f32 ---;

	@(link_name = "Soloud_getLoopCount")
	get_loop_count :: proc(soloud: ^Soloud, aVoiceHandle: u32) -> u32 ---;

	@(link_name = "Soloud_getInfo")
	get_info :: proc(soloud: ^Soloud, aVoiceHandle: u32, aInfoKey: u32) -> f32 ---;

	@(link_name = "Soloud_createVoiceGroup")
	create_voice_group :: proc(soloud: ^Soloud) -> u32 ---;

	@(link_name = "Soloud_destroyVoiceGroup")
	destroy_voice_group :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 ---;

	@(link_name = "Soloud_addVoiceToGroup")
	add_voice_to_group :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32, aVoiceHandle: u32) -> i32 ---;

	@(link_name = "Soloud_isVoiceGroup")
	is_voice_group :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 ---;

	@(link_name = "Soloud_isVoiceGroupEmpty")
	is_voice_group_empty :: proc(soloud: ^Soloud, aVoiceGroupHandle: u32) -> i32 ---;

	@(link_name = "Soloud_update3dAudio")
	update3d_audio :: proc(soloud: ^Soloud) ---;

	@(link_name = "Soloud_set3dSoundSpeed")
	set3d_sound_speed :: proc(soloud: ^Soloud, aSpeed: f32) -> i32 ---;

	@(link_name = "Soloud_get3dSoundSpeed")
	get3d_sound_speed :: proc(soloud: ^Soloud) -> f32 ---;

	@(link_name = "Soloud_set3dListenerParameters")
	set3d_listener_parameters :: proc(soloud: ^Soloud, aPosX: f32, aPosY: f32, aPosZ: f32, aAtX: f32, aAtY: f32, aAtZ: f32, aUpX: f32, aUpY: f32, aUpZ: f32) ---;

	@(link_name = "Soloud_set3dListenerParametersEx")
	set3d_listener_parameters_ex :: proc(soloud: ^Soloud, aPosX: f32, aPosY: f32, aPosZ: f32, aAtX: f32, aAtY: f32, aAtZ: f32, aUpX: f32, aUpY: f32, aUpZ: f32, aVelocityX: f32, aVelocityY: f32, aVelocityZ: f32) ---;

	@(link_name = "Soloud_set3dListenerPosition")
	set3d_listener_position :: proc(soloud: ^Soloud, aPosX: f32, aPosY: f32, aPosZ: f32) ---;

	@(link_name = "Soloud_set3dListenerAt")
	set3d_listener_at :: proc(soloud: ^Soloud, aAtX: f32, aAtY: f32, aAtZ: f32) ---;

	@(link_name = "Soloud_set3dListenerUp")
	set3d_listener_up :: proc(soloud: ^Soloud, aUpX: f32, aUpY: f32, aUpZ: f32) ---;

	@(link_name = "Soloud_set3dListenerVelocity")
	set3d_listener_velocity :: proc(soloud: ^Soloud, aVelocityX: f32, aVelocityY: f32, aVelocityZ: f32) ---;

	@(link_name = "Soloud_set3dSourceParameters")
	set3d_source_parameters :: proc(soloud: ^Soloud, aVoiceHandle: u32, aPosX: f32, aPosY: f32, aPosZ: f32) ---;

	@(link_name = "Soloud_set3dSourceParametersEx")
	set3d_source_parameters_ex :: proc(soloud: ^Soloud, aVoiceHandle: u32, aPosX: f32, aPosY: f32, aPosZ: f32, aVelocityX: f32, aVelocityY: f32, aVelocityZ: f32) ---;

	@(link_name = "Soloud_set3dSourcePosition")
	set3d_source_position :: proc(soloud: ^Soloud, aVoiceHandle: u32, aPosX: f32, aPosY: f32, aPosZ: f32) ---;

	@(link_name = "Soloud_set3dSourceVelocity")
	set3d_source_velocity :: proc(soloud: ^Soloud, aVoiceHandle: u32, aVelocityX: f32, aVelocityY: f32, aVelocityZ: f32) ---;

	@(link_name = "Soloud_set3dSourceMinMaxDistance")
	set3d_source_min_max_distance :: proc(soloud: ^Soloud, aVoiceHandle: u32, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Soloud_set3dSourceAttenuation")
	set3d_source_attenuation :: proc(soloud: ^Soloud, aVoiceHandle: u32, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Soloud_set3dSourceDopplerFactor")
	set3d_source_doppler_factor :: proc(soloud: ^Soloud, aVoiceHandle: u32, aDopplerFactor: f32) ---;

	@(link_name = "Soloud_mix")
	mix :: proc(soloud: ^Soloud, aBuffer: ^f32, aSamples: u32) ---;

	@(link_name = "Soloud_mixSigned16")
	mix_signed16 :: proc(soloud: ^Soloud, aBuffer: ^i16, aSamples: u32) ---;

	@(link_name = "BassboostFilter_destroy")
	bassboostfilter_destroy :: proc(aBassboostFilter: ^Bassboost_Filter) ---;

	@(link_name = "BassboostFilter_getParamCount")
	bassboostfilter_getparamcount :: proc(aBassboostFilter: ^Bassboost_Filter) -> i32 ---;

	@(link_name = "BassboostFilter_getParamName")
	bassboostfilter_getparamname :: proc(aBassboostFilter: ^Bassboost_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "BassboostFilter_getParamType")
	bassboostfilter_getparamtype :: proc(aBassboostFilter: ^Bassboost_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "BassboostFilter_getParamMax")
	bassboostfilter_getparammax :: proc(aBassboostFilter: ^Bassboost_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "BassboostFilter_getParamMin")
	bassboostfilter_getparammin :: proc(aBassboostFilter: ^Bassboost_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "BassboostFilter_setParams")
	bassboostfilter_setparams :: proc(aBassboostFilter: ^Bassboost_Filter, aBoost: f32) -> i32 ---;

	@(link_name = "BassboostFilter_create")
	bassboostfilter_create :: proc() -> ^Bassboost_Filter ---;

	@(link_name = "BiquadResonantFilter_destroy")
	biquadresonantfilter_destroy :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter) ---;

	@(link_name = "BiquadResonantFilter_getParamCount")
	biquadresonantfilter_getparamcount :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter) -> i32 ---;

	@(link_name = "BiquadResonantFilter_getParamName")
	biquadresonantfilter_getparamname :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "BiquadResonantFilter_getParamType")
	biquadresonantfilter_getparamtype :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "BiquadResonantFilter_getParamMax")
	biquadresonantfilter_getparammax :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "BiquadResonantFilter_getParamMin")
	biquadresonantfilter_getparammin :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "BiquadResonantFilter_create")
	biquadresonantfilter_create :: proc() -> ^Biquad_Resonant_Filter ---;

	@(link_name = "BiquadResonantFilter_setParams")
	biquadresonantfilter_setparams :: proc(aBiquadResonantFilter: ^Biquad_Resonant_Filter, aType: i32, aFrequency: f32, aResonance: f32) -> i32 ---;

	@(link_name = "Bus_destroy")
	bus_destroy :: proc(aBus: ^Bus) ---;

	@(link_name = "Bus_create")
	bus_create :: proc() -> ^Bus ---;

	@(link_name = "Bus_setFilter")
	bus_setfilter :: proc(aBus: ^Bus, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Bus_play")
	bus_play :: proc(aBus: ^Bus, aSound: ^Audio_Source) -> u32 ---;

	@(link_name = "Bus_playEx")
	bus_playex :: proc(aBus: ^Bus, aSound: ^Audio_Source, aVolume: f32, aPan: f32, aPaused: i32) -> u32 ---;

	@(link_name = "Bus_playClocked")
	bus_playclocked :: proc(aBus: ^Bus, aSoundTime: f64, aSound: ^Audio_Source) -> u32 ---;

	@(link_name = "Bus_playClockedEx")
	bus_playclockedex :: proc(aBus: ^Bus, aSoundTime: f64, aSound: ^Audio_Source, aVolume: f32, aPan: f32) -> u32 ---;

	@(link_name = "Bus_play3d")
	bus_play3d :: proc(aBus: ^Bus, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---;

	@(link_name = "Bus_play3dEx")
	bus_play3dex :: proc(aBus: ^Bus, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32, aVelX: f32, aVelY: f32, aVelZ: f32, aVolume: f32, aPaused: i32) -> u32 ---;

	@(link_name = "Bus_play3dClocked")
	bus_play3dclocked :: proc(aBus: ^Bus, aSoundTime: f64, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32) -> u32 ---;

	@(link_name = "Bus_play3dClockedEx")
	bus_play3dclockedex :: proc(aBus: ^Bus, aSoundTime: f64, aSound: ^Audio_Source, aPosX: f32, aPosY: f32, aPosZ: f32, aVelX: f32, aVelY: f32, aVelZ: f32, aVolume: f32) -> u32 ---;

	@(link_name = "Bus_setChannels")
	bus_setchannels :: proc(aBus: ^Bus, aChannels: u32) -> i32 ---;

	@(link_name = "Bus_setVisualizationEnable")
	bus_setvisualizationenable :: proc(aBus: ^Bus, aEnable: i32) ---;

	@(link_name = "Bus_annexSound")
	bus_annexsound :: proc(aBus: ^Bus, aVoiceHandle: u32) ---;

	@(link_name = "Bus_calcFFT")
	bus_calcfft :: proc(aBus: ^Bus) -> ^f32 ---;

	@(link_name = "Bus_getWave")
	bus_getwave :: proc(aBus: ^Bus) -> ^f32 ---;

	@(link_name = "Bus_getApproximateVolume")
	bus_getapproximatevolume :: proc(aBus: ^Bus, aChannel: u32) -> f32 ---;

	@(link_name = "Bus_getActiveVoiceCount")
	bus_getactivevoicecount :: proc(aBus: ^Bus) -> u32 ---;

	@(link_name = "Bus_getResampler")
	bus_getresampler :: proc(aBus: ^Bus) -> u32 ---;

	@(link_name = "Bus_setResampler")
	bus_setresampler :: proc(aBus: ^Bus, aResampler: u32) ---;

	@(link_name = "Bus_setVolume")
	bus_setvolume :: proc(aBus: ^Bus, aVolume: f32) ---;

	@(link_name = "Bus_setLooping")
	bus_setlooping :: proc(aBus: ^Bus, aLoop: i32) ---;

	@(link_name = "Bus_set3dMinMaxDistance")
	bus_set3dminmaxdistance :: proc(aBus: ^Bus, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Bus_set3dAttenuation")
	bus_set3dattenuation :: proc(aBus: ^Bus, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Bus_set3dDopplerFactor")
	bus_set3ddopplerfactor :: proc(aBus: ^Bus, aDopplerFactor: f32) ---;

	@(link_name = "Bus_set3dListenerRelative")
	bus_set3dlistenerrelative :: proc(aBus: ^Bus, aListenerRelative: i32) ---;

	@(link_name = "Bus_set3dDistanceDelay")
	bus_set3ddistancedelay :: proc(aBus: ^Bus, aDistanceDelay: i32) ---;

	@(link_name = "Bus_set3dCollider")
	bus_set3dcollider :: proc(aBus: ^Bus, aCollider: ^Audio_Collider) ---;

	@(link_name = "Bus_set3dColliderEx")
	bus_set3dcolliderex :: proc(aBus: ^Bus, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Bus_set3dAttenuator")
	bus_set3dattenuator :: proc(aBus: ^Bus, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Bus_setInaudibleBehavior")
	bus_setinaudiblebehavior :: proc(aBus: ^Bus, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Bus_setLoopPoint")
	bus_setlooppoint :: proc(aBus: ^Bus, aLoopPoint: f64) ---;

	@(link_name = "Bus_getLoopPoint")
	bus_getlooppoint :: proc(aBus: ^Bus) -> f64 ---;

	@(link_name = "Bus_stop")
	bus_stop :: proc(aBus: ^Bus) ---;

	@(link_name = "DCRemovalFilter_destroy")
	dcremovalfilter_destroy :: proc(aDCRemovalFilter: ^Dc_Removal_Filter) ---;

	@(link_name = "DCRemovalFilter_create")
	dcremovalfilter_create :: proc() -> ^Dc_Removal_Filter ---;

	@(link_name = "DCRemovalFilter_setParams")
	dcremovalfilter_setparams :: proc(aDCRemovalFilter: ^Dc_Removal_Filter) -> i32 ---;

	@(link_name = "DCRemovalFilter_setParamsEx")
	dcremovalfilter_setparamsex :: proc(aDCRemovalFilter: ^Dc_Removal_Filter, aLength: f32) -> i32 ---;

	@(link_name = "DCRemovalFilter_getParamCount")
	dcremovalfilter_getparamcount :: proc(aDCRemovalFilter: ^Dc_Removal_Filter) -> i32 ---;

	@(link_name = "DCRemovalFilter_getParamName")
	dcremovalfilter_getparamname :: proc(aDCRemovalFilter: ^Dc_Removal_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "DCRemovalFilter_getParamType")
	dcremovalfilter_getparamtype :: proc(aDCRemovalFilter: ^Dc_Removal_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "DCRemovalFilter_getParamMax")
	dcremovalfilter_getparammax :: proc(aDCRemovalFilter: ^Dc_Removal_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "DCRemovalFilter_getParamMin")
	dcremovalfilter_getparammin :: proc(aDCRemovalFilter: ^Dc_Removal_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "EchoFilter_destroy")
	echofilter_destroy :: proc(aEchoFilter: ^Echo_Filter) ---;

	@(link_name = "EchoFilter_getParamCount")
	echofilter_getparamcount :: proc(aEchoFilter: ^Echo_Filter) -> i32 ---;

	@(link_name = "EchoFilter_getParamName")
	echofilter_getparamname :: proc(aEchoFilter: ^Echo_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "EchoFilter_getParamType")
	echofilter_getparamtype :: proc(aEchoFilter: ^Echo_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "EchoFilter_getParamMax")
	echofilter_getparammax :: proc(aEchoFilter: ^Echo_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "EchoFilter_getParamMin")
	echofilter_getparammin :: proc(aEchoFilter: ^Echo_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "EchoFilter_create")
	echofilter_create :: proc() -> ^Echo_Filter ---;

	@(link_name = "EchoFilter_setParams")
	echofilter_setparams :: proc(aEchoFilter: ^Echo_Filter, aDelay: f32) -> i32 ---;

	@(link_name = "EchoFilter_setParamsEx")
	echofilter_setparamsex :: proc(aEchoFilter: ^Echo_Filter, aDelay: f32, aDecay: f32, aFilter: f32) -> i32 ---;

	@(link_name = "FFTFilter_destroy")
	fftfilter_destroy :: proc(aFFTFilter: ^Fft_Filter) ---;

	@(link_name = "FFTFilter_create")
	fftfilter_create :: proc() -> ^Fft_Filter ---;

	@(link_name = "FFTFilter_getParamCount")
	fftfilter_getparamcount :: proc(aFFTFilter: ^Fft_Filter) -> i32 ---;

	@(link_name = "FFTFilter_getParamName")
	fftfilter_getparamname :: proc(aFFTFilter: ^Fft_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "FFTFilter_getParamType")
	fftfilter_getparamtype :: proc(aFFTFilter: ^Fft_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "FFTFilter_getParamMax")
	fftfilter_getparammax :: proc(aFFTFilter: ^Fft_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "FFTFilter_getParamMin")
	fftfilter_getparammin :: proc(aFFTFilter: ^Fft_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "FlangerFilter_destroy")
	flangerfilter_destroy :: proc(aFlangerFilter: ^Flanger_Filter) ---;

	@(link_name = "FlangerFilter_getParamCount")
	flangerfilter_getparamcount :: proc(aFlangerFilter: ^Flanger_Filter) -> i32 ---;

	@(link_name = "FlangerFilter_getParamName")
	flangerfilter_getparamname :: proc(aFlangerFilter: ^Flanger_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "FlangerFilter_getParamType")
	flangerfilter_getparamtype :: proc(aFlangerFilter: ^Flanger_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "FlangerFilter_getParamMax")
	flangerfilter_getparammax :: proc(aFlangerFilter: ^Flanger_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "FlangerFilter_getParamMin")
	flangerfilter_getparammin :: proc(aFlangerFilter: ^Flanger_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "FlangerFilter_create")
	flangerfilter_create :: proc() -> ^Flanger_Filter ---;

	@(link_name = "FlangerFilter_setParams")
	flangerfilter_setparams :: proc(aFlangerFilter: ^Flanger_Filter, aDelay: f32, aFreq: f32) -> i32 ---;

	@(link_name = "FreeverbFilter_destroy")
	freeverbfilter_destroy :: proc(aFreeverbFilter: ^Freeverb_Filter) ---;

	@(link_name = "FreeverbFilter_getParamCount")
	freeverbfilter_getparamcount :: proc(aFreeverbFilter: ^Freeverb_Filter) -> i32 ---;

	@(link_name = "FreeverbFilter_getParamName")
	freeverbfilter_getparamname :: proc(aFreeverbFilter: ^Freeverb_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "FreeverbFilter_getParamType")
	freeverbfilter_getparamtype :: proc(aFreeverbFilter: ^Freeverb_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "FreeverbFilter_getParamMax")
	freeverbfilter_getparammax :: proc(aFreeverbFilter: ^Freeverb_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "FreeverbFilter_getParamMin")
	freeverbfilter_getparammin :: proc(aFreeverbFilter: ^Freeverb_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "FreeverbFilter_create")
	freeverbfilter_create :: proc() -> ^Freeverb_Filter ---;

	@(link_name = "FreeverbFilter_setParams")
	freeverbfilter_setparams :: proc(aFreeverbFilter: ^Freeverb_Filter, aMode: f32, aRoomSize: f32, aDamp: f32, aWidth: f32) -> i32 ---;

	@(link_name = "LofiFilter_destroy")
	lofifilter_destroy :: proc(aLofiFilter: ^Lofi_Filter) ---;

	@(link_name = "LofiFilter_getParamCount")
	lofifilter_getparamcount :: proc(aLofiFilter: ^Lofi_Filter) -> i32 ---;

	@(link_name = "LofiFilter_getParamName")
	lofifilter_getparamname :: proc(aLofiFilter: ^Lofi_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "LofiFilter_getParamType")
	lofifilter_getparamtype :: proc(aLofiFilter: ^Lofi_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "LofiFilter_getParamMax")
	lofifilter_getparammax :: proc(aLofiFilter: ^Lofi_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "LofiFilter_getParamMin")
	lofifilter_getparammin :: proc(aLofiFilter: ^Lofi_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "LofiFilter_create")
	lofifilter_create :: proc() -> ^Lofi_Filter ---;

	@(link_name = "LofiFilter_setParams")
	lofifilter_setparams :: proc(aLofiFilter: ^Lofi_Filter, aSampleRate: f32, aBitdepth: f32) -> i32 ---;

	@(link_name = "Monotone_destroy")
	monotone_destroy :: proc(aMonotone: ^Monotone) ---;

	@(link_name = "Monotone_create")
	monotone_create :: proc() -> ^Monotone ---;

	@(link_name = "Monotone_setParams")
	monotone_setparams :: proc(aMonotone: ^Monotone, aHardwareChannels: i32) -> i32 ---;

	@(link_name = "Monotone_setParamsEx")
	monotone_setparamsex :: proc(aMonotone: ^Monotone, aHardwareChannels: i32, aWaveform: i32) -> i32 ---;

	@(link_name = "Monotone_load")
	monotone_load :: proc(aMonotone: ^Monotone, aFilename: cstring) -> i32 ---;

	@(link_name = "Monotone_loadMem")
	monotone_loadmem :: proc(aMonotone: ^Monotone, aMem: ^byte, aLength: u32) -> i32 ---;

	@(link_name = "Monotone_loadMemEx")
	monotone_loadmemex :: proc(aMonotone: ^Monotone, aMem: ^byte, aLength: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "Monotone_loadFile")
	monotone_loadfile :: proc(aMonotone: ^Monotone, aFile: ^File) -> i32 ---;

	@(link_name = "Monotone_setVolume")
	monotone_setvolume :: proc(aMonotone: ^Monotone, aVolume: f32) ---;

	@(link_name = "Monotone_setLooping")
	monotone_setlooping :: proc(aMonotone: ^Monotone, aLoop: i32) ---;

	@(link_name = "Monotone_set3dMinMaxDistance")
	monotone_set3dminmaxdistance :: proc(aMonotone: ^Monotone, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Monotone_set3dAttenuation")
	monotone_set3dattenuation :: proc(aMonotone: ^Monotone, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Monotone_set3dDopplerFactor")
	monotone_set3ddopplerfactor :: proc(aMonotone: ^Monotone, aDopplerFactor: f32) ---;

	@(link_name = "Monotone_set3dListenerRelative")
	monotone_set3dlistenerrelative :: proc(aMonotone: ^Monotone, aListenerRelative: i32) ---;

	@(link_name = "Monotone_set3dDistanceDelay")
	monotone_set3ddistancedelay :: proc(aMonotone: ^Monotone, aDistanceDelay: i32) ---;

	@(link_name = "Monotone_set3dCollider")
	monotone_set3dcollider :: proc(aMonotone: ^Monotone, aCollider: ^Audio_Collider) ---;

	@(link_name = "Monotone_set3dColliderEx")
	monotone_set3dcolliderex :: proc(aMonotone: ^Monotone, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Monotone_set3dAttenuator")
	monotone_set3dattenuator :: proc(aMonotone: ^Monotone, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Monotone_setInaudibleBehavior")
	monotone_setinaudiblebehavior :: proc(aMonotone: ^Monotone, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Monotone_setLoopPoint")
	monotone_setlooppoint :: proc(aMonotone: ^Monotone, aLoopPoint: f64) ---;

	@(link_name = "Monotone_getLoopPoint")
	monotone_getlooppoint :: proc(aMonotone: ^Monotone) -> f64 ---;

	@(link_name = "Monotone_setFilter")
	monotone_setfilter :: proc(aMonotone: ^Monotone, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Monotone_stop")
	monotone_stop :: proc(aMonotone: ^Monotone) ---;

	@(link_name = "Noise_destroy")
	noise_destroy :: proc(aNoise: ^Noise) ---;

	@(link_name = "Noise_create")
	noise_create :: proc() -> ^Noise ---;

	@(link_name = "Noise_setOctaveScale")
	noise_setoctavescale :: proc(aNoise: ^Noise, aOct0: f32, aOct1: f32, aOct2: f32, aOct3: f32, aOct4: f32, aOct5: f32, aOct6: f32, aOct7: f32, aOct8: f32, aOct9: f32) ---;

	@(link_name = "Noise_setType")
	noise_settype :: proc(aNoise: ^Noise, aType: i32) ---;

	@(link_name = "Noise_setVolume")
	noise_setvolume :: proc(aNoise: ^Noise, aVolume: f32) ---;

	@(link_name = "Noise_setLooping")
	noise_setlooping :: proc(aNoise: ^Noise, aLoop: i32) ---;

	@(link_name = "Noise_set3dMinMaxDistance")
	noise_set3dminmaxdistance :: proc(aNoise: ^Noise, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Noise_set3dAttenuation")
	noise_set3dattenuation :: proc(aNoise: ^Noise, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Noise_set3dDopplerFactor")
	noise_set3ddopplerfactor :: proc(aNoise: ^Noise, aDopplerFactor: f32) ---;

	@(link_name = "Noise_set3dListenerRelative")
	noise_set3dlistenerrelative :: proc(aNoise: ^Noise, aListenerRelative: i32) ---;

	@(link_name = "Noise_set3dDistanceDelay")
	noise_set3ddistancedelay :: proc(aNoise: ^Noise, aDistanceDelay: i32) ---;

	@(link_name = "Noise_set3dCollider")
	noise_set3dcollider :: proc(aNoise: ^Noise, aCollider: ^Audio_Collider) ---;

	@(link_name = "Noise_set3dColliderEx")
	noise_set3dcolliderex :: proc(aNoise: ^Noise, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Noise_set3dAttenuator")
	noise_set3dattenuator :: proc(aNoise: ^Noise, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Noise_setInaudibleBehavior")
	noise_setinaudiblebehavior :: proc(aNoise: ^Noise, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Noise_setLoopPoint")
	noise_setlooppoint :: proc(aNoise: ^Noise, aLoopPoint: f64) ---;

	@(link_name = "Noise_getLoopPoint")
	noise_getlooppoint :: proc(aNoise: ^Noise) -> f64 ---;

	@(link_name = "Noise_setFilter")
	noise_setfilter :: proc(aNoise: ^Noise, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Noise_stop")
	noise_stop :: proc(aNoise: ^Noise) ---;

	@(link_name = "Openmpt_destroy")
	openmpt_destroy :: proc(aOpenmpt: ^Openmpt) ---;

	@(link_name = "Openmpt_create")
	openmpt_create :: proc() -> ^Openmpt ---;

	@(link_name = "Openmpt_load")
	openmpt_load :: proc(aOpenmpt: ^Openmpt, aFilename: cstring) -> i32 ---;

	@(link_name = "Openmpt_loadMem")
	openmpt_loadmem :: proc(aOpenmpt: ^Openmpt, aMem: ^byte, aLength: u32) -> i32 ---;

	@(link_name = "Openmpt_loadMemEx")
	openmpt_loadmemex :: proc(aOpenmpt: ^Openmpt, aMem: ^byte, aLength: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "Openmpt_loadFile")
	openmpt_loadfile :: proc(aOpenmpt: ^Openmpt, aFile: ^File) -> i32 ---;

	@(link_name = "Openmpt_setVolume")
	openmpt_setvolume :: proc(aOpenmpt: ^Openmpt, aVolume: f32) ---;

	@(link_name = "Openmpt_setLooping")
	openmpt_setlooping :: proc(aOpenmpt: ^Openmpt, aLoop: i32) ---;

	@(link_name = "Openmpt_set3dMinMaxDistance")
	openmpt_set3dminmaxdistance :: proc(aOpenmpt: ^Openmpt, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Openmpt_set3dAttenuation")
	openmpt_set3dattenuation :: proc(aOpenmpt: ^Openmpt, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Openmpt_set3dDopplerFactor")
	openmpt_set3ddopplerfactor :: proc(aOpenmpt: ^Openmpt, aDopplerFactor: f32) ---;

	@(link_name = "Openmpt_set3dListenerRelative")
	openmpt_set3dlistenerrelative :: proc(aOpenmpt: ^Openmpt, aListenerRelative: i32) ---;

	@(link_name = "Openmpt_set3dDistanceDelay")
	openmpt_set3ddistancedelay :: proc(aOpenmpt: ^Openmpt, aDistanceDelay: i32) ---;

	@(link_name = "Openmpt_set3dCollider")
	openmpt_set3dcollider :: proc(aOpenmpt: ^Openmpt, aCollider: ^Audio_Collider) ---;

	@(link_name = "Openmpt_set3dColliderEx")
	openmpt_set3dcolliderex :: proc(aOpenmpt: ^Openmpt, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Openmpt_set3dAttenuator")
	openmpt_set3dattenuator :: proc(aOpenmpt: ^Openmpt, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Openmpt_setInaudibleBehavior")
	openmpt_setinaudiblebehavior :: proc(aOpenmpt: ^Openmpt, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Openmpt_setLoopPoint")
	openmpt_setlooppoint :: proc(aOpenmpt: ^Openmpt, aLoopPoint: f64) ---;

	@(link_name = "Openmpt_getLoopPoint")
	openmpt_getlooppoint :: proc(aOpenmpt: ^Openmpt) -> f64 ---;

	@(link_name = "Openmpt_setFilter")
	openmpt_setfilter :: proc(aOpenmpt: ^Openmpt, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Openmpt_stop")
	openmpt_stop :: proc(aOpenmpt: ^Openmpt) ---;

	@(link_name = "Queue_destroy")
	queue_destroy :: proc(aQueue: ^Queue) ---;

	@(link_name = "Queue_create")
	queue_create :: proc() -> ^Queue ---;

	@(link_name = "Queue_play")
	queue_play :: proc(aQueue: ^Queue, aSound: ^Audio_Source) -> i32 ---;

	@(link_name = "Queue_getQueueCount")
	queue_getqueuecount :: proc(aQueue: ^Queue) -> u32 ---;

	@(link_name = "Queue_isCurrentlyPlaying")
	queue_iscurrentlyplaying :: proc(aQueue: ^Queue, aSound: ^Audio_Source) -> i32 ---;

	@(link_name = "Queue_setParamsFromAudioSource")
	queue_setparamsfromaudiosource :: proc(aQueue: ^Queue, aSound: ^Audio_Source) -> i32 ---;

	@(link_name = "Queue_setParams")
	queue_setparams :: proc(aQueue: ^Queue, aSamplerate: f32) -> i32 ---;

	@(link_name = "Queue_setParamsEx")
	queue_setparamsex :: proc(aQueue: ^Queue, aSamplerate: f32, aChannels: u32) -> i32 ---;

	@(link_name = "Queue_setVolume")
	queue_setvolume :: proc(aQueue: ^Queue, aVolume: f32) ---;

	@(link_name = "Queue_setLooping")
	queue_setlooping :: proc(aQueue: ^Queue, aLoop: i32) ---;

	@(link_name = "Queue_set3dMinMaxDistance")
	queue_set3dminmaxdistance :: proc(aQueue: ^Queue, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Queue_set3dAttenuation")
	queue_set3dattenuation :: proc(aQueue: ^Queue, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Queue_set3dDopplerFactor")
	queue_set3ddopplerfactor :: proc(aQueue: ^Queue, aDopplerFactor: f32) ---;

	@(link_name = "Queue_set3dListenerRelative")
	queue_set3dlistenerrelative :: proc(aQueue: ^Queue, aListenerRelative: i32) ---;

	@(link_name = "Queue_set3dDistanceDelay")
	queue_set3ddistancedelay :: proc(aQueue: ^Queue, aDistanceDelay: i32) ---;

	@(link_name = "Queue_set3dCollider")
	queue_set3dcollider :: proc(aQueue: ^Queue, aCollider: ^Audio_Collider) ---;

	@(link_name = "Queue_set3dColliderEx")
	queue_set3dcolliderex :: proc(aQueue: ^Queue, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Queue_set3dAttenuator")
	queue_set3dattenuator :: proc(aQueue: ^Queue, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Queue_setInaudibleBehavior")
	queue_setinaudiblebehavior :: proc(aQueue: ^Queue, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Queue_setLoopPoint")
	queue_setlooppoint :: proc(aQueue: ^Queue, aLoopPoint: f64) ---;

	@(link_name = "Queue_getLoopPoint")
	queue_getlooppoint :: proc(aQueue: ^Queue) -> f64 ---;

	@(link_name = "Queue_setFilter")
	queue_setfilter :: proc(aQueue: ^Queue, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Queue_stop")
	queue_stop :: proc(aQueue: ^Queue) ---;

	@(link_name = "RobotizeFilter_destroy")
	robotizefilter_destroy :: proc(aRobotizeFilter: ^Robotize_Filter) ---;

	@(link_name = "RobotizeFilter_getParamCount")
	robotizefilter_getparamcount :: proc(aRobotizeFilter: ^Robotize_Filter) -> i32 ---;

	@(link_name = "RobotizeFilter_getParamName")
	robotizefilter_getparamname :: proc(aRobotizeFilter: ^Robotize_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "RobotizeFilter_getParamType")
	robotizefilter_getparamtype :: proc(aRobotizeFilter: ^Robotize_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "RobotizeFilter_getParamMax")
	robotizefilter_getparammax :: proc(aRobotizeFilter: ^Robotize_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "RobotizeFilter_getParamMin")
	robotizefilter_getparammin :: proc(aRobotizeFilter: ^Robotize_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "RobotizeFilter_setParams")
	robotizefilter_setparams :: proc(aRobotizeFilter: ^Robotize_Filter, aFreq: f32, aWaveform: i32) ---;

	@(link_name = "RobotizeFilter_create")
	robotizefilter_create :: proc() -> ^Robotize_Filter ---;

	@(link_name = "Sfxr_destroy")
	sfxr_destroy :: proc(aSfxr: ^Sfxr) ---;

	@(link_name = "Sfxr_create")
	sfxr_create :: proc() -> ^Sfxr ---;

	@(link_name = "Sfxr_resetParams")
	sfxr_resetparams :: proc(aSfxr: ^Sfxr) ---;

	@(link_name = "Sfxr_loadParams")
	sfxr_loadparams :: proc(aSfxr: ^Sfxr, aFilename: cstring) -> i32 ---;

	@(link_name = "Sfxr_loadParamsMem")
	sfxr_loadparamsmem :: proc(aSfxr: ^Sfxr, aMem: ^byte, aLength: u32) -> i32 ---;

	@(link_name = "Sfxr_loadParamsMemEx")
	sfxr_loadparamsmemex :: proc(aSfxr: ^Sfxr, aMem: ^byte, aLength: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "Sfxr_loadParamsFile")
	sfxr_loadparamsfile :: proc(aSfxr: ^Sfxr, aFile: ^File) -> i32 ---;

	@(link_name = "Sfxr_loadPreset")
	sfxr_loadpreset :: proc(aSfxr: ^Sfxr, aPresetNo: i32, aRandSeed: i32) -> i32 ---;

	@(link_name = "Sfxr_setVolume")
	sfxr_setvolume :: proc(aSfxr: ^Sfxr, aVolume: f32) ---;

	@(link_name = "Sfxr_setLooping")
	sfxr_setlooping :: proc(aSfxr: ^Sfxr, aLoop: i32) ---;

	@(link_name = "Sfxr_set3dMinMaxDistance")
	sfxr_set3dminmaxdistance :: proc(aSfxr: ^Sfxr, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Sfxr_set3dAttenuation")
	sfxr_set3dattenuation :: proc(aSfxr: ^Sfxr, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Sfxr_set3dDopplerFactor")
	sfxr_set3ddopplerfactor :: proc(aSfxr: ^Sfxr, aDopplerFactor: f32) ---;

	@(link_name = "Sfxr_set3dListenerRelative")
	sfxr_set3dlistenerrelative :: proc(aSfxr: ^Sfxr, aListenerRelative: i32) ---;

	@(link_name = "Sfxr_set3dDistanceDelay")
	sfxr_set3ddistancedelay :: proc(aSfxr: ^Sfxr, aDistanceDelay: i32) ---;

	@(link_name = "Sfxr_set3dCollider")
	sfxr_set3dcollider :: proc(aSfxr: ^Sfxr, aCollider: ^Audio_Collider) ---;

	@(link_name = "Sfxr_set3dColliderEx")
	sfxr_set3dcolliderex :: proc(aSfxr: ^Sfxr, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Sfxr_set3dAttenuator")
	sfxr_set3dattenuator :: proc(aSfxr: ^Sfxr, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Sfxr_setInaudibleBehavior")
	sfxr_setinaudiblebehavior :: proc(aSfxr: ^Sfxr, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Sfxr_setLoopPoint")
	sfxr_setlooppoint :: proc(aSfxr: ^Sfxr, aLoopPoint: f64) ---;

	@(link_name = "Sfxr_getLoopPoint")
	sfxr_getlooppoint :: proc(aSfxr: ^Sfxr) -> f64 ---;

	@(link_name = "Sfxr_setFilter")
	sfxr_setfilter :: proc(aSfxr: ^Sfxr, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Sfxr_stop")
	sfxr_stop :: proc(aSfxr: ^Sfxr) ---;

	@(link_name = "Speech_destroy")
	speech_destroy :: proc(aSpeech: ^Speech) ---;

	@(link_name = "Speech_create")
	speech_create :: proc() -> ^Speech ---;

	@(link_name = "Speech_setText")
	speech_settext :: proc(aSpeech: ^Speech, aText: cstring) -> i32 ---;

	@(link_name = "Speech_setParams")
	speech_setparams :: proc(aSpeech: ^Speech) -> i32 ---;

	@(link_name = "Speech_setParamsEx")
	speech_setparamsex :: proc(aSpeech: ^Speech, aBaseFrequency: u32, aBaseSpeed: f32, aBaseDeclination: f32, aBaseWaveform: i32) -> i32 ---;

	@(link_name = "Speech_setVolume")
	speech_setvolume :: proc(aSpeech: ^Speech, aVolume: f32) ---;

	@(link_name = "Speech_setLooping")
	speech_setlooping :: proc(aSpeech: ^Speech, aLoop: i32) ---;

	@(link_name = "Speech_set3dMinMaxDistance")
	speech_set3dminmaxdistance :: proc(aSpeech: ^Speech, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Speech_set3dAttenuation")
	speech_set3dattenuation :: proc(aSpeech: ^Speech, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Speech_set3dDopplerFactor")
	speech_set3ddopplerfactor :: proc(aSpeech: ^Speech, aDopplerFactor: f32) ---;

	@(link_name = "Speech_set3dListenerRelative")
	speech_set3dlistenerrelative :: proc(aSpeech: ^Speech, aListenerRelative: i32) ---;

	@(link_name = "Speech_set3dDistanceDelay")
	speech_set3ddistancedelay :: proc(aSpeech: ^Speech, aDistanceDelay: i32) ---;

	@(link_name = "Speech_set3dCollider")
	speech_set3dcollider :: proc(aSpeech: ^Speech, aCollider: ^Audio_Collider) ---;

	@(link_name = "Speech_set3dColliderEx")
	speech_set3dcolliderex :: proc(aSpeech: ^Speech, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Speech_set3dAttenuator")
	speech_set3dattenuator :: proc(aSpeech: ^Speech, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Speech_setInaudibleBehavior")
	speech_setinaudiblebehavior :: proc(aSpeech: ^Speech, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Speech_setLoopPoint")
	speech_setlooppoint :: proc(aSpeech: ^Speech, aLoopPoint: f64) ---;

	@(link_name = "Speech_getLoopPoint")
	speech_getlooppoint :: proc(aSpeech: ^Speech) -> f64 ---;

	@(link_name = "Speech_setFilter")
	speech_setfilter :: proc(aSpeech: ^Speech, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Speech_stop")
	speech_stop :: proc(aSpeech: ^Speech) ---;

	@(link_name = "TedSid_destroy")
	tedsid_destroy :: proc(aTedSid: ^Ted_Sid) ---;

	@(link_name = "TedSid_create")
	tedsid_create :: proc() -> ^Ted_Sid ---;

	@(link_name = "TedSid_load")
	tedsid_load :: proc(aTedSid: ^Ted_Sid, aFilename: cstring) -> i32 ---;

	@(link_name = "TedSid_loadToMem")
	tedsid_loadtomem :: proc(aTedSid: ^Ted_Sid, aFilename: cstring) -> i32 ---;

	@(link_name = "TedSid_loadMem")
	tedsid_loadmem :: proc(aTedSid: ^Ted_Sid, aMem: ^byte, aLength: u32) -> i32 ---;

	@(link_name = "TedSid_loadMemEx")
	tedsid_loadmemex :: proc(aTedSid: ^Ted_Sid, aMem: ^byte, aLength: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "TedSid_loadFileToMem")
	tedsid_loadfiletomem :: proc(aTedSid: ^Ted_Sid, aFile: ^File) -> i32 ---;

	@(link_name = "TedSid_loadFile")
	tedsid_loadfile :: proc(aTedSid: ^Ted_Sid, aFile: ^File) -> i32 ---;

	@(link_name = "TedSid_setVolume")
	tedsid_setvolume :: proc(aTedSid: ^Ted_Sid, aVolume: f32) ---;

	@(link_name = "TedSid_setLooping")
	tedsid_setlooping :: proc(aTedSid: ^Ted_Sid, aLoop: i32) ---;

	@(link_name = "TedSid_set3dMinMaxDistance")
	tedsid_set3dminmaxdistance :: proc(aTedSid: ^Ted_Sid, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "TedSid_set3dAttenuation")
	tedsid_set3dattenuation :: proc(aTedSid: ^Ted_Sid, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "TedSid_set3dDopplerFactor")
	tedsid_set3ddopplerfactor :: proc(aTedSid: ^Ted_Sid, aDopplerFactor: f32) ---;

	@(link_name = "TedSid_set3dListenerRelative")
	tedsid_set3dlistenerrelative :: proc(aTedSid: ^Ted_Sid, aListenerRelative: i32) ---;

	@(link_name = "TedSid_set3dDistanceDelay")
	tedsid_set3ddistancedelay :: proc(aTedSid: ^Ted_Sid, aDistanceDelay: i32) ---;

	@(link_name = "TedSid_set3dCollider")
	tedsid_set3dcollider :: proc(aTedSid: ^Ted_Sid, aCollider: ^Audio_Collider) ---;

	@(link_name = "TedSid_set3dColliderEx")
	tedsid_set3dcolliderex :: proc(aTedSid: ^Ted_Sid, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "TedSid_set3dAttenuator")
	tedsid_set3dattenuator :: proc(aTedSid: ^Ted_Sid, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "TedSid_setInaudibleBehavior")
	tedsid_setinaudiblebehavior :: proc(aTedSid: ^Ted_Sid, aMustTick: i32, aKill: i32) ---;

	@(link_name = "TedSid_setLoopPoint")
	tedsid_setlooppoint :: proc(aTedSid: ^Ted_Sid, aLoopPoint: f64) ---;

	@(link_name = "TedSid_getLoopPoint")
	tedsid_getlooppoint :: proc(aTedSid: ^Ted_Sid) -> f64 ---;

	@(link_name = "TedSid_setFilter")
	tedsid_setfilter :: proc(aTedSid: ^Ted_Sid, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "TedSid_stop")
	tedsid_stop :: proc(aTedSid: ^Ted_Sid) ---;

	@(link_name = "Vic_destroy")
	vic_destroy :: proc(aVic: ^Vic) ---;

	@(link_name = "Vic_create")
	vic_create :: proc() -> ^Vic ---;

	@(link_name = "Vic_setModel")
	vic_setmodel :: proc(aVic: ^Vic, model: i32) ---;

	@(link_name = "Vic_getModel")
	vic_getmodel :: proc(aVic: ^Vic) -> i32 ---;

	@(link_name = "Vic_setRegister")
	vic_setregister :: proc(aVic: ^Vic, reg: i32, value: byte) ---;

	@(link_name = "Vic_getRegister")
	vic_getregister :: proc(aVic: ^Vic, reg: i32) -> byte ---;

	@(link_name = "Vic_setVolume")
	vic_setvolume :: proc(aVic: ^Vic, aVolume: f32) ---;

	@(link_name = "Vic_setLooping")
	vic_setlooping :: proc(aVic: ^Vic, aLoop: i32) ---;

	@(link_name = "Vic_set3dMinMaxDistance")
	vic_set3dminmaxdistance :: proc(aVic: ^Vic, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Vic_set3dAttenuation")
	vic_set3dattenuation :: proc(aVic: ^Vic, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Vic_set3dDopplerFactor")
	vic_set3ddopplerfactor :: proc(aVic: ^Vic, aDopplerFactor: f32) ---;

	@(link_name = "Vic_set3dListenerRelative")
	vic_set3dlistenerrelative :: proc(aVic: ^Vic, aListenerRelative: i32) ---;

	@(link_name = "Vic_set3dDistanceDelay")
	vic_set3ddistancedelay :: proc(aVic: ^Vic, aDistanceDelay: i32) ---;

	@(link_name = "Vic_set3dCollider")
	vic_set3dcollider :: proc(aVic: ^Vic, aCollider: ^Audio_Collider) ---;

	@(link_name = "Vic_set3dColliderEx")
	vic_set3dcolliderex :: proc(aVic: ^Vic, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Vic_set3dAttenuator")
	vic_set3dattenuator :: proc(aVic: ^Vic, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Vic_setInaudibleBehavior")
	vic_setinaudiblebehavior :: proc(aVic: ^Vic, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Vic_setLoopPoint")
	vic_setlooppoint :: proc(aVic: ^Vic, aLoopPoint: f64) ---;

	@(link_name = "Vic_getLoopPoint")
	vic_getlooppoint :: proc(aVic: ^Vic) -> f64 ---;

	@(link_name = "Vic_setFilter")
	vic_setfilter :: proc(aVic: ^Vic, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Vic_stop")
	vic_stop :: proc(aVic: ^Vic) ---;

	@(link_name = "Vizsn_destroy")
	vizsn_destroy :: proc(aVizsn: ^Vizsn) ---;

	@(link_name = "Vizsn_create")
	vizsn_create :: proc() -> ^Vizsn ---;

	@(link_name = "Vizsn_setText")
	vizsn_settext :: proc(aVizsn: ^Vizsn, aText: cstring) ---;

	@(link_name = "Vizsn_setVolume")
	vizsn_setvolume :: proc(aVizsn: ^Vizsn, aVolume: f32) ---;

	@(link_name = "Vizsn_setLooping")
	vizsn_setlooping :: proc(aVizsn: ^Vizsn, aLoop: i32) ---;

	@(link_name = "Vizsn_set3dMinMaxDistance")
	vizsn_set3dminmaxdistance :: proc(aVizsn: ^Vizsn, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Vizsn_set3dAttenuation")
	vizsn_set3dattenuation :: proc(aVizsn: ^Vizsn, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Vizsn_set3dDopplerFactor")
	vizsn_set3ddopplerfactor :: proc(aVizsn: ^Vizsn, aDopplerFactor: f32) ---;

	@(link_name = "Vizsn_set3dListenerRelative")
	vizsn_set3dlistenerrelative :: proc(aVizsn: ^Vizsn, aListenerRelative: i32) ---;

	@(link_name = "Vizsn_set3dDistanceDelay")
	vizsn_set3ddistancedelay :: proc(aVizsn: ^Vizsn, aDistanceDelay: i32) ---;

	@(link_name = "Vizsn_set3dCollider")
	vizsn_set3dcollider :: proc(aVizsn: ^Vizsn, aCollider: ^Audio_Collider) ---;

	@(link_name = "Vizsn_set3dColliderEx")
	vizsn_set3dcolliderex :: proc(aVizsn: ^Vizsn, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Vizsn_set3dAttenuator")
	vizsn_set3dattenuator :: proc(aVizsn: ^Vizsn, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Vizsn_setInaudibleBehavior")
	vizsn_setinaudiblebehavior :: proc(aVizsn: ^Vizsn, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Vizsn_setLoopPoint")
	vizsn_setlooppoint :: proc(aVizsn: ^Vizsn, aLoopPoint: f64) ---;

	@(link_name = "Vizsn_getLoopPoint")
	vizsn_getlooppoint :: proc(aVizsn: ^Vizsn) -> f64 ---;

	@(link_name = "Vizsn_setFilter")
	vizsn_setfilter :: proc(aVizsn: ^Vizsn, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Vizsn_stop")
	vizsn_stop :: proc(aVizsn: ^Vizsn) ---;

	@(link_name = "Wav_destroy")
	wav_destroy :: proc(aWav: ^Wav) ---;

	@(link_name = "Wav_create")
	wav_create :: proc() -> ^Wav ---;

	@(link_name = "Wav_load")
	wav_load :: proc(aWav: ^Wav, aFilename: cstring) -> i32 ---;

	@(link_name = "Wav_loadMem")
	wav_loadmem :: proc(aWav: ^Wav, aMem: ^byte, aLength: u32) -> i32 ---;

	@(link_name = "Wav_loadMemEx")
	wav_loadmemex :: proc(aWav: ^Wav, aMem: ^byte, aLength: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "Wav_loadFile")
	wav_loadfile :: proc(aWav: ^Wav, aFile: ^File) -> i32 ---;

	@(link_name = "Wav_loadRawWave8")
	wav_loadrawwave8 :: proc(aWav: ^Wav, aMem: ^byte, aLength: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave8Ex")
	wav_loadrawwave8ex :: proc(aWav: ^Wav, aMem: ^byte, aLength: u32, aSamplerate: f32, aChannels: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave16")
	wav_loadrawwave16 :: proc(aWav: ^Wav, aMem: ^i16, aLength: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave16Ex")
	wav_loadrawwave16ex :: proc(aWav: ^Wav, aMem: ^i16, aLength: u32, aSamplerate: f32, aChannels: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWave")
	wav_loadrawwave :: proc(aWav: ^Wav, aMem: ^f32, aLength: u32) -> i32 ---;

	@(link_name = "Wav_loadRawWaveEx")
	wav_loadrawwaveex :: proc(aWav: ^Wav, aMem: ^f32, aLength: u32, aSamplerate: f32, aChannels: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "Wav_getLength")
	wav_getlength :: proc(aWav: ^Wav) -> f64 ---;

	@(link_name = "Wav_setVolume")
	wav_setvolume :: proc(aWav: ^Wav, aVolume: f32) ---;

	@(link_name = "Wav_setLooping")
	wav_setlooping :: proc(aWav: ^Wav, aLoop: i32) ---;

	@(link_name = "Wav_set3dMinMaxDistance")
	wav_set3dminmaxdistance :: proc(aWav: ^Wav, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "Wav_set3dAttenuation")
	wav_set3dattenuation :: proc(aWav: ^Wav, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "Wav_set3dDopplerFactor")
	wav_set3ddopplerfactor :: proc(aWav: ^Wav, aDopplerFactor: f32) ---;

	@(link_name = "Wav_set3dListenerRelative")
	wav_set3dlistenerrelative :: proc(aWav: ^Wav, aListenerRelative: i32) ---;

	@(link_name = "Wav_set3dDistanceDelay")
	wav_set3ddistancedelay :: proc(aWav: ^Wav, aDistanceDelay: i32) ---;

	@(link_name = "Wav_set3dCollider")
	wav_set3dcollider :: proc(aWav: ^Wav, aCollider: ^Audio_Collider) ---;

	@(link_name = "Wav_set3dColliderEx")
	wav_set3dcolliderex :: proc(aWav: ^Wav, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "Wav_set3dAttenuator")
	wav_set3dattenuator :: proc(aWav: ^Wav, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "Wav_setInaudibleBehavior")
	wav_setinaudiblebehavior :: proc(aWav: ^Wav, aMustTick: i32, aKill: i32) ---;

	@(link_name = "Wav_setLoopPoint")
	wav_setlooppoint :: proc(aWav: ^Wav, aLoopPoint: f64) ---;

	@(link_name = "Wav_getLoopPoint")
	wav_getlooppoint :: proc(aWav: ^Wav) -> f64 ---;

	@(link_name = "Wav_setFilter")
	wav_setfilter :: proc(aWav: ^Wav, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "Wav_stop")
	wav_stop :: proc(aWav: ^Wav) ---;

	@(link_name = "WaveShaperFilter_destroy")
	waveshaperfilter_destroy :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter) ---;

	@(link_name = "WaveShaperFilter_setParams")
	waveshaperfilter_setparams :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter, aAmount: f32) -> i32 ---;

	@(link_name = "WaveShaperFilter_create")
	waveshaperfilter_create :: proc() -> ^Wave_Shaper_Filter ---;

	@(link_name = "WaveShaperFilter_getParamCount")
	waveshaperfilter_getparamcount :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter) -> i32 ---;

	@(link_name = "WaveShaperFilter_getParamName")
	waveshaperfilter_getparamname :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter, aParamIndex: u32) -> cstring ---;

	@(link_name = "WaveShaperFilter_getParamType")
	waveshaperfilter_getparamtype :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter, aParamIndex: u32) -> u32 ---;

	@(link_name = "WaveShaperFilter_getParamMax")
	waveshaperfilter_getparammax :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "WaveShaperFilter_getParamMin")
	waveshaperfilter_getparammin :: proc(aWaveShaperFilter: ^Wave_Shaper_Filter, aParamIndex: u32) -> f32 ---;

	@(link_name = "WavStream_destroy")
	wavstream_destroy :: proc(aWavStream: ^Wav_Stream) ---;

	@(link_name = "WavStream_create")
	wavstream_create :: proc() -> ^Wav_Stream ---;

	@(link_name = "WavStream_load")
	wavstream_load :: proc(aWavStream: ^Wav_Stream, aFilename: cstring) -> i32 ---;

	@(link_name = "WavStream_loadMem")
	wavstream_loadmem :: proc(aWavStream: ^Wav_Stream, aData: ^byte, aDataLen: u32) -> i32 ---;

	@(link_name = "WavStream_loadMemEx")
	wavstream_loadmemex :: proc(aWavStream: ^Wav_Stream, aData: ^byte, aDataLen: u32, aCopy: i32, aTakeOwnership: i32) -> i32 ---;

	@(link_name = "WavStream_loadToMem")
	wavstream_loadtomem :: proc(aWavStream: ^Wav_Stream, aFilename: cstring) -> i32 ---;

	@(link_name = "WavStream_loadFile")
	wavstream_loadfile :: proc(aWavStream: ^Wav_Stream, aFile: ^File) -> i32 ---;

	@(link_name = "WavStream_loadFileToMem")
	wavstream_loadfiletomem :: proc(aWavStream: ^Wav_Stream, aFile: ^File) -> i32 ---;

	@(link_name = "WavStream_getLength")
	wavstream_getlength :: proc(aWavStream: ^Wav_Stream) -> f64 ---;

	@(link_name = "WavStream_setVolume")
	wavstream_setvolume :: proc(aWavStream: ^Wav_Stream, aVolume: f32) ---;

	@(link_name = "WavStream_setLooping")
	wavstream_setlooping :: proc(aWavStream: ^Wav_Stream, aLoop: i32) ---;

	@(link_name = "WavStream_set3dMinMaxDistance")
	wavstream_set3dminmaxdistance :: proc(aWavStream: ^Wav_Stream, aMinDistance: f32, aMaxDistance: f32) ---;

	@(link_name = "WavStream_set3dAttenuation")
	wavstream_set3dattenuation :: proc(aWavStream: ^Wav_Stream, aAttenuationModel: u32, aAttenuationRolloffFactor: f32) ---;

	@(link_name = "WavStream_set3dDopplerFactor")
	wavstream_set3ddopplerfactor :: proc(aWavStream: ^Wav_Stream, aDopplerFactor: f32) ---;

	@(link_name = "WavStream_set3dListenerRelative")
	wavstream_set3dlistenerrelative :: proc(aWavStream: ^Wav_Stream, aListenerRelative: i32) ---;

	@(link_name = "WavStream_set3dDistanceDelay")
	wavstream_set3ddistancedelay :: proc(aWavStream: ^Wav_Stream, aDistanceDelay: i32) ---;

	@(link_name = "WavStream_set3dCollider")
	wavstream_set3dcollider :: proc(aWavStream: ^Wav_Stream, aCollider: ^Audio_Collider) ---;

	@(link_name = "WavStream_set3dColliderEx")
	wavstream_set3dcolliderex :: proc(aWavStream: ^Wav_Stream, aCollider: ^Audio_Collider, aUserData: i32) ---;

	@(link_name = "WavStream_set3dAttenuator")
	wavstream_set3dattenuator :: proc(aWavStream: ^Wav_Stream, aAttenuator: ^Audio_Attenuator) ---;

	@(link_name = "WavStream_setInaudibleBehavior")
	wavstream_setinaudiblebehavior :: proc(aWavStream: ^Wav_Stream, aMustTick: i32, aKill: i32) ---;

	@(link_name = "WavStream_setLoopPoint")
	wavstream_setlooppoint :: proc(aWavStream: ^Wav_Stream, aLoopPoint: f64) ---;

	@(link_name = "WavStream_getLoopPoint")
	wavstream_getlooppoint :: proc(aWavStream: ^Wav_Stream) -> f64 ---;

	@(link_name = "WavStream_setFilter")
	wavstream_setfilter :: proc(aWavStream: ^Wav_Stream, aFilterId: u32, aFilter: ^Filter) ---;

	@(link_name = "WavStream_stop")
	wavstream_stop :: proc(aWavStream: ^Wav_Stream) ---;
}

