// ==================================================================
// Module:		TGAPalette.as
//
// Description:	Targa Palette class
// 				- bitmapheader 
//
// Author(s):	C.T. Yeung 	(cty)
//
// History:
// 29Apr10		start working on this 							cty
//
// Copyright (c) 2010 C.T.Yeung

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
package com.ctyeung.Targa
{
	import flash.utils.ByteArray;

	public class TGAPalette
	{
		public var palette:Array;
		public var hdr:TGAHeader;
		protected var dictionary:Dictionary;
		protected var keys:Array;
		
		public function TGAPalette(hdr:TGAHeader) {
			this.hdr 	= hdr;
			palette 	= new Array();
		}
		
		public function dispose():void {
			
		}
		
		public function decode(bytes:ByteArray):Boolean {
			if(!hdr.clrMapLen)
				return true;
			
			switch(hdr.clrMapEntrySze) {
				case TGATypeEnum.CLR_MAP_SIZE_16:
					return decode16(bytes);
				
				case TGATypeEnum.CLR_MAP_SIZE_24:
					return decode24(bytes);
				
				case TGATypeEnum.CLR_MAP_SIZE_32:
					return decode32(bytes);
			}
			return false;
		}
		
		protected function decode16(bytes:ByteArray):Boolean {
			
		}
		
		protected function decode24(bytes:ByteArray):Boolean {
			
		}
		
		protected function decode32(bytes:ByteArray):Boolean {
			
		}
	}
}