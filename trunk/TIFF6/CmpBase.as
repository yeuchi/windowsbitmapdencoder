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
		
		public function CmpBase(info:ImageInfo,
								bytesCmp:ByteArray,
							   lineByteWid:int) {
			this.info 		 = info;
			this.bytesCmp 	 = bytesCmp;
			this.lineByteWid = lineByteWid;
			this.stripIndex  = 0;
			bytes = new ByteArray();
		}
		
		public function dispose():void {
			info 	 = null;
			bytesCmp = null;
			bytes 	 = null;
		}
		
		public function empty():void {
			if(bytes.length) 	
				bytes.clear();
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
		
		public function getRow(index:int):ByteArray {
			if(!bytes) 
				return null;
			
			if(stripIndex < (info.stripOffset.length)) {
				bytes = decode(	bytesCmp, 
								info.stripOffset[stripIndex], 
								info.stripByteCount[stripIndex]);
				stripIndex ++;
				return bytes;
			}
			return null;
		}

	}
}