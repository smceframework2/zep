
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Driver;


class Adapter
{
	 /**
    *@var MAX
    */
    const MAX = 2592000;

	 /**
     * @var prefix
     */
	private static prefix="smceAdapter.";

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
	public static function set(string key,str,int duration)
	{
		

		
		if self::adapterName=="Memcache"
		{

			self::adapter->set(self::prefix.key,str,false,duration);
			return true;

		}elseif self::adapterName=="Redis"
		{
			
			self::adapter->set(self::prefix.key,str,duration);
			return true;

		}
			
		
		
		return false;
		

	}

	/**
    * @param string
    * @return function
    */
	public static function get(string key)
	{
		
		return self::adapter->get(self::prefix.key);

	}

	/**
    * @param string
    * @return bool
    */
	public static function remove(key)
	{
	
	
		if self::adapterName=="Memcache"
		{

			self::adapter->delete(self::prefix.key);
			return true;

		}elseif self::adapterName=="Redis"
		{
			
			self::adapter->hdel(self::prefix.key);
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

		}elseif self::adapterName==NULL && strpos(get_class(adapter),"Redis")
		{

			let self::adapterName="Redis";

		}elseif self::adapterName==NULL
		{

			throw new \Exception("only Memcache and Redis");

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