package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_vt323_regular_ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy44:assets%2Fimages%2FBuy%20Lame%20Souvenirs.pngy4:sizei68641y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y27:assets%2Ffont%2FVT323.woff2R2i7020R3y6:BINARYR5R7R6tgoR2i153116R3y4:FONTy9:classNamey38:__ASSET__assets_font_vt323_regular_ttfR5y33:assets%2Ffont%2FVT323-Regular.ttfR6tgoR0y45:assets%2Fdata%2FTheSimpleTestMysteryTour.jsonR2i528R3y4:TEXTR5R13R6tgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_images_buy_lame_souvenirs_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_font_vt323_woff2 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_vt323_regular_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_thesimpletestmysterytour_json extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:image("Assets/images/Buy Lame Souvenirs.png") #if display private #end class __ASSET__assets_images_buy_lame_souvenirs_png extends lime.graphics.Image {}
@:file("Assets/font/VT323.woff2") #if display private #end class __ASSET__assets_font_vt323_woff2 extends haxe.io.Bytes {}
@:font("Export/html5/obj/webfont/VT323-Regular.ttf") #if display private #end class __ASSET__assets_font_vt323_regular_ttf extends lime.text.Font {}
@:file("Assets/data/TheSimpleTestMysteryTour.json") #if display private #end class __ASSET__assets_data_thesimpletestmysterytour_json extends haxe.io.Bytes {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_font_vt323_regular_ttf') #if display private #end class __ASSET__assets_font_vt323_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/VT323-Regular"; #else ascender = 800; descender = -200; height = 1000; numGlyphs = 587; underlinePosition = -149; underlineThickness = 50; unitsPerEM = 1000; #end name = "VT323 Regular"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__assets_font_vt323_regular_ttf') #if display private #end class __ASSET__OPENFL__assets_font_vt323_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_vt323_regular_ttf ()); super (); }}


#end
#end