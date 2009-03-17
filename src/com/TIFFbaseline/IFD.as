// ==================================================================
// Module:			IFD.as
//
// Description:		Image file directory for Adobe TIFF file v6.0
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
	
	public class IFD
	{
		public var nNumDE:uint;				// (2 bytes) Number of Directory Entry
		public var lNextIFD:uint;			// (4 bytes) Offset to next Image File Directory
		public var aryDirEntries:Array		// directory entries container
		protected var hdr:Header;
				
/////////////////////////////////////////////////////////////////////
// initialization

		public function IFD(hdr:Header=null)
		{
			empty();
			this.hdr = hdr;
		}
		
		public function empty():void
		{
			nNumDE			= 0;
			lNextIFD		= 0; 
			aryDirEntries = new Array();
		}
		
		public function isEmpty():Boolean
		{
			if(nNumDE)
				return false;
			return true;
		}
		
		public function setRef(hdr:Header):void
		{
			this.hdr = hdr;
		}
		
/////////////////////////////////////////////////////////////////////
// public

		public function getDirEntry(field:uint):DirEntry
		{
			for ( var i:int=0; i<aryDirEntries.length; i++) {
				var dirEntry:DirEntry = aryDirEntries[i];
				if(dirEntry.nTAG == field)
					return dirEntry;
			}
			return null;
		}
		
		public function getDirEntryValue(field:uint):Array
		{
			var entry:DirEntry = getDirEntry(field);
			return entry.aryValue;
		}
		
		public function encode():Boolean
		{
			return true;
		}
		
		public function decode(bytes:ByteArray):Boolean
		{
			if(!hdr)		return false;
			if(!isEmpty())	empty();
			var offset:uint = Header.SIZE;
			
			nNumDE = (hdr.byteOrder == Header.INTEL)?
						bytes[offset] +(uint( bytes[offset+1])<<8):
						bytes[offset+1] +(uint( bytes[offset])<<8);
			
			// Get all the diretory entries
			for ( var i:int=0; i<nNumDE; i++) {
				var dirEntry:DirEntry = new DirEntry(hdr);
				if(!dirEntry.decode(bytes, i, offset)) return false;
				aryDirEntries.push(dirEntry);
			}
			
			// not going to this value for baseline... but get it anyway
			offset += nNumDE*DirEntry.SIZE;
			lNextIFD = (hdr.byteOrder == Header.INTEL)?
						bytes[offset]+(uint( bytes[offset+1])<<8)+
						(uint( bytes[offset+2])<<(8*2))+(uint( bytes[offset+3])<<(8*3)):
						bytes[offset+3]+(uint( bytes[offset+2])<<8)+
						(uint( bytes[offset+1])<<(8*2))+(uint( bytes[offset])<<(8*3));
			return true;
		}
	}
}