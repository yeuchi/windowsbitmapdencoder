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
package baseline
{
	import com.TIFFbaseline.Header;
	import com.TIFFbaseline.ImageInfo;
	
	public class Image
	{
		public var bitmapData:BitmapData;
		protected var hdr:Header;
		protected var info:ImageInfo;
		
/////////////////////////////////////////////////////////////////////
// initialization

		public function Image(hdr:Header=null,
							  info:ImageInfo)
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
							  info:ImageInfo)
		{
			this.hdr = hdr;
			this.info = info;
		}

/////////////////////////////////////////////////////////////////////
// public

		public function encode():Boolean
		{
			
		}
		
		public function decode(bytes:ByteArray):Boolean
		{
			empty();
			
			this.bytes = bytes;
			bitmapData = new BitmapData(bmpHdr.lbiWidth, bmpHdr.lbiHeight);
			
			switch(bmpHdr.ibiBitCount)
			{
				case WinBmpHdr.BPP_1:
				return decode1bpp();
				
				case WinBmpHdr.BPP_4:
				return decode4bpp();
				
				case WinBmpHdr.BPP_8:
				return decode8bpp();
				
				case WinBmpHdr.BPP_16:
				return decode16bpp();
				
				case WinBmpHdr.BPP_24:
				return decode24bpp();
			}
			return false;
		}

/////////////////////////////////////////////////////////////////////
// protected decoding
		
		protected function decode1bpp():Boolean
		{
			// no line padding in TIFF
			var offset:uint = fileHdr.lbfOffs;
			var lineWidth:uint = WinBmpImg.byteWidth(bmpHdr.lbiWidth, bmpHdr.ibiBitCount);
			var Y:int=bmpHdr.lbiHeight-1;
			
			for ( var y:int=0; y<bmpHdr.lbiHeight; y++) {
				var mask:uint = 0x80;
				for ( var x:int=0; x<bmpHdr.lbiWidth; x++) {
					var i:uint = x/8;
					var pixel:uint = bytes[offset+lineWidth*Y+i];
					var palIndex:int = (pixel&mask)?1:0;
					var clr:uint = bmpPal.palette[palIndex*4];
					clr += bmpPal.palette[palIndex*4+1]<<(8);
					clr += bmpPal.palette[palIndex*4+2]<<(8*2);
					bitmapData.setPixel(x,y, clr);
					mask = (mask>1)? mask>>1:0x80;
				}
				Y --;
			}
			return true;
		}
		
		protected function decode4bpp():Boolean
		{
			var offset:uint = fileHdr.lbfOffs;
			var lineWidth:uint = WinBmpImg.byteWidth(bmpHdr.lbiWidth, bmpHdr.ibiBitCount);
			var mask:uint;
			var pixel:uint;
			var palIndex:uint;
			var Y:int=bmpHdr.lbiHeight-1;
			
			for ( var y:int=0; y<bmpHdr.lbiHeight; y++) {
				for ( var x:int=0; x<bmpHdr.lbiWidth; x++) {
					var i:uint = x/2;
					pixel = bytes[offset+lineWidth*Y+i];
					if (x%2) {
						mask = 240;
						palIndex = ( pixel & mask ) >> 4;						
					}
					else {
						mask = 15;
						palIndex = ( pixel & mask );	
					}
					var clr:uint = bmpPal.palette[palIndex*4];
					clr += bmpPal.palette[palIndex*4+1]<<(8);
					clr += bmpPal.palette[palIndex*4+2]<<(8*2);
					bitmapData.setPixel(x,y, clr);
				}
				Y --;
			}
			return true;
		}
		
		protected function decode8bpp():Boolean
		{
			var offset:uint = fileHdr.lbfOffs;
			var lineWidth:uint = WinBmpImg.byteWidth(bmpHdr.lbiWidth, bmpHdr.ibiBitCount);
			var palIndex:uint;
			
			var Y:int=bmpHdr.lbiHeight-1;
			for ( var y:int=0; y<bmpHdr.lbiHeight; y++) {
				for ( var x:int=0; x<bmpHdr.lbiWidth; x++) {
					palIndex = bytes[offset+lineWidth*Y+x];
					var clr:uint = bmpPal.palette[palIndex*4];
					clr += bmpPal.palette[palIndex*4+1]<<(8);
					clr += bmpPal.palette[palIndex*4+2]<<(8*2);
					bitmapData.setPixel(x,y, clr);
				}
				Y --;
			}
			return true;
		}
		
		protected function decode16bpp():Boolean
		{
			Alert.show("Sorry, not supported!");
			return true;
		}
		
		protected function decode24bpp():Boolean
		{
			var offset:uint = fileHdr.lbfOffs;
			var i:uint = 0;
			var lineWidth:uint = WinBmpImg.byteWidth(bmpHdr.lbiWidth, bmpHdr.ibiBitCount);
			var Y:int = 0;
			for ( var y:int=bmpHdr.lbiHeight-1; y>=0; y--) {
				for ( var x:int=0; x<bmpHdr.lbiWidth; x++) {
					var clr:uint = uint(bytes[offset+i]);
					    clr += uint(bytes[offset+i+1]) <<(8);
					    clr += uint(bytes[offset+i+2]) <<(8*2);
					bitmapData.setPixel(x,y, clr);
					i += 3;
				}
				i = Y * lineWidth;
				Y++;
			}
			return true;
		}
	}
}