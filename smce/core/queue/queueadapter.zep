
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Core\Queue;

use Smce\Core\Queue;

class QueueAdapter
{
	 /**
     * @var prefix
     */
	private static prefix="smceQueue.";

	 /**
     * @var adapterName
     */
	private static queKey="";


	 /**
     * @var adapter
     */
	private static adapter=NULL;

	 /**
     * @var adapterName
     */
	private static adapterName=NULL;



	/**
    * @param string
    * @param int
    * @return bool
    */
	public static function set(queKey,key,$class,duration,time)
	{
		var arr, newArr=[];

		let self::queKey=queKey;
		
		if self::adapterName=="Memcache"
		{

			let arr=self::get(queKey);

			if !empty(arr) 
        	{

        		let newArr[key]=["class":$class,"time":time,"duration":duration];

        		let newArr=array_merge(arr,newArr);

        	}else{

        	
				let newArr[key]=["class":$class,"time":time,"duration":duration];

        	}

			self::adapter->set(self::prefix.self::queKey,serialize(newArr),false,duration);
			return true;

		}elseif self::adapterName=="Redis"
		{
			
			self::adapter->set(self::prefix.self::queKey,serialize(newArr),duration);
			return true;

		}
			
		
		
		return false;
		

	}


	/**
    * @param string
    * @param int
    * @return bool
    */
	public static function replace(queKey,key,arr,duration)
	{

		
		if self::adapterName=="Memcache"
		{
        	

			self::adapter->set(self::prefix.queKey,serialize(arr),false,duration);

			return true;

		}elseif self::adapterName=="Redis"
		{
			
			self::adapter->set(self::prefix.queKey,serialize(arr),duration);

			return true;

		}
			
		
		
		return false;
		

	}

	/**
    * @param string
    * @return function
    */
	public static function get(string queKey)
	{
	
		return unserialize(self::adapter->get(self::prefix.queKey));

	}

	/**
    * @param string
    * @param string
    * @return bool
    */
	public static function remove(string queKey, string key)
	{	
		var arr=[],duration;
	
		let arr=unserialize(self::adapter->get(self::prefix.queKey));
	
		let duration= arr[key]["duration"];

		if isset(arr[key])
		{
			unset(arr[key]);
		}
		

		self::replace(queKey,key,arr,duration);

	}

	/**
    * @param string
    * @return bool
    */
	public static function removeQue(string queKey)
	{	
		if self::adapterName=="Memcache"
		{

			self::adapter->delete(self::prefix.queKey);
			return true;

		}elseif self::adapterName=="Redis"
		{
			
			self::adapter->hdel(self::prefix.queKey);
			return true;
		}

		return false;

	}


	/**
    * @param adapter
    * @return void
    *
    * @return bool
    */
	public static function setAdapter(adapter)
	{

		if self::adapterName==NULL && strpos(get_class(adapter),"Memcache")
		{

			let self::adapterName="Memcache";

		}elseif self::adapterName==NULL && strpos(get_class(adapter),"ReQueues")
		{

			let self::adapterName="ReQueues";

		}elseif self::adapterName==NULL
		{

			throw new \Exception("only Memcache and ReQueues");

		}

		let self::adapter=adapter;

	}

	/**
    * @return bool
    */
	public static function isAdapter() -> bool
	{
		if self::adapter !=NULL
        {

        	return true;

        }

        return false;

	}
	
}