package openfl._internal.renderer;


import openfl.display.BitmapData;
import openfl.display.CapsStyle;
import openfl.display.GradientType;
import openfl.display.GraphicsPathWinding;
import openfl.display.InterpolationMethod;
import openfl.display.JointStyle;
import openfl.display.LineScaleMode;
import openfl.display.Shader;
import openfl.display.SpreadMethod;
import openfl.display.TriangleCulling;
import openfl.geom.Matrix;
import openfl.Vector;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end

@:allow(openfl._internal.renderer.DrawCommandReader)


class DrawCommandBuffer {
	
	
	private static var empty:DrawCommandBuffer = new DrawCommandBuffer ();
	
	public var length (get, never):Int; 
	public var types:Array<DrawCommandType>;
	
	private var b:Array<Bool>;
	private var copyOnWrite:Bool;
	private var f:Array<Float>;
	private var ff:Array<Array<Float>>;
	private var i:Array<Int>;
	private var ii:Array<Array<Int>>;
	private var o:Array<Dynamic>;
	
	private var t_i = 0;
	private var b_i = 0;
	private var f_i = 0;
	private var ff_i = 0;
	private var i_i = 0;
	private var ii_i = 0;
	private var o_i = 0;
	
	public function new () {
		
		if (empty == null) {
			
			types = new Array<DrawCommandType>();
			
			b = new Array<Bool>();
			i = new Array<Int>();
			f = new Array<Float>();
			o = new Array<Dynamic>();
			ff = new Array<Array<Float>>();
			ii = new Array<Array<Int>>();
			
			copyOnWrite = true;
			
		} else {
			
			__initFromEmpty ();
			
		}
		
	}
	
	
	public function append (other:DrawCommandBuffer):DrawCommandBuffer {
		
		if (length == 0) {
			
			this.types = other.types;
			this.b = other.b;
			this.i = other.i;
			this.f = other.f;
			this.o = other.o;
			this.ff = other.ff;
			this.ii = other.ii;
			this.t_i = other.t_i;
			this.b_i = other.b_i;
			this.f_i = other.f_i;
			this.ff_i = other.ff_i;
			this.i_i = other.i_i;
			this.ii_i = other.ii_i;
			this.o_i = other.o_i;
			this.copyOnWrite = other.copyOnWrite = true;
			
			return other;
			
		}
		
		var data = new DrawCommandReader (other);
		
		for (type in other.types) {
			
			switch (type) {
				
				case BEGIN_BITMAP_FILL: var c = data.readBeginBitmapFill (); beginBitmapFill (c.bitmap, c.matrix, c.repeat, c.smooth);
				case BEGIN_FILL: var c = data.readBeginFill (); beginFill (c.color, c.alpha);
				case BEGIN_GRADIENT_FILL: var c = data.readBeginGradientFill (); beginGradientFill (c.type, c.colors, c.alphas, c.ratios, c.matrix, c.spreadMethod, c.interpolationMethod, c.focalPointRatio);
				case CUBIC_CURVE_TO: var c = data.readCubicCurveTo (); cubicCurveTo (c.controlX1, c.controlY1, c.controlX2, c.controlY2, c.anchorX, c.anchorY);
				case CURVE_TO: var c = data.readCurveTo (); curveTo (c.controlX, c.controlY, c.anchorX, c.anchorY);
				case DRAW_CIRCLE: var c = data.readDrawCircle (); drawCircle (c.x, c.y, c.radius);
				case DRAW_ELLIPSE: var c = data.readDrawEllipse (); drawEllipse (c.x, c.y, c.width, c.height);
				case DRAW_RECT: var c = data.readDrawRect (); drawRect (c.x, c.y, c.width, c.height);
				case DRAW_ROUND_RECT: var c = data.readDrawRoundRect (); drawRoundRect (c.x, c.y, c.width, c.height, c.ellipseWidth, c.ellipseHeight);
				case DRAW_TRIANGLES: var c = data.readDrawTriangles (); drawTriangles (c.vertices, c.indices, c.uvtData, c.culling);
				case END_FILL: var c = data.readEndFill (); endFill ();
				case LINE_BITMAP_STYLE: var c = data.readLineBitmapStyle (); lineBitmapStyle (c.bitmap, c.matrix, c.repeat, c.smooth);
				case LINE_GRADIENT_STYLE: var c = data.readLineGradientStyle (); lineGradientStyle (c.type, c.colors, c.alphas, c.ratios, c.matrix, c.spreadMethod, c.interpolationMethod, c.focalPointRatio);
				case LINE_STYLE: var c = data.readLineStyle (); lineStyle (c.thickness, c.color, c.alpha, c.pixelHinting, c.scaleMode, c.caps, c.joints, c.miterLimit);
				case LINE_TO: var c = data.readLineTo (); lineTo (c.x, c.y);
				case MOVE_TO: var c = data.readMoveTo (); moveTo (c.x, c.y);
				case OVERRIDE_MATRIX: var c = data.readOverrideMatrix (); overrideMatrix (c.matrix);
				case WINDING_EVEN_ODD: var c = data.readWindingEvenOdd (); windingEvenOdd ();
				case WINDING_NON_ZERO: var c = data.readWindingNonZero (); windingNonZero ();
				default:
				
			}
			
		}
		
		data.destroy ();
		return other;
		
	}
	
	
	public function beginBitmapFill (bitmap:BitmapData, matrix:Matrix, repeat:Bool, smooth:Bool):Void {
		
		prepareWrite ();
		
		types[t_i++] = BEGIN_BITMAP_FILL;
		o[o_i++] = bitmap;
		o[o_i++] = matrix;
		b[b_i++] = repeat;
		b[b_i++] = smooth;
		
	}
	
