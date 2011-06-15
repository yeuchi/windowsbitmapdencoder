package com.ctyeung.DNG
{
	import com.ctyeung.TIFF6.Header;
	import com.ctyeung.TIFF6.ImageInfo;
	
	public class ImageInfo extends com.ctyeung.TIFF6.ImageInfo
	{
		public function ImageInfo(hdr:Header=null)
		{
			super(hdr);
		}
		
/////////////////////////////////////////////////////////////////////
// properties (tags)
		
		public function get DNGVersion():Array {
			// should return bytes: 1,2,0,0
			return getDirEntryValueArray(Fields.DNG_VERSION);
		}
		
		public function get DNGBackVersion():Array {
			// see pg 20 for details
			return getDirEntryValueArray(Fields.DNG_BACK_VERSION);
		}
		
		public function get uniqueCameraModel():String {
			return getDirEntryValueString(Fields.UNIQUE_CAMERA_MODEL);
		}
		
		public function get localCameraModel():String {
			return getDirEntryValueString(Fields.LOCAL_CAMERA_MODEL);
		}
		
		public function get CFAPlaneColor():int {
			return getDirEntryValueNumber(Fields.CFA_PLANE_COLOR);
		}
		
		public function get CFALayout():int {
			return getDirEntryValueNumber(Fields.CFA_LAYOUT);
		}
		
		public function get linearTable():Array {
			return getDirEntryValueArray(Fields.LINEARIZATION_TABLE);
		}
		
		public function get blackLevelRepeatDim():int {
			return getDirEntryValueNumber(Fields.BLACK_LEVEL_REPEAT_DIM);
		}
		
		public function get blackLevel():Array {
			// see page 65
			return getDirEntryValueArray(Fields.BLACK_LEVEL);
		}
		
		public function get blackLevelDeltaV():Number {					// Tag 282
			return getDirEntryValueNumber(Fields.WHITE_LEVEL);
		}
		
		public function get defaultScale():Array {
			// 2 rationals
			return getDirEntryValueArray(Fields.DEFAULT_SCALE);
		}
		
		public function get bestQualScale():Number {					// Tag 282
			return getDirEntryValueNumber(Fields.BEST_QUAL_SCALE);
		}
		
		public function get defaultCropOrigin():Array {
			// 2 rationals
			return getDirEntryValueArray(Fields.DEFAULT_CROP_ORIGIN);
		}
		
		public function get defaultCropSize():Array {
			// 2 rationals
			return getDirEntryValueArray(Fields.DEFAULT_CROP_SIZE);
		}
		
		public function get calibIllum1():Number {					// Tag 282
			return getDirEntryValueNumber(Fields.CALIB_ILLUM_1);
		}
		
		public function get calibIllum2():Number {					// Tag 282
			return getDirEntryValueNumber(Fields.CALIB_ILLUM_2);
		}
		
		public function get colorMatrix1():Array {
			// color planes * 3
			return getDirEntryValueArray(Fields.COLOR_MATRIX_1);
		}
		
		public function get colorMatrix2():Array {
			// color planes * 3
			return getDirEntryValueArray(Fields.COLOR_MATRIX_2);
		}
		
		public function get cameraCalib1():Array {
			// color planes * color planes
			return getDirEntryValueArray(Fields.CAMERA_CALIB_1);
		}
		
		public function get cameraCalib2():Array {
			// color planes * color planes
			return getDirEntryValueArray(Fields.CAMERA_CALIB_2);
		}
		
		public function get reductionMatrix1():Array {
			// color planes * 3
			return getDirEntryValueArray(Fields.REDUCTION_MATRIX_1);
		}
		
		public function get reductionMatrix2():Array {
			// color planes * 3
			return getDirEntryValueArray(Fields.REDUCTION_MATRIX_2);
		}
		
		public function get analogBalance():Array {
			// color planes 
			return getDirEntryValueArray(Fields.ANALOG_BALANCE);
		}
		
		public function get asShotNeutral():Array {
			// color planes 
			return getDirEntryValueArray(Fields.AS_SHOT_NEUTRAL);
		}
		
		public function get asShotWhiteXY():Array {
			// 2
			return getDirEntryValueArray(Fields.AS_SHOT_WHITE_XY);
		}
		
		public function get baselineExposure():Number {					
			return getDirEntryValueNumber(Fields.BASELINE_EXPOSURE);
		}
		
		public function get baselineNoise():Number {					
			return getDirEntryValueNumber(Fields.BASELINE_NOISE);
		}
		
		public function get baselineSharpness():Number {					
			return getDirEntryValueNumber(Fields.BASELINE_SHARPNESS);
		}
		
		public function get bayerGreenSplit():Number {				
			return getDirEntryValueNumber(Fields.BAYER_GREEN_SPLIT);
		}
		
		public function get linearResponseLimit():Number {					
			return getDirEntryValueNumber(Fields.LINEAR_RESPONSE_LIMIT);
		}
		
		public function get cameraSerialNumber():Array {
			// string
			return getDirEntryValueArray(Fields.CAMERA_SERIAL_NUM);
		}
		
		public function get lensInfo():Array {
			// 4 rationals
			return getDirEntryValueArray(Fields.LENS_INFO);
		}
		
		public function get chromaBlurRadius():Number {					
			return getDirEntryValueNumber(Fields.CHROMA_BLUR_RADIUS);
		}
		
		public function get antiAliasStrength():Number {					
			return getDirEntryValueNumber(Fields.ANTI_ALIAS_STRENGTH);
		}
		
		public function get shadowScale():Number {					
			return getDirEntryValueNumber(Fields.SHADOW_SCALE);
		}
		
		public function get DNGPrivateData():Array {
			return getDirEntryValueArray(Fields.DNG_PRIVATE_DATA);
		}
		
		public function get makerNoteSafety():Number {					
			return getDirEntryValueNumber(Fields.MAKER_NOTE_SAFETY);
		}
		
		public function get rawDataUniqueId():Array {
			// 16 bytes
			return getDirEntryValueArray(Fields.RAW_DATA_UNIQUE_ID);
		}
		
		public function get origRawFilename():Array {
			return getDirEntryValueArray(Fields.ORIG_RAW_FILENAME);
		}
		
		public function get origRawFileData():Array {
			return getDirEntryValueArray(Fields.ORIG_RAW_FILE_DATA);
		}
		
		public function get activeArea():Array {
			return getDirEntryValueArray(Fields.ACTIVE_AREA);
		}
		
		public function get maskAreas():Array {
			// 4 * num of rectangles
			return getDirEntryValueArray(Fields.MASK_AREAS);
		}
		
		public function get asShotICCProfile():Array {
			return getDirEntryValueArray(Fields.AS_SHOT_ICC_PROFILE);
		}
		
		public function get asShotPreprofileMatrix():Array {
			return getDirEntryValueArray(Fields.AS_SHOT_PREPROFILE_MATRIX);
		}
		
		public function get currentICCProfile():Array {
			// len of ICC profile 
			return getDirEntryValueArray(Fields.CURRENT_ICC_PROFILE);
		}
		
		public function get currentPreprofileMatrix():Array {
			// 3 * color planes or color planes * color planes
			return getDirEntryValueArray(Fields.CURRENT_PREPROFILE_MATRIX);
		}
		
		public function get colorimetricRef():Number {					
			return getDirEntryValueNumber(Fields.COLORIMETRIC_REF);
		}
		
		public function get cameraCalibSignature():Array {
			// 3 * color planes or color planes * color planes
			return getDirEntryValueArray(Fields.CAMERA_CALIB_SIGNATURE);
		}
		
		public function get profileCalibSignature():Array {
			// 3 * color planes or color planes * color planes
			return getDirEntryValueArray(Fields.PROFILE_CALIB_SIGNATURE);
		}
	}
}