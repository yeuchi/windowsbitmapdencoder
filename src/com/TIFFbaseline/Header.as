// ==================================================================
// Module:			Header.as
//
// Description:		File header for Adobe TIFF file v6.0
//
// Author(s):		C.T. Yeung
// Company:			Jostens 2009
//
// History:
// 23Feb09			start coding								cty
// ==================================================================
package com.TIFFbaseline
{
	import flash.utils.ByteArray;
	
	public class Header
	{
		// TIFF Header -- Byte Order
		public static const INTEL:uint 		= 100;
		public static const MOTOROLA:uint 	= 101;
		public static const SIZE:uint 		= 8;
		
		public var sType:String;			// (2 bytes) II = Intel :: MM = Motorola
		public var nFirstIFD:uint;			// (4 bytes) offset to the first image file directory

/////////////////////////////////////////////////////////////////////
// initialization
	
		public function Header()
		{
		}
		
		public function empty():void
		{
			sType 		= "";
			nFirstIFD 	= 0;
		}
		
		public function isEmpty():Boolean
		{
				return false;
			return true;
		}
		
/////////////////////////////////////////////////////////////////////
// properties

		public function get byteOrder():uint
		{
			if(sType == "II")	return INTEL;
			if(sType == "MM")	return MOTOROLA;
			return 0;
		}
		
		public function set byteOrder(type:uint):void
		{
			sType = "";
			if(type == INTEL)			sType = "II";
			else if (type == MOTOROLA) 	sType = "MM";
		}
		
/////////////////////////////////////////////////////////////////////
// public
	
		public function encode():ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(sType, "us-ascii");
			if(byteOrder==INTEL) {
				bytes.writeByte(0);
				bytes.writeByte(42);
				bytes.writeByte(0);
				bytes.writeByte(0);
				bytes.writeByte(0);
				bytes.writeByte(SIZE);
			}
			else {
				bytes.writeByte(42);
				bytes.writeByte(0);
				bytes.writeByte(SIZE);
				bytes.writeByte(0);
				bytes.writeByte(0);
				bytes.writeByte(0);
			}
			return bytes;
		}
		
		public function decode(bytes:ByteArray):Boolean
		{
			if (bytes.length < SIZE) return false;
			if ((bytes[0] == INTEL) && (bytes[1] == INTEL))	
				byteOrder = INTEL;
			else if ((bytes[0] == MOTOROLA) && (bytes[1] == MOTOROLA))
				byteOrder = MOTOROLA;
			else return false;
			
			// file version number
			var nVersion:uint = (byteOrder == INTEL)?
								uint(bytes[2]) + (uint(bytes[3]) << 8):
								uint(bytes[3]) + (uint(bytes[2]) << 8); 
			if (nVersion!=42) return false;
			
			// first IFD offset
			nFirstIFD =  (byteOrder == INTEL)?
						 uint(bytes[4])+(uint(bytes[5]) << 8)+
						 (uint(bytes[6]) << (8*2))+(uint(bytes[7]) << (8*3)):
						 uint(bytes[7])+(uint(bytes[6]) << 8)+
						 (uint(bytes[5]) << (8*2))+(uint(bytes[4]) << (8*3));
			
			if(nFirstIFD>bytes.length)	return false;
			if( uint(bytes[8]) + uint(bytes[9]) +
				uint(bytes[10]) + uint(bytes[11]) != 0 ) return false;
				
			return true;
		}
	}
}