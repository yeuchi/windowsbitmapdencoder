package com.TIFFbaseline
{
	import flash.utils.ByteArray;
	
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
		
		public function get rowPerStrip():Array
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
		
		public function get bitsPerSample():int
		{
			var ary:Array = getDirEntryValue(Fields.BITSPERSAMPLE);
			var num:int = ary[0] as int;
			return num;
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
			if (super.decode(bytes))
				return validate();
			return false;
		}
		
		public function validate():Boolean
		{
			// compression
			if (compression != Fields.NO_COMPRESSION)	return false;
			
			switch(Fields.PHOTOMETRICINTERPRETATION) {
				case Fields.WHITE_ZERO:
				break;
				
				case Fields.BLACK_ZERO:
				break;
				
				case Fields.RGB_CLR:
				break;
				
				case Fields.PAL_CLR:
				break;
				
				case Fields.MASK:
				break;
				
				case Fields.CMYK_CLR:
				break;
				
				case Fields.YCbCr:
				break;
				
				case Fields.CIE_Lab:
				break;

				default:
				return false;
			}
		
			return true;
		}
	}
}