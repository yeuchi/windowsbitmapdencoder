// ==================================================================
// Module:			CompressionZIP.as
//
// Description:		zip compression
//
// Author(s):		C.T. Yeung
//
// History:
// 27Jul09			working on zip								cty

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
package com.ctyeung.TIFFbaseline
{
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
	public class CmpZIP extends CmpBase
	{
		protected var stripIndex:int;	// info.strip
		protected var blockIndex:int;	// index within a decompressed strip
		protected var rowOfPixels:ByteArray;
		
		public function CmpZIP(info:ImageInfo,
							   bytesCmp:ByteArray,
							   lineByteWid:int) {
							   	
			super(info, bytesCmp, lineByteWid);
			bytes = decode(bytesCmp, info.stripOffset[0], info.stripByteCount[0]);
			stripIndex = 0;
			rowOfPixels = new ByteArray();
		}
		
		override public function decode(bytesCmp:ByteArray,	// [in] compressed data
										offset:int,			// [in] start position
										length:int)			// [in] length of block
										:ByteArray {		// [out] uncompressed data
			bytes = new ByteArray();
			bytes.writeBytes(bytesCmp, offset, length);
			bytes.uncompress();//CompressionAlgorithm.DEFLATE);
			return bytes;
		}
		
		override public function getRow(index:int)
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