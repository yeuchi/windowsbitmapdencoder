// ==================================================================
// Module:			Fields.as
//
// Description:		Tag and data fields for Adobe TIFF file v6.0
//
// Author(s):		C.T. Yeung
//
// History:
// 23Feb09			start coding								cty
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
	public class Fields
	{
		// NewSubfileType
		public static const NEWSUBFILETYPE:uint = 254;	// kind of data in this subfile
		public static const DEFAULT:uint 		= 0		// see TIFF specs.  	

		// SubfileType
		public static const SUBFILETYPE:uint	= 255	// kinda data in subfile
		public static const FULL_RES:uint 		= 1		// full res. image 
		public static const LOW_RES	:uint		= 2		// reduced res. image
		public static const MULTI_PAGE:uint		= 3		// single page of multi-page image

		// ImageWidth
		public static const IMAGEWIDTH:uint		= 256	// columns of pixels in image

		// ImageLength
		public static const IMAGELENGTH:uint	= 257	// rows of pixels in image
		
		// BitsPerSample		 
		public static const BITSPERSAMPLE:uint	= 258	// number of bits per component
		
		// Compression			
		public static const COMPRESSION:uint	= 259	// scheme for image data
		public static const NO_COMPRESSION:uint	= 1		// default
		public static const CCITT3_CMPRSSN:uint	= 2		// CCITT group 3
		public static const PCKBIT_CMPRSSN:uint	= 32773	// pack bits 
		
		// PhotometricInterpretation
		public static const PHOTOMETRICINTERPRETATION:uint=	262	// color space of image
		public static const WHITE_ZERO:uint		= 0		// white is zero for bilevel & gray scale images
		public static const BLACK_ZERO:uint		= 1		// black is zero for bilevel & gray scale images
		public static const RGB_CLR:uint		= 2		// RGB 
		public static const PAL_CLR:uint		= 3		// RGB palette Color
		public static const MASK:uint			= 4		// transparency mask
		public static const CMYK_CLR:uint		= 5		// CMYK color space
		public static const YCbCr:uint			= 6		// Y I Q space
		public static const CIE_Lab:uint		= 7		// CIE space
		
		// Thresholding
		public static const THRESHOLDING:uint	= 263	// black and white only
		public static const NO_HALFTONE:uint	= 1		// no dithering applied
		public static const AM_SCREEN:uint		= 2		// ordered dithering, amplitude modulation applied
		public static const FM_SCREEN:uint		= 3		// randomized process, frequency modulation applied
		
		// CellWidth			
		public static const CELLWIDTH:uint		= 264	// width of halftone matrix
		
		// CellLength			
		public static const CELLLENGTH:uint		= 265	// length of halftone matrix
		
		// FillOrder
		public static const FILLORDER:uint		= 266	// logical order of bits in a byte
		public static const LOWHIGH:uint		= 1		//	i.e. Pixel 0 store in high-order bit (default)
		public static const HIGHLOW:uint		= 2		// i.e. Pixel 0 store in low-order bit
		
		// Document name
		public static const DOCUMENTNAMET:uint	= 269
		
		// ImageDescription
		public static const IMAGEDESCRIPTION:uint= 270	// string describing image
		
		// Make
		public static const MAKE:uint			= 271	// scanner manufacturer
		
		// Model
		public static const MODEL:uint			= 272	// scanner model name or number
		
		// StripOffsets
		public static const STRIPOFFSETS:uint	= 273	// byte offset to each strip
		
		// Orientation
		public static const ORIENTATION:uint	= 274	// orientation of image 
		public static const TOP_LEFT:uint		= 1		// default
		public static const TOP_RIGHT:uint		= 2
		public static const BOT_RIGHT:uint		= 3
		public static const BOT_LEFT:uint		= 4
		public static const LEFT_TOP:uint		= 5
		public static const RIGHT_TOP:uint		= 6
		public static const RIGHT_BOT:uint		= 7
		public static const LEFT_BOT:uint		= 8
		
		// SamplePerPixel
		public static const SAMPLESPERPIXEL:uint= 277	// number of components per pixel
		
		// RowsPerStrip
		public static const ROWSPERSTRIP:uint	= 278	// rows per image strip
		
		// StripByteCounts
		public static const STRIPBYTECOUNTS:uint= 279	// bytes in strip after compression
		
		// MinSampleValue
		public static const MINSAMPLEVALUE:uint	= 280	// minimum component value used
		
		// MaxSampleValue
		public static const MAXSAMPLEVALUE:uint	= 281	// maximum component value used
		
		// XResolution
		public static const XRESOLUTION:uint	= 282	// num of pixels per resolution unit ( X )
		
		// YResolution
		public static const YRESOLUTION:uint	= 283	// num of pixels per resolution unit ( Y )
		
		// PlanarConfiguration
		public static const PLANARCONFIGURATION:uint= 284// order the pixels are stored
		public static const CHUNCKY:uint		= 1		// Interlaced data i.e. RGBRGBRGB....
		public static const PLANAR:uint			= 2		// separate planes i.e. RRRR..... GGGG....
		
		// Page name
		public static const PAGENAME:uint		= 285
		
		// FreeOffsets
		public static const FREEOFFSETS:uint	= 288	// offset of the unused string
		
		// FreeByteCount
		public static const FREEBYTECOUNTS:uint	= 289	// num of bytes of a unused string
		
		// GrayResponseUnit
		public static const GRAYRESPONSEUNIT:uint= 290	// precision of data in GrayResponseCurve
		public static const TENTHS:uint			= 1
		public static const HUNDREDTHS:uint		= 2		// default
		public static const THOUSANDTHS:uint	= 3
		public static const TEN_THOUSAN:uint	= 4
		public static const HUNDRED_THOU:uint	= 5
		
		// GrayResponseCurve							
		public static const GRAYRESPONSECURVE:uint= 291	// optical density of every possible pixel
														// gray scale data ONLY!
		// ResolutionUnit
		public static const RESOLUTIONUNIT:uint	= 296	// unit of resolution measure
		public static const NO_ABSOLUTE:uint	= 1		// for non-square aspect ratio
		public static const INCH:uint			= 2		// default
		public static const CENT:uint			= 3		// centimeter
		
		// Software
		public static const SOFTWARE:uint		= 305	// name & version of software
		
		// DateTime		
		public static const DATETIME:uint		= 306	// date & time of image creation
		
		// Artist								
		public static const ARTIST:uint			= 315	// person who create the image
		
		// HostComputer
		public static const HOSTCOMPUTER:uint	= 316	// computer at time of image creation
		
		// ColorMap				
		public static const COLORMAP:uint		= 320	// color map for palette color image
		
		// ExtraSamples 
		public static const EXTRASAMPLES:uint	= 338	// description of extra component
		public static const UNSPECIFIED:uint	= 0		// unspecified
		public static const ASSOC_ALPHA:uint	= 1		// associated alpha data
		public static const UNASS_ALPHA:uint	= 2		// unassociated alpha data
		
		// Copyright						
		public static const COPYRIGHT:uint		= 33432	// copyright notice
	}
}