	public function beginFill (color:Int, alpha:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = BEGIN_FILL;
		i[i_i++] = color;
		f[f_i++] = alpha;
		
	}
	
	
	public function beginGradientFill (type:GradientType, colors:Array<Int>, alphas:Array<Float>, ratios:Array<Int>, matrix:Matrix, spreadMethod:SpreadMethod, interpolationMethod:InterpolationMethod, focalPointRatio:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = BEGIN_GRADIENT_FILL;
		o[o_i++] = type;
		ii[ii_i++] = colors;
		ff[ff_i++] = alphas;
		ii[ii_i++] = ratios;
		o[o_i++] = matrix;
		o[o_i++] = spreadMethod;
		o[o_i++] = interpolationMethod;
		f[f_i++] = focalPointRatio;
		
	}
	
	
	public function clear ():Void {
		
		t_i = 0;
		b_i = 0;
		f_i = 0;
		ff_i = 0;
		i_i = 0;
		ii_i = 0;
		o_i = 0;

	}
	
	
	public function copy ():DrawCommandBuffer {
		
		var copy = new DrawCommandBuffer ();
		copy.append (this);
		return copy;
		
	}
	
	
	public function cubicCurveTo (controlX1:Float, controlY1:Float, controlX2:Float, controlY2:Float, anchorX:Float, anchorY:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = CUBIC_CURVE_TO;
		f[f_i++] = controlX1;
		f[f_i++] = controlY1;
		f[f_i++] = controlX2;
		f[f_i++] = controlY2;
		f[f_i++] = anchorX;
		f[f_i++] = anchorY;
		
	}
	
	public function curveTo (controlX:Float, controlY:Float, anchorX:Float, anchorY:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = CURVE_TO;
		f[f_i++] = controlX;
		f[f_i++] = controlY;
		f[f_i++] = anchorX;
		f[f_i++] = anchorY;
		
	}
	
	
	public function destroy ():Void {
		
		types = null;
		
		b = null;
		i = null;
		f = null;
		o = null;
		ff = null;
		ii = null;
		
	}
	
	
	public function drawCircle (x:Float, y:Float, radius:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = DRAW_CIRCLE;
		f[f_i++] = x;
		f[f_i++] = y;
		f[f_i++] = radius;
		
	}
	
	
	public function drawEllipse (x:Float, y:Float, width:Float, height:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = DRAW_ELLIPSE;
		f[f_i++] = x;
		f[f_i++] = y;
		f[f_i++] = width;
		f[f_i++] = height;
		
	}
	
	
	public function drawRect (x:Float, y:Float, width:Float, height:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = DRAW_RECT;
		f[f_i++] = x;
		f[f_i++] = y;
		f[f_i++] = width;
		f[f_i++] = height;
		
	}
	
