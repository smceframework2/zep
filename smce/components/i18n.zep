
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

	private static dir_search;

	private static lang_list;

	private static lang;

	private static langArr;

	public function setDir(string dir)
	{

		let self::dir=dir;

	}

	public function setDirSearch(string dir)
	{

		let self::dir_search=dir;

	}

	public function setLangList(array list)
	{

		let self::lang_list=list;

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


	public function search()
	{
		var filelist=[],strings=[];

		if is_dir(self::dir_search)
		{

			var rii=[], path, xexplode,extensionsfile=["php"], ex, ab;

			let rii = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator(self::dir_search));
			
			let rii=iterator_to_array(rii);

			for path in rii
			{

			    if is_dir(path)==false
			    { 

			    	let ab=(string)path;

			        let xexplode = explode("/", ab);
			        let ab=end(xexplode);
			        let xexplode = explode(".", ab);
				    let ex= end(xexplode);

				    if in_array(ex, extensionsfile)
					{
				       let filelist[path->getPathname()] = count(file(path->getPathname())); 
				        
				    }
			    }
			   
			    
			}


			if count(filelist)>0
			{
				var key,value,liststring,out=[],file;

				for key,value in filelist
				{
					let file=file_get_contents(key);
					preg_match_all("#Sm::t\(\"(.*?)\"[ ,|, |,|\)]#",file,out);

					if count(out[1])>0
					{
						for value in out[1]
						{
							let strings[]=value;
						}
						
					}
				}
			}
			
		}

		let strings=array_unique(strings);
		sort(strings);

		return strings;
	}


	public function search_replace()
	{
		var strings=[],value,file,file_x,arr=[],returnArr=[];

		let strings=this->search();

		for value in self::lang_list
		{
			let file_x=self::dir."/".value.".php";

			if is_file(file_x)
			{
				let file=require(file_x);

				if is_array(file)
				{
					let arr=file;
					let arr=this->uniqueArr(arr);
					let arr=this->addArr(arr,strings);
					ksort(arr);
				}else{
					let arr=this->addArr(arr,strings);
					let arr=this->uniqueArr(arr);
					ksort(arr);
				}

				 unlink(file_x);

			}else{
				
				let arr=this->addArr(arr,strings);
				let arr=this->uniqueArr(arr);
				ksort(arr);
				
			}
			
			let returnArr[value]=arr;
			this->writeFile(arr,file_x);


		}

		this->out(returnArr);

		return returnArr;
		
	}

	private function out(arr)
	{
		if !is_dir(self::dir."/out")
		{
			mkdir(self::dir."/out", 0777);

			chmod(self::dir."/out", 0777);
		}

		var key, value, key2, value2,file_x, file;

		for key,value in arr
		{

			let file_x=self::dir."/out/".key.".txt";
			let file = fopen(file_x , "w");

			if(file)
			{
				for key2,value2 in value
				{
					if empty(value2)
					{
						fwrite (file ,key2."=|!|=\n");
					}
					

				}
			}

			fclose (file); 	
			chmod(file_x, 0777);
		}


	}

	public function in_replace()
	{
		if is_dir(self::dir."/in")
		{
			var value,file_x,file_x2,file,readArr=[],arr=[],ex=[],key2,value2,line;
			
			for value in self::lang_list
			{
				let file_x=self::dir."/in/".value.".txt";
				
				if file_exists(file_x)
				{	
					let readArr=[];

					let file = fopen(file_x,"r");
					while(!feof(file))
					{ 
					     let line = fgets(file);
					     let line=(string)line;
					     if !empty(line)
					     {
					     	 let ex=explode("=|!|=",line);

						     if isset(ex[0]) && isset(ex[1])
						     {
						     	if !empty(trim(ex[1]))
						     	{
						     		let readArr[ex[0]]=trim(ex[1]);
						     	}
						     	

						     }else
						     {
						     	return "error";
						     }
					     }
					    

					}

					fclose(file );


					let file_x2=self::dir."/".value.".php";

					if is_file(file_x2)
					{
						
						
						let file=require(file_x2);

						if is_array(file)
						{
							print_r(readArr);
							let arr=this->addArr2(file,readArr);
							let arr=this->uniqueArr(arr);
							ksort(arr);

							this->writeFile(arr,file_x2);

						}


						

					}


				}


			}
		}
	}

	private function uniqueArr(arr)
	{
		var arr2=[],key,value;

		for key,value in arr
		{

			if !isset(arr2[key])
			{
				let arr2[key]=value;
			}

		}

		return  arr2;

	}

	private function addArr(arr,arr2)
	{
		var key,value;

		for key,value in arr2
		{
			if !isset(arr[value])
			{
				let arr[value]="";
			}
		}

		return arr;
	}


	private function addArr2(arr,arr2)
	{
		var key,value;

		for key,value in arr2
		{
			if isset(arr[key])
			{
				let arr[key]=value;
			}
		}

		return arr;
	}



	private function writeFile(arr,file_x)
	{
		var file,value,key;

		if is_file(file_x)
		{

			unlink(file_x);
		}

		let file = fopen(file_x , "w");

		if(file)
		{

			fwrite (file ,"<?php") ;
			fwrite (file ,"\n" ) ;
			fwrite (file ,"\n" ) ;

			fwrite (file ,"		return array(" ) ;
			fwrite (file ,"\n" ) ;
			fwrite (file ,"\n" ) ;


		
			for key,value in arr
			{
				if !empty(key)
				{
					fwrite (file , "			\"".key."\"=>\"".value."\",");
					fwrite (file ,"\n" ) ;
				}
				
			}
			

			fwrite (file ,"		);" ) ;
			fwrite (file ,"\n" ) ;
			fwrite (file ,"\n" ) ;
			fwrite (file ,"?>" ) ;
			fclose (file); 	
			chmod(file_x, 0777);
		}else{
			echo "Dosya açılamadı!";
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
