// ==================================================================
// Module:			CompressionLZW.as
//
// Description:		Unisys LZW compression
//
// Reference:		http://www.fileformat.info/format/tiff/corion-lzw.htm
//
// Author(s):		C.T. Yeung
//
// History:
// 27Jul09			working on LZW	(not functional yet!!!)			cty

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
package com.ctyeung.TIFF6
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class CmpLZW extends CmpBase
	{
		// entry index for bit depth
		private static const BITS9MAX:int		= 512;
		private static const BITS10MAX:int		= 1024;
		private static const BITS11MAX:int		= 2048;
		private static const BITS12MAX:int		= 4094;
		
		private static const MAX_TABLE_LEN:int 	= BITS12MAX;	// max number of table entries
		private static const CLEAR_CODE:uint 	= 256;			// index 256 is reserved for clear code
		private static const END_CODE:uint 		= 257;			// index 257 is reserved for end code
		
		private var bitIndex:Number;							// current bit index
		private var table:Array;								// look up table
		private var pixels:ByteArray;							// [out] product image pixels 
		protected var dictionary:Dictionary;
		protected var key:uint;
		
		public function CmpLZW(info:ImageInfo,
							   bytesCmp:ByteArray,
							   lineByteWid:int) {
			super(info, bytesCmp, lineByteWid);
			empty();
			pixels = new ByteArray();
		}
		
		override public function dispose():void {
			super.dispose();
			pixels = null;
			table  = null;
			dictionary = null;
		}
		
		override public function empty():void {
			initTable();
			bitIndex = 0;
			if(pixels)
				pixels.clear();
		}
		
		override protected function decode( offset:uint,		// [in] start position
											length:uint)		// [in] length of block
											:ByteArray {		// [out] uncompressed data

			var oldCode:uint;
			var code:uint;
			var outString:Array;
			bitIndex = 0;
			
			if(CLEAR_CODE != getNextCode(offset))
				return null;
			
			initTable();									// create table
			oldCode = getNextCode(offset);					// 1st code
			writeString([oldCode]);							// 1st pixel
			
			for(var c:int=2; c<length; c++) {
				code = getNextCode(offset);
				if(code == END_CODE)	
					return pixels;							// done !
				
				if(code == CLEAR_CODE) {
					initTable();
					
					code = getNextCode(offset);
					if(code == END_CODE) 
						break;
					
					writeString(stringFromCode(code));
					oldCode = code;
				}
				else if(isInTable(code)) {
						writeString(stringFromCode(code));
						var str:Array = stringFromCode(oldCode);
						str.push(firstChar(stringFromCode(code)));
						addString2Table(str);
						oldCode = code;
				}
				else {
					outString = stringFromCode(oldCode);
					outString.push( firstChar(stringFromCode(oldCode)));
					writeString(outString);
					addString2Table(outString);
					oldCode = code;
				}
			}
			return pixels;
		}

		private function firstChar(str:Array):uint {
			return str[0];	
		}
		
		private function getNextCode(offset:uint)			// [in] compressed data
									 :uint {				// [out] next code
			var code:uint 		= 0;
			var bit:uint 		= 0;
			var byteIndex:uint 	= bitIndex / 8;
			var bitOffset:uint 	= bitIndex % 8;
			var mask:uint 		= 0x80 >> bitOffset;
			
			for (var i:int = 0; i<codeLen; i++) {			// step through all the bits
				bit =   bytes[offset+byteIndex+bytePos(i, bitOffset)] & mask;
				bit /=  mask;
				bit <<= (codeLen-1) - i;						// build the code
				code += bit;
				mask = (mask == 0x01)?0x80:mask >> 1;		// bit shift 
			}
			bitIndex += codeLen;							// update index 
			return code;
		}
		
		protected function get codeLen():int {
			var len:uint = dictionary.length;
			if(len < BITS9MAX) 	return 9;
			if(len < BITS10MAX)	return 10;
			if(len < BITS11MAX)	return 11;
			if(len < BITS12MAX)	return 12;
			return -1;			// should never get here
		}
		
		protected function bytePos(bits:uint,
								   bitOffset:int)
								   :uint {
			if (bits >= (8-bitOffset)) 
				return 1;
			return 0;
		}
		
		private function initTable():void {
			dictionary = new Dictionary();
			// fill table initial values
			key = 256;
			dictionary[key++] = [CLEAR_CODE]; // may have to change byte order
			dictionary[key++] = [END_CODE];
		}
		
		private function isInTable(code:uint):Boolean {
			if (dictionary == null) // E.Beli 22 sep 2009
                initTable();

            if (code < key)
                return true;
            return false;			
		}
		
		private function writeString(str:Array):void {
			var value:int;

			for(var i:int=0; i<str.length; i++) {
				pixels.writeByte(str[i]);
			}
		}
		
		private function stringFromCode(code:uint):Array {
			var nums:Array = (code>=CLEAR_CODE)?dictionary[code]:[code];
			return nums;
		}
		
		private function addString2Table(str:Array):void {
			dictionary[key] = str;
			key++;
		}
	}
}