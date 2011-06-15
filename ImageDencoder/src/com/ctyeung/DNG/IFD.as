//The following values are supported for thumbnail and preview IFDs only:
//•1 = BlackIsZero. Assumed to be in a gamma 2.2 color space, unless otherwise specified using PreviewColorSpace tag.
//•2 = RGB. Assumed to be in the sRGB color space, unless otherwise specified using the PreviewColorSpace tag.
//•6 = YCbCr. Used for JPEG encoded preview images.
	
package com.ctyeung.DNG
{
	import com.ctyeung.TIFF6.Header;
	import com.ctyeung.TIFF6.IFD;
	
	public class IFD extends com.ctyeung.TIFF6.IFD
	{
		public function IFD(hdr:Header=null)
		{
			super(hdr);
		}
	}
}