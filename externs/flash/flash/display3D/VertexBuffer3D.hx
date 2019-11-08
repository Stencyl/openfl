package flash.display3D;

#if flash
import openfl.utils.ByteArray;
import openfl.Vector;

#if lime
import lime.utils.ArrayBufferView;
#end

extern class VertexBuffer3D
{
	public function dispose():Void;
	public function uploadFromByteArray(data:ByteArray, byteArrayOffset:Int, startVertex:Int, numVertices:Int):Void;
	#if lime
	public inline function uploadFromTypedArray(data:ArrayBufferView):Void
	{
		uploadFromByteArray(data.buffer, data.byteOffset, 0, data.byteLength);
	}
	#end
	public function uploadFromVector(data:Vector<Float>, startVertex:Int, numVertices:Int):Void;
}
#else
typedef VertexBuffer3D = openfl.display3D.VertexBuffer3D;
#end
