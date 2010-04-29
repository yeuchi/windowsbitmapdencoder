package com.ctyeung.Targa
{
	public class TGAHeader
	{
		public var lenID:int;			// length of image ID, 1 byte: 0 - 255 bytes (0=no id)
		public var clrMapType:Boolean;	// Color map type, 1 byte: 	0 (no color map) 
										//							1 (color map included)
		public var imgType:int;			// Image type, 1 byte:		0 no image data in file
										//							1 color map image, uncompressed
										//							2 RGB image (24bpp) uncompressed
										//							3 Monochrome image uncompressed
										//							9 Color map image, RLE-encoding
										// 						   10 RGB image (24bpp) RLE-encoding
										//						   11 Monochrome image, RLE-encoding
										// 						   32 Color map image, Huffman, delta and RLE-encoding
										//						   33 Color map image, Huffman, delta, RLE, 4 pass quad tree
		public var clrMapOrgn:int;		// Color map origin, 2 bytes
		public var clrMapLen:int;		// Color map length, 2 bytes
		public var clrMapEntrySze:int;	// Color map entry size (16, 24, 32), 1 byte
		public var xOrgn:int;			// X-coordinate origin, 2 bytes
		public var yOrgn:int;			// Y-coordinate origin, 2 bytes
		public var imgWid:int;			// image width in pixels, 2 bytes
		public var imgLen:int;			// image height in pixels, 2 bytes
		public var bpp:int;				// bits per pixel, 1 byte
		public var imgDes:int;			// image descriptor byte, 1 byte
		public var imgIDField:Array;	// image identification field
		
		public function TGAHeader()
		{
		}
		
		public function isEmpty():Boolean {
			if(imgWid&&imgLen)
				return true;
			return false;
		}
		
		public function dispose():void {
			
		}
		
		public function decode(bytes:ByteArray):Boolean {
			lenID	  		=  bytes[0];
			clrMapType 		= (bytes[1])?true:false;
			imgType			=  byte[2];
			clrMapOrgn		=  uint(bytes[3]);
			clrMapOrgn		+= uint(bytes[4])<<8;
			clrMapLen		=  uint(bytes[5]);
			clrMapLen		+= uint(bytes[6])<<8;
			clrMapEntrySze	= byte[7];
			xOrgn			= uint(bytes[8]);
			xOrgn			+= uint(bytes[9])<<8;
			yOrgn			= uint(bytes[10]);
			yOrgn			+= uint(bytes[11])<<8;
			imgWid			= uint(bytes[12]);
			imgWid			+= uint(bytes[13])<<8;
			imgLen			= uint(bytes[14]);
			imgLen			+= uint(bytes[15])<<8;
			bpp				= bytes[16];
			imgDes			= bytes[17];
			
			if(lenID) {
				
			}
		}
	}
}