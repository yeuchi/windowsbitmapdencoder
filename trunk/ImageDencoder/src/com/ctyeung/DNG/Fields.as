package com.ctyeung.DNG
{
	import com.ctyeung.TIFF6.Fields;
	
	public class Fields extends com.ctyeung.TIFF6.Fields
	{
		// 254	NewSubfileType 
		public static const DNG_RAW:uint				= 1;		// see DNG

		// 259	Compression	
		public static const DNG_JPEG_CMPRSSN:uint 		= 7;		// DNG JPEG

		// 262	PhotometricInterpretation
		public static const COLOR_FILTER_ARRAY:uint		= 32803;	// CFA
		public static const LINEAR_RAW					= 34892;	// demosaiced
	
		// 50706 (C612H)	DNG Version
		public static const DNG_VERSION:uint			= 50706;
	
		// 50707 (C613H)	DNG Backward Version
		public static const DNG_BACK_VERSION:uint		= 50707;
		
		// 50708 (C614H)	Unique Camera Model
		public static const UNIQUE_CAMERA_MODEL:uint 	= 50708;
		
		// 50709 (C615H)	Localized Camera Model
		public static const LOCAL_CAMERA_MODEL:uint  	= 50709;

		// 50710 (C616H)	CFA Plane Color
		public static const CFA_PLANE_COLOR:uint		= 50710;
		public static const PLANE_RED:uint				= 0;
		public static const PLANE_GREEN:uint			= 1;
		public static const PLANE_BLUE:uint				= 2;

		// 50711 (C617H)	CFA Layout
		public static const CFA_LAYOUT:uint				= 50711;
		public static const LAYOUT_RECT:uint			= 1;
		public static const LAYOUT_A:uint				= 2;
		public static const LAYOUT_B:uint				= 3;
		public static const LAYOUT_C:uint				= 4;
		public static const LAYOUT_D:uint				= 5;
		// added for version 1.3.0.0
		public static const LAYOUT_E:uint				= 6;
		public static const LAYOUT_F:uint				= 7;
		public static const LAYOUT_G:uint				= 8;
		public static const LAYOUT_H:uint				= 9;
	
		// 50712 (C618H)	Linearization table
		public static const LINEARIZATION_TABLE:uint	= 50712;
		
		// 50713 (C619H)	Black level repeat dim
		public static const BLACK_LEVEL_REPEAT_DIM:uint	= 50713;
		public static const BLACK_LEVEL_REPEAT_ROWS:uint = 0;
		public static const BLACK_LEVEL_REPEAT_COLS:uint = 1;

		// 50714 (C61AH)	Black level 
		public static const BLACK_LEVEL:uint			= 50714;

		// 50716 (C61CH)	Black level delta V
		public static const BLACK_LEVEL_DELTAV:uint		= 50716;
	
		// 50717 (C61DH)	White level 
		public static const WHITE_LEVEL:uint			= 50717;

		// 50718 (C61EH)	Default Scale  
		public static const DEFAULT_SCALE:uint			= 50718;

		// 50780 (C65CH)	Best quality scale  
		public static const BEST_QUAL_SCALE:uint		= 50780;

		// 50719 (C61FH)	Default crop origin  
		public static const DEFAULT_CROP_ORIGIN:uint	= 50719;

		// 50720 (C620H)	Default crop size 
		public static const DEFAULT_CROP_SIZE:uint		= 50720;

		// 50778 (C65AH)	Calibration Illuminant 1
		public static const CALIB_ILLUM_1:uint			= 50778;

		// 50779 (C65BH)	Calibration Illuminant 2
		public static const CALIB_ILLUM_2:uint			= 50778;

		// 50721 (C621H)	Color matrix 1
		public static const COLOR_MATRIX_1:uint			= 50721;

		// 50722 (C622H)	Color matrix 2
		public static const COLOR_MATRIX_2:uint			= 50722;

		// 50723 (C623H)	Camera calibration 1
		public static const CAMERA_CALIB_1:uint			= 50723;

		// 50724 (C624H)	Camera calibration 2
		public static const CAMERA_CALIB_2:uint			= 50724;

		// 50725 (C625H)	Reduction matrix 1
		public static const REDUCTION_MATRIX_1:uint		= 50725;

		// 50726 (C626H)	Reduction matrix 1
		public static const REDUCTION_MATRIX_2:uint		= 50726;
	
		// 50727 (C627H)	Analog balance
		public static const ANALOG_BALANCE:uint			= 50727;

		// 50728 (C628H)	As shot neutral
		public static const AS_SHOT_NEUTRAL:uint		= 50728;

		// 50729 (C629H)	As shot white XY
		public static const AS_SHOT_WHITE_XY:uint		= 50729;

		// 50730 (C62AH)	Baseline exposure
		public static const BASELINE_EXPOSURE:uint		= 50730;

		// 50731 (C62BH)	Baseline noise
		public static const BASELINE_NOISE:uint			= 50731;

		// 50732 (C62CH)	Baseline sharpness
		public static const BASELINE_SHARPNESS:uint		= 50732;

		// 50733 (C62DH)	Bayer green split
		public static const BAYER_GREEN_SPLIT:uint		= 50733;

		// 50734 (C62EH)	Linear response limit
		public static const LINEAR_RESPONSE_LIMIT:uint	= 50734;

		// 50735 (C62FH)	Camera serial number
		public static const CAMERA_SERIAL_NUM:uint		= 50735;
		
		// 50736 (C630H)	Lens info
		public static const LENS_INFO:uint				= 50736;

		// 50737 (C631H)	Chroma blur radius
		public static const CHROMA_BLUR_RADIUS:uint		= 50737;

		// 50738 (C632H)	Anti alias strength
		public static const ANTI_ALIAS_STRENGTH:uint	= 50738;

		// 50739 (C633H)	Shadow scale
		public static const SHADOW_SCALE:uint			= 50739;

		// 50740 (C634H)	DNG private data
		public static const DNG_PRIVATE_DATA:uint		= 50740;

		// 50741 (C635H)	Maker note safety
		public static const MAKER_NOTE_SAFETY:uint		= 50741;

		// 50781 (C65DH)	Raw data unique id
		public static const RAW_DATA_UNIQUE_ID:uint		= 50781;

		// 50827 (C68BH)	Original raw filename
		public static const ORIG_RAW_FILENAME:uint		= 50827;

		// 50828 (C68CH)	Original raw file data
		public static const ORIG_RAW_FILE_DATA:uint		= 50828;

		// 50829 (C68DH)	Active area
		public static const ACTIVE_AREA:uint			= 50829;

		// 50830 (C68EH)	Mask areas
		public static const MASK_AREAS:uint				= 50830;

		// 50831 (C68FH)	As shot ICC profile
		public static const AS_SHOT_ICC_PROFILE:uint	= 50831;

		// 50832 (C690H)	As shot pre-profile matrix
		public static const AS_SHOT_PREPROFILE_MATRIX:uint	= 50832;

		// 50833 (C691H)	Current ICC profile
		public static const CURRENT_ICC_PROFILE:uint	= 50833;

		// 50834 (C692H)	Current pre profile matrix
		public static const CURRENT_PREPROFILE_MATRIX:uint	= 50834;

		// 50879 (C6BFH)	Colorimetric reference
		public static const COLORIMETRIC_REF:uint		= 50879;

		// 50931 (C6F3H)	Camera calibration signature
		public static const CAMERA_CALIB_SIGNATURE:uint	= 50931;

		// 50932 (C6F4H)	Profile calibration signature
		public static const PROFILE_CALIB_SIGNATURE:uint= 50932;

		// pg49
	}
}