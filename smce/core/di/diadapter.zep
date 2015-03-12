
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Core\Di;

use Smce\Core\Di;

class DiAdapter
{
	 /**
     * @var prefix
     */
	private static prefix="smceDi.";

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
	public static function set(key,duration)
	{
		

		if !self::adapter->get(self::prefix.key){

			if self::adapterName=="Memcache"
			{

				self::adapter->set(self::prefix.key,serialize(Di::resolve(key)),false,duration);
				return true;

			}elseif self::adapterName=="Redis"
			{
				
				self::adapter->set(self::prefix.key,serialize(Di::resolve(key)),duration);
				return true;

			}
			
		}
		
		return false;
		

	}

	/**
    * @param string
    * @return function
    */
	public static function get(key)
	{
	
		return unserialize(self::adapter->get(self::prefix.key));

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