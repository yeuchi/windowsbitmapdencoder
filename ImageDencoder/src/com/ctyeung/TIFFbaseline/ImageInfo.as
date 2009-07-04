// ==================================================================
// Module:			Image.as
//
// Description:		Image content for Adobe TIFF file v6.0
//
// Author(s):		C.T. Yeung
//
// History:
// 23Feb09			start coding								cty
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:

// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// ==================================================================
package com.ctyeung.TIFFbaseline
{
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	public class ImageInfo extends IFD
	{
		public function ImageInfo(hdr:Header=null)
		{
			super(hdr);
		}
		
		override public function empty():void
		{
			super.empty();
		}
		
		override public function isEmpty():Boolean
		{
			if(super.isEmpty())
				return true;
			return false;
		}
		
/////////////////////////////////////////////////////////////////////
// properties

		public function get photometricInterpretation():int
		{
			var ary:Array = getDirEntryValue(Fields.PHOTOMETRICINTERPRETATION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get compression():int
		{
			var ary:Array = getDirEntryValue(Fields.COMPRESSION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get imageLength():uint
		{
			var ary:Array = getDirEntryValue(Fields.IMAGELENGTH);
			if(ary)	return(ary.length)?ary[0]:0;
			return 0;
		}
		
		public function get imageWidth():uint
		{
			var ary:Array = getDirEntryValue(Fields.IMAGEWIDTH);
			if(ary)	return(ary.length)?ary[0]:0;
			return 0;
		}
		
		public function get resolutionUint():Number
		{
			var ary:Array = getDirEntryValue(Fields.RESOLUTIONUNIT);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get xResolution():Number
		{
			var ary:Array = getDirEntryValue(Fields.XRESOLUTION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get yResolution():Number
		{
			var ary:Array = getDirEntryValue(Fields.YRESOLUTION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get rowsPerStrip():Array
		{
			return getDirEntryValue(Fields.ROWSPERSTRIP);
		}
		
		public function get stripOffset():Array
		{
			return getDirEntryValue(Fields.STRIPOFFSETS);
		}
		
		public function get stripByteCount():Array
		{
			return getDirEntryValue(Fields.STRIPBYTECOUNTS);
		}
		
		public function get newSubFileType():int
		{
			var ary:Array = getDirEntryValue(Fields.NEWSUBFILETYPE);
			var num:int = ary[0] as int;
			return num;
		}
		
		public function get samplesPerPixel():int
		{
			var ary:Array = getDirEntryValue(Fields.SAMPLESPERPIXEL);
			var num:int = ary[0] as int;
			return num;
		}
		
		public function get bitsPerSample():Array
		{
			return getDirEntryValue(Fields.BITSPERSAMPLE);
		}
		
		public function get bitsPerPixel():int
		{
			var channels:int = samplesPerPixel;
			var bpp:int = 0;
			var bps:Array = bitsPerSample;
			if(channels > bps.length)	return -1;
			
			for(var i:int = 0; i<channels; i++){
				bpp += bps[i];
			}
			return bpp;
		}
		
		public function get colorMap():Array
		{
			return getDirEntryValue(Fields.COLORMAP);
		}
		
		public function get software():String
		{
			var ary:Array = getDirEntryValue(Fields.SOFTWARE);
			var str:String="";
			for (var i:int=0; i<ary.length; i++)
				str += ary[i] as String;
			return str;
		}

/////////////////////////////////////////////////////////////////////
// public

		override public function decode(bytes:ByteArray):Boolean
		{
			if (super.decode(bytes)){
				
				switch(photometricInterpretation) {
					case Fields.BLACK_ZERO:
					case Fields.WHITE_ZERO:
					return isValidBlackWhite();
					
					case Fields.PAL_CLR:
					return isValidIndexColor();
					
					case Fields.RGB_CLR:
					return isValidRGB();
					
					case Fields.CMYK_CLR:
					return isValidCMYK();
					
					// below formats not supported as baseline
					case Fields.CIE_Lab:
					return false;
					
					case Fields.YCbCr:
					return false;
					
					case Fields.MASK:
					return false;
				}
				return true;				
			}
			return false;
		}
		
		public function isValidBlackWhite():Boolean {
			if( (photometricInterpretation != Fields.WHITE_ZERO) &&
				(photometricInterpretation != Fields.BLACK_ZERO)) {
				Alert.show("Invalid Black & white");			
				return false;
			}	
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}
			return true;
		}
		
		public function isValidIndexColor():Boolean {
			if(photometricInterpretation != Fields.PAL_CLR) {
				Alert.show("Invalid Index Color");		
				return false;	
			}
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}		
			return true;
		}
		
		public function isValidRGB():Boolean {
			if(photometricInterpretation != Fields.RGB_CLR){
				Alert.show("Invalid RGB");		
				return false;	
			}	
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}		
			return true;
		}
		
		public function isValidCMYK():Boolean {
			if(photometricInterpretation != Fields.CMYK_CLR){
				Alert.show("Invalid CMYK Color");		
				return false;	
			}
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}		
			return true;
		}
		
		public function isValidYCbCr():Boolean {
			if(photometricInterpretation != Fields.YCbCr){
				Alert.show("Invalid YCbCr");		
				return false;	
			}
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}
			return true;
		}
		
		public function isValidCIELab():Boolean {
			if(photometricInterpretation != Fields.CIE_Lab){
				Alert.show("Invalid CIE Lab");		
				return false;	
			}
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}
			return true;
		}
		
		public function isValidMask():Boolean {
			
			if(compression != Fields.NO_COMPRESSION){	
				Alert.show("Compression not supported");		
				return false;
			}
			return true;
		}
	}
}