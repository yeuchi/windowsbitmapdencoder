// ==================================================================
// Module: 		Header.as
//
// Description:	PSD file header (26 bytes)
//
// Reference:   http://www.fileformat.info/format/psd/egff.htm
//
// Input:		image bytearray
// output:		true if succeed in decoding
//
// Author(s):	Chi T. Yeung 
//
// History:
// 11Aug10		1s started										cty
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:

// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// ==================================================================
package com.ctyeung.PSD
{
	import flash.utils.ByteArray;

	public class Header
	{
		public static const DEPTH_BPP_1:int = 1;
		public static const DEPTH_BPP_8:int = 8;
		public static const MAX_WIDTH:int 		= 30000;
		public static const MAX_HEIGHT:int 		= 30000;
		public static const MODE_MONO:int 		= 0;
		public static const MODE_GRAYSCALE:int 	= 1;
		public static const MODE_INDEX_CLR:int 	= 2;
		public static const MODE_RGB_CLR:int 	= 3;
		public static const MODE_CMYK_CLR:int 	= 4;
		public static const MODE_MULTI_CHAN:int = 7;
		public static const MODE_DUOTONE:int 	= 8;
		public static const MODE_LAB_CLR:int 	= 9;
		
		//BYTE Signature[4];   			/* 0 File ID "8BPS" */
		//WORD Version;        			/* 4 Version number, always 1 */
		//BYTE Reserved[6];    			/* 6 Reserved, must be zeroed */
		protected var channels:int;     /* 12 Number of color channels (1-24) including alpha channels */
		protected var rows:uint;        /* 16 Height of image in pixels (1-30000) */
		protected var columns:uint;     /* 20 Width of image in pixels (1-30000) */
		protected var depth:int;        /* 22 Number of bits per channel (1, 8, and 16) */
		protected var mode:int;         /* 24 Color mode */
		
		public function Header()
		{
		}
		
		public function decode(bytes:ByteArray):Boolean {
			var signature:String = bytes.readMultiByte(4, "ascii");
			if(signature != "8BPS")
				return false;
			
			var version:int = bytes.readShort();
			if(version != 1)
				return false;
			
			var reserved:String = bytes.readMultiByte(6, "ascii");
			if(reserved != null)			// needs validation
				return false;
			
			channels = bytes.readShort();
			if(channels < 1 || channels > 16)
				return false;
			
			rows = bytes.readUnsignedInt();
			if(row<1 || row>MAX_WIDTH)
				return false;
			
			columns = bytes.readUnsignedInt();
			if(columns<1 || columns>MAX_WIDTH)
				return false;
			
			depth = bytes.readShort();
			if(depth != DEPTH_BPP_1 && depth != DEPTH_BPP_8)
				return false;
			
			mode = bytes.readShort();
			if(mode != MODE_MONO &&
			   mode != MODE_GRAYSCALE &&
			   mode != MODE_INDEX_CLR &&
			   mode != MODE_RGB_CLR &&
			   mode != MODE_CMYK_CLR &&
			   mode != MODE_MULTI_CHAN &&
			   mode != MODE_DUOTONE &&
			   mode != MODE_LAB_CLR)
				return false;
			return true;
		}
		
	}
}