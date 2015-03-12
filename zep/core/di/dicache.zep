
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Core\Di;

use Smce\Core\Di;
use Smce\Core\Di\DiAdapter;

class DiCache
{

	 /**
     * @var adapter
     */
	private static adapter;

	 /**
     * @var key
     */
	private static thisKey;

	 /**
     * @var singletonKey
     */
	private static thisSingletonKey=NULL;


	/**
    * @param string
    * @param string
    * @return void
    */
	public function __construct(key,singletonKey=NULL)
	{

		let self::thisKey=key;

		if singletonKey!=NULL
		{

			let self::thisSingletonKey=singletonKey;

		}

	}

	/**
    * @param int
    * @return void
    */
	public function cache(int duration=0)
	{

		if duration==0
		{

			throw new \Exception("duration is not empty");


		}

		if DiAdapter::set(self::thisKey,duration)
		{

			return true;

		}
		
		return false;
		
	}

	/**
    * @return bool
    */
	public function get()
	{
		return DiAdapter::get(self::thisKey);

	}

	/**
    * @return bool
    */
	public function remove()
	{
		return DiAdapter::remove(self::thisKey);

	}

}