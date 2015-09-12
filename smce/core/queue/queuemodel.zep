
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Core\Queue;

use Smce\Core\Queue\QueueAdapter;
use Smce\Core\Queue\QueueModel;

class QueueModel
{

	 /**
     * @var key
     */
	private  key;

	 /**
     * @var queKey
     */
	private  queKey;

	 /**
     * @var class
     */
	private $class;

	
	/**
     * @var minute
     */
	private minute=0;


	/**
    * @param string
    * @param string
    * @return void
    */
	public function __construct(string queKey,string key,$class)
	{

		let this->key=key;
		let this->queKey=queKey;
		let this->$class=$class;

	}


	/**
    *@param int
    *@return this
    */
	public function addMinutes(double minute=0)
	{

		let this->minute=this->minute+(int)(minute*60);

		return this;
	}


	/**
    *@param int
    *@return bool|exception
    */
	public function register(int duration=0)
	{
		if duration!=0
        {
        	var time;

        	let time=time();

        	let time=time+this->minute;

            if QueueAdapter::set(this->queKey,this->key,this->$class,duration,time)
			{

				return true;

			}
		
	
        }else{

        	throw new \Exception("Duration is not empty");

        }
		
		return false;


	}


}