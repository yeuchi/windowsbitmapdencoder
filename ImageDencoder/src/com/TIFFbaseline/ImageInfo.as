package com.TIFFbaseline
{
	import baseline.IFD;
	
	public class ImageInfo extends IFD
	{
		public function ImageInfo(hdr:Header=null)
		{
			super(hdr);
		}
		
		public function empty():void
		{
			
		}
		
		public function isEmpty():Boolean
		{
			return false;
		}
		
/////////////////////////////////////////////////////////////////////
// properties

		public function get photometricInterpretation():int
		{
			var ary:Array = dirEntryValue(Fields.PHOTOMETRICINTERPRETATION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get compression():int
		{
			var ary:Array = dirEntryValue(Fields.COMPRESSION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get imageLength():uint
		{
			var ary:Array = dirEntryValue(Fields.IMAGELENGTH);
			if(ary)	return(ary.length)?ary[0]:0;
			return 0;
		}
		
		public function get imageWidth():uint
		{
			var ary:Array = dirEntryValue(Fields.IMAGEWIDTH);
			if(ary)	return(ary.length)?ary[0]:0;
			return 0;
		}
		
		public function get resolutionUint():Number
		{
			var ary:Array = dirEntryValue(Fields.RESOLUTIONUNIT);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get xResolution():Number
		{
			var ary:Array = dirEntryValue(Fields.XRESOLUTION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get yResolution():Number
		{
			var ary:Array = dirEntryValue(Fields.YRESOLUTION);
			if(ary)	return(ary.length)?ary[0]:-1;
			return -1;
		}
		
		public function get rowPerStrip():Array
		{
			return dirEntryValue(Fields.ROWSPERSTRIP);
		}
		
		public function get stripOffset():Array
		{
			return dirEntryValue(Fields.STRIPOFFSETS);
		}
		
		public function get stripByteCount():Array
		{
			return dirEntryValue(Fields.STRIPBYTECOUNTS);
		}
		
		public function get newSubFileType():int
		{
			return dirEntryValue(Fields.NEWSUBFILETYPE);
		}
		
		public function get software():String
		{
			return dirEntryValue(Fields.SOFTWARE);
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
				case WHITE_ZERO:
				break;
				
				case BLACK_ZERO:
				break;
				
				case RGB_CLR:
				break;
				
				case PAL_CLR:
				break;
				
				case MASK:
				break;
				
				case CMYK_CLR:
				break;
				
				case YCbCr:
				break;
				
				case CIE_Lab:
				break;

				default:
				return false;
			}
		
			return true;
		}
	}
}