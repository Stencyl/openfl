package;

import hxp.*;
import sys.FileSystem;

class RunScript
{
	public static function main()
	{
		var args = Sys.args();
		var cacheDirectory = Sys.getCwd();
		var workingDirectory = args.pop();

		try
		{
			Sys.setCwd(workingDirectory);
		}
		catch (e:Dynamic)
		{
			Log.error("Cannot set current working directory to \"" + workingDirectory + "\"");
		}

		if (args.length > 1 && args[0] == "create")
		{
			// args[1] = "openfl:" + args[1];
		}
		else if (args.length > 0 && args[0] == "setup")
		{
			var limeDirectory = Haxelib.getPath(new Haxelib("lime"));

			if (limeDirectory == null || limeDirectory == "" || limeDirectory.indexOf("is not installed") > -1)
			{
				System.createProcess("haxelib", ["install", "lime"]);
			}
		}
		else if (args.length > 0 && args[0] == "process")
		{
			Sys.exit(System.createProcess("haxelib", ["run", "swf"].concat(args)));
			return;
		}

		var args = ["run", "lime"].concat(args);
		Sys.exit(System.createProcess("haxelib", args.concat(["-openfl"])));
	}
}
