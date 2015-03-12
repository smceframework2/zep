

/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */


namespace Smce\Mvc;


class Url
{
	

	private baseUrl;



	public function setBaseUrl(string url)
	{

		let this->baseUrl=url;

	}


	public function getBaseUrl()
	{

		return this->baseUrl;

	}


	public function get(string paramerter)
	{
		int len, i=1;
		var  baseUrl;

		let len=strlen(this->baseUrl);

		if substr(this->baseUrl,len-i,len) != "/"
		{

			let baseUrl=this->baseUrl . "/";

		}else
		{

			let baseUrl=this->baseUrl;

		}

		return baseUrl. paramerter;
	}



}

