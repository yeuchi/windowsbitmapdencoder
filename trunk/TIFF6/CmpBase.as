package com.ctyeung.TIFFbaseline
{
	import flash.utils.ByteArray;
	
	public class CmpBase
	{
		protected var info:ImageInfo;
		protected var bytesCmp:ByteArray;
		protected var bytes:ByteArray;
		protected var lineByteWid:int;
		
		public function CmpBase(info:ImageInfo,
								bytesCmp:ByteArray,
							   lineByteWid:int) {
			this.info = info;
			this.bytesCmp = bytesCmp;
			this.lineByteWid = lineByteWid;
			bytes = new ByteArray();
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
		
		public function getRow(	index:int)
								:ByteArray {
			return null;
		}

	}
}