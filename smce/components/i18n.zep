
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Components;

use Smce\Http\HttpException;

class I18n
{

	private static dir;

	private static lang;

	private static langArr;

	public function setDir(string dir)
	{

		let self::dir=dir;

	}

	public function setLang(string lang)
	{

		let self::lang=lang;

		let self::langArr=require(self::dir."/".self::lang.".php");
	}


	public static function t(string str,array arr=[])
	{
		var at=[];
		var at2=[];

		var key,value,str2;

		self::is();

		if isset(self::langArr[str]) && !empty(self::langArr[str])
		{

			if count(arr)>0
			{
				for key, value in arr 
				{
					let at[]=key;
					let at2[]=value;
				}


				let str2=str_replace(at,at2,self::langArr[str]);
				
				return str2;
			}else
			{
				return self::langArr[str];
			}
			
			

		}else{

			if count(arr)>0
			{
				for key, value in arr 
				{
					let at[]=key;
					let at2[]=value;
				}

				
				let str2=str_replace(at,at2,str);
				return str2;

			}else
			{
				return str;
			}
			
		}



	}

	private static function is()
	{

		if empty(self::lang)
		{

			throw new HttpException(403, "Set I18n 'setLang()'");

		}

		if empty(self::dir)
		{

			throw new HttpException(403, "Set I18n 'setDir()'");

		}

	}
	

}