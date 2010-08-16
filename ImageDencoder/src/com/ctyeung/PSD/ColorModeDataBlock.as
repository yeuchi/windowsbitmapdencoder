// ==================================================================
// Module: 		ColorModeDataBlock.as
//
// Description:	Segment immediate after PSD file header
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

	public class ColorModeDataBlock
	{
//		BYTE Type[4];  /* Always "8BIM" */
//		WORD ID;       /* (See table below) */
//		BYTE Name[];   /* Even-length Pascal-format string, 2 bytes or longer */
//		LONG Size;     /* Length of resource data following, in bytes */
//		BYTE Data[];   /* Resource data, padded to even length */
		protected var blockLen:uint;
		protected var modeBlock:ByteArray;
		public static const RESOLUTION_INFO:String = "resolutionInfo";
		
		public function ColorModeDataBlock() {
		}
		
		public function decode(bytes:ByteArray, mode:int):Boolean {
			blockLen = bytes.readUnsignedInt();
			if(mode!=2&&mode!=6) {
				type = bytes.readMultiByte(4, "ascii");
				id = bytes.readShort();
				dataFormatDes();
				modeBlock = new ByteArray();
				modeBlock.readBytes(bytes, 0, blockLen);
			}
			return true;
		}
		
		protected function resolutionInfo():void {
			typedef struct _ResolutionInfo
			{
				LONG hRes;              /* Fixed-point number: pixels per inch */
				WORD hResUnit;          /* 1=pixels per inch, 2=pixels per centimeter */
				WORD WidthUnit;         /* 1=in, 2=cm, 3=pt, 4=picas, 5=columns */
				LONG vRes;              /* Fixed-point number: pixels per inch */
				WORD vResUnit;          /* 1=pixels per inch, 2=pixels per centimeter */
				WORD HeightUnit;        /* 1=in, 2=cm, 3=pt, 4=picas, 5=columns */
			} RESOLUTIONINFO;
		}
		
//		The next area following contains a series of Channel Length Info records, defined as follows:
//		
//		typedef struct _CLI
//		{
//			WORD  ChannelID;            /* Channel Length Info field one */
//			LONG  LengthOfChannelData;  /* Channel Length Info field two */
//		} CLI;
		
		protected function dataFormatDes():String {
			switch(id) {
				case 03E8:
					break;
				
				case 03E9:
				break;
				
				case 03ED:
					return RESOLUTION_INFO:
					
				case 03EE:
				break;
				
				case 03EF:
				break;
				
				case 03F1:
				break;
				
				case 03F5:
				break;
				
				case 03F6:
				break;
				
				case 03F7:
				break;
				
				case 03F8:
				break;
				
				case 03F9:
				break;
				
				case 03FB:
				break;
				
				case 03FE:
				break;
				
				case 0400:
				break;
				
				case 0401:
				break;
				
				case 0402:
				break;
				
				case 0404:
				break;
				
				case 2710:
				break;
				
				case 03EB:		// obsolete
				case 03ED:		// obsolete
				case 0403:		// obsolete
				case 03FF:		// obsolete
				break;
				
				case 03F2:		// PhotoShop secrets
				case 03F3:
				case 03F4:		// PhotoShop secrets
				case 03FA:		// PhotoShop secrets
				case 03FC:		// PhotoShop secrets
				case 03FD:		// PhotoShop secrets
				case 0405:		// PhotoShop secrets
				case 0406:		// PhotoShop secrets
				case 0BB7:		// PhotoShop secrets
				break;
				
				default:
				if(id>07D0&&id<0BB6) {
					
				}
				break;
			}
		}
	}
}