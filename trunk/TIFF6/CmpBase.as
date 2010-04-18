package com.ctyeung.TIFF6
{
	import flash.utils.ByteArray;
	
	public class CmpBase
	{
		protected var info:ImageInfo;
		protected var bytesCmp:ByteArray;
		protected var bytes:ByteArray;
		protected var lineByteWid:int;
		
		protected var stripIndex:int;	// info.strip
		protected var blockIndex:int;	// index within a decompressed strip
		protected var rowOfPixels:ByteArray;
		
		public function CmpBase(info:ImageInfo,
								bytesCmp:ByteArray,
							   lineByteWid:int) {
			this.info = info;
			this.bytesCmp = bytesCmp;
			this.lineByteWid = lineByteWid;
			bytes = new ByteArray();
			
			stripIndex = 0;
			rowOfPixels = new ByteArray();
		}
		
		public function empty():void {
			if(bytes.length) 	bytes.clear();
		}
		
		public function isEmpty():Boolean {
			if(!bytes)			return true;
			if(!bytes.length)	return true;
			return false;
		}
		
		public function decode(	bytesCmp:ByteArray,	// [in] compressed data
								offset:int,			// [in] start position
								length:int)			// [in] length of block
								:ByteArray {		// [out] uncompressed data
			return null;
		}
		
		public function getRow(index:int)
			:ByteArray {
			if(!bytes) 
				return null;
			if(blockIndex > (bytes.length-lineByteWid))
				return null;
			
			rowOfPixels.position = 0;
			rowOfPixels.writeBytes(bytes, blockIndex, lineByteWid);
			blockIndex += lineByteWid;
			
			if(blockIndex >= bytes.length-1) {
				if(stripIndex < (info.stripOffset.length-1)) {
					stripIndex ++;
					blockIndex = 0;
					bytes = decode(bytesCmp, info.stripOffset[stripIndex], 
						info.stripByteCount[stripIndex]);
				}
			}
			return rowOfPixels;
		}

	}
}