	public function drawRoundRect (x:Float, y:Float, width:Float, height:Float, ellipseWidth:Float, ellipseHeight:Null<Float>):Void {
		
		prepareWrite ();
		
		types[t_i++] = DRAW_ROUND_RECT;
		f[f_i++] = x;
		f[f_i++] = y;
		f[f_i++] = width;
		f[f_i++] = height;
		f[f_i++] = ellipseWidth;
		o[o_i++] = ellipseHeight;
		
	}
	
	
	public function drawTriangles (vertices:Vector<Float>, indices:Vector<Int>, uvtData:Vector<Float>, culling:TriangleCulling):Void {
		
		prepareWrite ();
		
		types[t_i++] = DRAW_TRIANGLES;
		o[o_i++] = vertices;
		o[o_i++] = indices;
		o[o_i++] = uvtData;
		o[o_i++] = culling;
		
	}
	
	
	public function endFill ():Void {
		
		prepareWrite ();
		
		types[t_i++] = END_FILL;
		
	}
	
	
	public function lineBitmapStyle (bitmap:BitmapData, matrix:Matrix, repeat:Bool, smooth:Bool):Void {
		
		prepareWrite ();
		
		types[t_i++] = LINE_BITMAP_STYLE;
		o[o_i++] = bitmap;
		o[o_i++] = matrix;
		b[b_i++] = repeat;
		b[b_i++] = smooth;
		
	}
	
	
	public function lineGradientStyle (type:GradientType, colors:Array<Int>, alphas:Array<Float>, ratios:Array<Int>, matrix:Matrix, spreadMethod:SpreadMethod, interpolationMethod:InterpolationMethod, focalPointRatio:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = LINE_GRADIENT_STYLE;
		o[o_i++] = type;
		ii[ii_i++] = colors;
		ff[ff_i++] = alphas;
		ii[ii_i++] = ratios;
		o[o_i++] = matrix;
		o[o_i++] = spreadMethod;
		o[o_i++] = interpolationMethod;
		f[f_i++] = focalPointRatio;
		
	}
	
	
	public function lineStyle (thickness:Null<Float>, color:Int, alpha:Float, pixelHinting:Bool, scaleMode:LineScaleMode, caps:CapsStyle, joints:JointStyle, miterLimit:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = LINE_STYLE;
		o[o_i++] = thickness;
		i[i_i++] = color;
		f[f_i++] = alpha;
		b[b_i++] = pixelHinting;
		o[o_i++] = scaleMode;
		o[o_i++] = caps;
		o[o_i++] = joints;
		f[f_i++] = miterLimit;
		
	}
	
	
	public function lineTo (x:Float, y:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = LINE_TO;
		f[f_i++] = x;
		f[f_i++] = y;
		
	}
	
	
	public function moveTo (x:Float, y:Float):Void {
		
		prepareWrite ();
		
		types[t_i++] = MOVE_TO;
		f[f_i++] = x;
		f[f_i++] = y;
		
	}
	
	
	private function prepareWrite ():Void {
		
		if (copyOnWrite) {
			
			types = types.copy ();
			b = b.copy ();
			i = i.copy ();
			f = f.copy ();
			o = o.copy ();
			ff = ff.copy ();
			ii = ii.copy ();			
			
			copyOnWrite = false;
			
		}
		
	}
	
	
	public function overrideMatrix (matrix:Matrix):Void {
		
		prepareWrite ();
		
		types[t_i++] = OVERRIDE_MATRIX;
		o[o_i++] = matrix;
		
	}
	
	
	public function windingEvenOdd ():Void {
		
		prepareWrite ();
		
		types[t_i++] = WINDING_EVEN_ODD;
		
	}
	
	
	public function windingNonZero ():Void {
		
		prepareWrite ();
		
		types[t_i++] = WINDING_NON_ZERO;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function get_length ():Int {
		
		return t_i;
		
	}


	private function __initFromEmpty ():Void {
		
		types = empty.types;
		
		b = empty.b;
		i = empty.i;
		f = empty.f;
		o = empty.o;
		ff = empty.ff;
		ii = empty.ii;
		
		copyOnWrite = true;
		
	}
}

