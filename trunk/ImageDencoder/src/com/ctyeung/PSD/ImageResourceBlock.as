// Reference:   http://www.fileformat.info/format/psd/egff.htm
package com.ctyeung.PSD
{
	import flash.utils.ByteArray;

	public class ImageResourceBlock
	{
		protected var blockLen:uint;
		
		public function ImageResourceBlock()
		{
		}
		
		public function decode(bytes:ByteArray):void {
			blockLen = bytes.readUnsignedInt();
		}
	}
}