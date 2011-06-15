// ==================================================================
// Module:		DNGEncoder.as
//
// Description:	Adobe's Digital Negative encoder
// 				Base on Adobe DNG specification v 1.3.0.0 June 2009
//
//				DNG is an extension of TIFF 6.0 and compatible with
//				TIFF-EP standard.
//
//				I did not write an encoder for TIFF, so starting
//				from scratch here.
//
//				There is no real sense of encoding a 24 bbp image as
//				DNG that I can see.  Format is designed for raw 
//				digital images.  Anyhow, it is a first step.
//
// Author(s):	Chi T. Yeung (CTY)
//
// Input:		BitmapData
// Output:		File written to disk in DNG format
//
// History:
//  12Jun11		start											cty
// ==================================================================
package com.ctyeung.DNG
{
	public class DNGEncoder 
	{
		public function DNGEncoder()
		{
		}
	}
}