
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */


namespace Smce\Mvc;

use Smce\Http\HttpException;

class Layout
{

	/**
	 * @var ContentDirectory
	 */
	private contentDirectory;

	private content=[];

	/**
	 * @param string
	 */
	public function setContentDirectory(string contentDirectory="")
	{

		let this->contentDirectory=contentDirectory;

	}


	/**
	 * 
	 * @return string
	 */
	public function getContentDirectory()
	{

		 return this->contentDirectory;

	}

	/**
     * @param string
     * @param array
	 *
	 * @return void
     */
	public function setContent(string view,arr=[])
	{
		
		let this->content=["view":view,"array":arr];

	}

	
	/**
	 *
	 * @return HttpException|include
     */
	public function run()
	{

		var contentFile;
		
		extract(this->content["array"]);

		let contentFile=this->contentDirectory.DIRECTORY_SEPARATOR.this->content["view"].".php";

			
		if is_file(contentFile)
		{

			require(contentFile);

		}else
		{
			
			throw  new HttpException(404,"Content Not Found ".contentFile);

		}

	}


	public function content($url,arr=[])
	{
		var contentFile;
		
		extract(arr);

		let contentFile=$url.".php";
	
		if is_file(contentFile) {
			
			require(contentFile);
		} else {
			throw  new HttpException(404,"Content Not Found ".contentFile);
		}
	}
	
}