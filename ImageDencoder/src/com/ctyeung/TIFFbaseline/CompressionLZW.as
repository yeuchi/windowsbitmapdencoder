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
package com.ctyeung.TIFFbaseline
{
	import flash.utils.ByteArray;
	
	public class CompressionLZW
	{
		private static const MAX_LEN:int 		= 4096;	// max number of table entries
		private static const CLEAR_CODE:uint 	= 256;	// index 256 is reserved for clear code
		private static const END_CODE:uint 		= 257;	// index 257 is reserved for end code
		private static const FIRST_INDEX:uint	= 258;	// table index of first entry to add
		
		private var bitIndex:Number;					// current bit index
		private var table:Array;						// look up table
		private var pixels:ByteArray;					// [out] product image pixels 
		
		public function CompressionLZW() {
			empty();
		}
		
		public function empty():void {
			table = null;
			bitIndex = 0;
			pixels.clear();
		}
		
		public function decode(bytes:ByteArray):ByteArray {
			pixels = new ByteArray();
			var oldCode:uint;
			var outString:String;
			
			for(var c:int = 0; c<MAX_LEN; c++) {
				var code:uint  = getNextCode(bytes, c);
				if(code == END_CODE)	return pixels;				// done !
				
				if(code == CLEAR_CODE) {
					initTable();
					code = getNextCode(bytes, ++c);
					if(code == END_CODE) break;
					writeString(stringFromCode(code));
					oldCode = code;
				}
				else {
					if(isInTable(code)) {
						writeString(stringFromCode(code));
						addString2Table(stringFromCode(oldCode) + firstChar(stringFromCode(code)));
						oldCode = code;
					}
					else {
						outString = stringFromCode(oldCode)+ firstChar(stringFromCode(oldCode));
						writeString(outString);
						addString2Table(outString);
						oldCode = code;
					}
				}
			}
			return pixels;
		}

		private function firstChar(str:String):String {
			return str.substr(0,1);	
		}
		
		private function getNextCode(bytes:ByteArray,		// [in] compressed data
									 codeIndex:int)			// [in] num of code parsed
									 :uint {				// [out] next code
			var code:uint = 0;
			var pos:uint = bitIndex / 8;
			var numOfBits:uint = getBitDepth(codeIndex);
			var bitOffset:uint = bitIndex % 8;
			var mask:uint = 0x80 >> bitOffset;
			
			for (var i:int = 0; i<numOfBits; i++) {
				code += ( bytes[pos] & mask )? 0x01 << i : 0;
				mask = (mask == 0x01)?0x80:mask >> 1;
			}
			bitIndex += numOfBits;
			return code;
		}
		
		private function getBitDepth(tableNum:int):int {
			if(tableNum < 512) 		return 9;
			if(tableNum < 1024)		return 10;
			if(tableNum < 2048)		return 11;
			if(tableNum < MAX_LEN)	return 12;
			return -1;			// should never get here
		}
		
		private function initTable():void {
			table = new Array();
			// fill table initial values
			for (var i:int=0; i<FIRST_INDEX; i++) {
				table.push(i.toString());
			}
		}
		
		private function isInTable(code:uint):Boolean {
			if(code < table.length) return true;
			return false;			
		}
		
		private function writeString(str:String):void {
			var value:int;

			for(var i:int=0; i<str.length; i++) {
				value = parseInt(str.substr(i,1));				
				pixels.writeByte(value);
			}
		}
		
		private function stringFromCode(code:uint):String {
			return table[code];
		}
		
		private function addString2Table(str:String):void {
			table.push(str);
		}
			
		}
}