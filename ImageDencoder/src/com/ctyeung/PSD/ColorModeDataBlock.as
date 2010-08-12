// Reference:   http://www.fileformat.info/format/psd/egff.htm
package com.ctyeung.PSD
{
	import flash.utils.ByteArray;

	public class ColorModeDataBlock
	{
		public function ColorModeDataBlock()
		{
		}
		
		public function decode(bytes:ByteArray):Boolean {
			BYTE Type[4];  /* Always "8BIM" */
			WORD ID;       /* (See table below) */
			BYTE Name[];   /* Even-length Pascal-format string, 2 bytes or longer */
			LONG Size;     /* Length of resource data following, in bytes */
			BYTE Data[];   /* Resource data, padded to even length */
		}
	}
}