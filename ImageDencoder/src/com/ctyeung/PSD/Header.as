// Reference:   http://www.fileformat.info/format/psd/egff.htm
package com.ctyeung.PSD
{
	public class Header
	{
		BYTE Signature[4];   /* File ID "8BPS" */
		WORD Version;        /* Version number, always 1 */
		BYTE Reserved[6];    /* Reserved, must be zeroed */
		WORD Channels;       /* Number of color channels (1-24) including alpha
		channels */
		LONG Rows;           /* Height of image in pixels (1-30000) */
		LONG Columns;        /* Width of image in pixels (1-30000) */
		WORD Depth;          /* Number of bits per channel (1, 8, and 16) */
		WORD Mode;           /* Color mode */
		
		Mode
		
		Description
		
		0
		
		Bitmap (monochrome)
		
		1
		
		Gray-scale
		
		2
		
		Indexed color (palette color)
		
		3
		
		RGB color
		
		4
		
		CMYK color
		
		7
		
		Multichannel color
		
		8
		
		Duotone (halftone)
		
		9
		
		Lab color
		public function Header()
		{
		}
	}
}