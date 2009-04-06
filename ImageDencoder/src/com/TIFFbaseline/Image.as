// ==================================================================
// Module:			Image.as
//
// Description:		Image content for Adobe TIFF file v6.0
//
// Author(s):		C.T. Yeung
// Company:			Jostens 2009
//
// History:
// 23Feb09			start coding								cty
// ==================================================================
package com.TIFFbaseline
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public class Image
	{
		public static const BPP_1:int = 1;
		public static const BPP_4:int = 4;
		public static const BPP_8:int = 8;
		public static const BPP_24:int = 24;
		public static const BPP_32:int = 32;
		
		public var bitmapData:BitmapData;
		protected var hdr:Header;
		protected var info:ImageInfo;
		protected var bytes:ByteArray;
		
/////////////////////////////////////////////////////////////////////
// initialization

		public function Image(hdr:Header=null,
							  info:ImageInfo=null)
		{
			this.hdr = hdr;
			this.info = info;
		}

		public function empty():void
		{
			if(bitmapData)
				bitmapData.dispose();
			bitmapData = null;
		}
		
		public function isEmpty():Boolean
		{
			if(bitmapData)
				return false;
			return true;
		}
		
		public function setRef(hdr:Header=null,
							  info:ImageInfo=null):void
		{
			this.hdr = hdr;
			this.info = info;
		}

/////////////////////////////////////////////////////////////////////
// public

		public function encode():Boolean
		{
			return true;
		}
		
		public function decode(bytes:ByteArray):Boolean
		{
			empty();
			
			this.bytes = bytes;
			bitmapData = new BitmapData(info.imageWidth, info.imageLength);
			switch(info.bitsPerSample)
			{
				case BPP_1:
				return decode1bpp();
				
				case BPP_4:
				return decode4bpp();
				
				case BPP_8:
				return decode8bpp();
				
				case BPP_24:
				return decode24bpp();
				
				case BPP_32:
				return decode32bpp();
			}
			return false;
		}

/////////////////////////////////////////////////////////////////////
// protected decoding
		
		protected function getRowList():Array
		{
			var so:Array = info.stripOffset;
			var bc:Array = info.stripByteCount;
			var rps:Array = info.rowPerStrip;
			var offsetList:Array = new Array();
			
			return offsetList;
		}
		
		protected function decode1bpp():Boolean
		{
			// no line padding in TIFF
			var offsetList:Array = getRowList();
			var lineWidth:uint = info.imageWidth;
			var palette:Array = info.colorMap;
			
			for ( var y:int=0; y<lineWidth; y++) {
				var offset:uint = offsetList[y];
				var mask:uint = 0x80;
				for ( var x:int=0; x<lineWidth; x++) {
					var i:uint = x/8;
					var pixel:uint = bytes[offset+lineWidth*y+i];
					var palIndex:int = (pixel&mask)?1:0;
					var clr:uint = palette[palIndex*4];
					clr += palette[palIndex*4+1]<<(8);
					clr += palette[palIndex*4+2]<<(8*2);
					bitmapData.setPixel(x,y, clr);
					mask = (mask>1)? mask>>1:0x80;
				}
			}
			return true;
		}
		
		protected function decode4bpp():Boolean
		{
			var offsetList:Array = getRowList();
			var lineWidth:uint = info.imageWidth;
			var palette:Array = info.colorMap;
			var mask:uint;
			var pixel:uint;
			var palIndex:uint;
			
			for ( var y:int=0; y<info.imageLength; y++) {
				var offset:uint = offsetList[y];
				for ( var x:int=0; x<lineWidth; x++) {
					var i:uint = x/2;
					pixel = bytes[lineWidth*y+i];
					if (x%2) {
						mask = 240;
						palIndex = ( pixel & mask ) >> 4;						
					}
					else {
						mask = 15;
						palIndex = ( pixel & mask );	
					}
					var clr:uint = palette[palIndex*4];
					clr += palette[palIndex*4+1]<<(8);
					clr += palette[palIndex*4+2]<<(8*2);
					bitmapData.setPixel(x,y, clr);
				}
			}
			return true;
		}
		
		protected function decode8bpp():Boolean
		{
			var offsetList:Array = getRowList();
			var lineWidth:uint = info.imageWidth;
			var palette:Array = info.colorMap;
			var palIndex:uint;
			
			for ( var y:int=0; y<info.imageLength; y++) {
				var offset:uint = offsetList[y];
				for ( var x:int=0; x<lineWidth; x++) {
					palIndex = bytes[offset+lineWidth*y+x];
					var clr:uint = palette[palIndex*4];
					clr += palette[palIndex*4+1]<<(8);
					clr += palette[palIndex*4+2]<<(8*2);
					bitmapData.setPixel(x,y, clr);
				}
			}
			return true;
		}
		
		protected function decode24bpp():Boolean
		{
			var offsetList:Array = getRowList();
			var lineWidth:uint = info.imageWidth;
			var i:uint = 0;
			for ( var y:int=info.imageLength-1; y>=0; y--) {
				var offset:uint = offsetList[y];
				for ( var x:int=0; x<lineWidth; x++) {
					var clr:uint = uint(bytes[offset+i]);
					    clr += uint(bytes[offset+i+1]) <<(8);
					    clr += uint(bytes[offset+i+2]) <<(8*2);
					bitmapData.setPixel(x,y, clr);
					i += 3;
				}
				i = y * lineWidth;
			}
			return true;
		}
		
		//***Need to perform CMYK to RGB conversion
		protected function decode32bpp():Boolean
		{
			var offsetList:Array = getRowList();
			var lineWidth:uint = info.imageWidth;
			var i:uint = 0;
			for ( var y:int=info.imageLength-1; y>=0; y--) {
				var offset:uint = offsetList[y];
				for ( var x:int=0; x<lineWidth; x++) {
					var clr:uint = uint(bytes[offset+i]);
					    clr += uint(bytes[offset+i+1]) <<(8);
					    clr += uint(bytes[offset+i+2]) <<(8*2);
					bitmapData.setPixel(x,y, clr);
					i += 3;
				}
				i = y * lineWidth;
			}
			return true;
		}
	}
}