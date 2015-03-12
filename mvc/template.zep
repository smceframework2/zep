
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework
 */


namespace Smce\Mvc;

use Smce\Http\HttpException;
 
class Template 
{
	
	/**
	 * @var layout
	 */
	private layout;
	

	/**
	 * @var layoutDirectory
	 */
	private layoutDirectory;


	/**
	 * @var view
	 */
	private view=[];
	
	/**
	 * @var viewDirectory
	 */
	private viewDirectory;
	
	/**
	 * @var error
	 */
	public error=[];

	/**
	 * @var content
	 */
	private content="";
	
	
	/**
	 * @param string
	 * @return void
	 */
	public function setLayout(string layout="")
	{

		let this->layout=layout;

	}


	/**
	 * @param string
	 * @return void
	 */
	public function setLayoutDirectory(string layoutDirectory="")
	{

		let this->layoutDirectory=layoutDirectory;

	}


	/**
	 * 
	 * @return string
	 */
	public function getLayout()
	{

		 return this->layout;

	}


	/**
	 * 
	 * @return string
	 */
	public function getLayoutDirectory()
	{

		 return this->layoutDirectory;

	}
	
	/**
	 * @param string
	 * @param array
	 * @return void
	 */
	public function setView(string view="",arr=[])
	{

		let this->view["view"]=view;
		let this->view["array"]=arr;

	}


	/**
	 * @param string
	 * @return void
	 */
	public function setViewDirectory(string viewDirectory="")
	{

		let this->viewDirectory=viewDirectory;

	}
	
	
	/**
	 * 
	 * @return string
	 */
	public function getView()
	{

		 return this->view;

	} 

	/**
	 * 
	 * @return string
	 */
	public function getViewDirectory()
	{

		 return this->viewDirectory;

	}


	
	/**
	 * 
	 *@return void
	 */
	public function run()
	{

		var viewFile, layoutFile;

		let layoutFile=this->layoutDirectory.DIRECTORY_SEPARATOR.this->layout.".php";

		let viewFile=this->viewDirectory.DIRECTORY_SEPARATOR.this->view["view"].".php";
		
		if(file_exists(viewFile))
		{	

			this->adjustmentView(viewFile);

		}else
		{

			throw  new HttpException(404,"View Not Found ".viewFile);

		}
				
			
		if(file_exists(layoutFile))
		{


			this->adjustmentLayout(layoutFile);
			
		}else
		{

			throw  new HttpException(404,"Layout Not Found ".layoutFile);

		}

	}
	
	

	
	/**
	 * 
	 * @return void
	 */
	private function adjustmentLayout(string layoutFile)
	{

		extract(["content":this->content]);
		require(layoutFile);

	}
	
	/**
	 * 
	 * @return void
	 */
	private function adjustmentView(string viewFile)
	{

		ob_start();
        extract(this->view["array"]);
        require(viewFile);
        let this->content = ob_get_contents();
        ob_end_clean();

	}
	
}

