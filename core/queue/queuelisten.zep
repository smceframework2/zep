/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework
 */

namespace Smce\Core\Queue;

use Smce\Core\Queue\QueueAdapter;
use Smce\Driver\Adapter;

class QueueListen
{
	/**
    *@var sleep
    */
	private static sleep;

	/**
    *@var stop
    */
	private static stop;


	/**
    *@var queKey
    */
	private static queKey;

	/**
    *@var adapter
    */
	private static adapter;
	
	 /**
    *@param adapter
    *@return void
    */
    public function __construct(adapter=NULL,string queKey=NULL)
    {

        if adapter!=NULL
        {
    
			ini_set("max_execution_time", -1);  	
        	ini_set("memory_limit", -1);
            QueueAdapter::setAdapter(adapter);

            let self::adapter=adapter;
           

        }else{

        	throw new \Exception("Adapter is not empty");

        }


        if queKey!=NULL
        {

            let self::queKey=queKey;

        }else{

        	throw new \Exception("Queue Key is not empty");

        }


    }

     /**
    *@return void
    */

	public function start()
	{
		var status,statusInt,sleepInt;

		

		self::changeStatus(self::queKey,1);

		while(true)
		{

			let status=self::getStatus(self::queKey);
			let statusInt=substr(status,0,1);

			if(statusInt==2)
			{

				break;

			}elseif(statusInt==3)
			{
				let sleepInt=(int)substr(status,2,strlen(status));
			
				sleep(sleepInt);
				
			
			}

			this->on();

			this->transactions(time());

			self::onPoint(self::queKey,time());
		}

	}

	private function on()
	{

		var on;

		let on=this->getOn(self::queKey);

		if time()>on+(60*5)
		{

			self::changeStatus(self::queKey,1);	
			this->setOn(self::queKey);
			
		}elseif empty(on)
		{
			self::changeStatus(self::queKey,1);	

		}
		
	}


	/**
    *@param string
    *@param int
    *@return bool
    */
	private static function setOn(queKey)
	{

		Adapter::setAdapter(self::adapter);

		if Adapter::set("QueueOn.".queKey,time(),60*60)
		{

			return true;

		}

		return false;

	}


	/**
    *@param string
    *@return string
    */
	private static function getOn(queKey)
	{
		Adapter::setAdapter(self::adapter);

		return Adapter::get("QueueOn.".queKey);

	}


	/**
    *@param time
    *@return void
    */

	private function transactions(time)
	{
		
		var arr=[],key,value,cs;

		let arr=QueueAdapter::get(self::queKey);

		if is_array(arr)
		{
			for key, value in arr 
			{ 
				
				
				self::onPoint(self::queKey,time());
				

				if time>=value["time"]
				{

					let cs=value["class"];
					
					if method_exists(cs,"fire")
					{
							
						self::lastTransactionTime(self::queKey,time());
						cs->fire();
						QueueAdapter::remove(self::queKey,key);
						
					}
					
				}
				
				

			}
		}
	}


	/**
    *@return void
    */
	public function stop()
	{

		self::changeStatus(self::queKey,2);

	}

    /**
    *@param int
    *@return void
    */

	public function sleep(int duration=0)
	{

		self::changeStatus(self::queKey,"3:".duration);

	}


	/**
    *@param string
    *@return bool
    */
	public function isQue(string queKey)
	{

		var arr=[];

		let arr=QueueAdapter::get(queKey);

		if count(arr)>1
		{

			return true;

		}else{

			return false;
		}

	}


	
	/**
    *@param string
    *@param int
    *@return bool
    */
	private static function onPoint(queKey,time)
	{

		Adapter::setAdapter(self::adapter);

		if Adapter::set("QueueOnPoint.".queKey,time,60*10)
		{

			return true;

		}

		return false;

	}


	/**
    *@param string
    *@return string
    */
	private static function getOnPoint(queKey)
	{
		Adapter::setAdapter(self::adapter);

		return Adapter::get("QueueOnPoint.".queKey);

	}

	/**
    *@param string
    *@param int
    *@return bool
    */
	private static function lastTransactionTime(queKey,time)
	{

		Adapter::setAdapter(self::adapter);

		if Adapter::set("QueueLastTransactionTime.".queKey,time,60*60*24*30)
		{

			return true;

		}


		return false;

	}


	/**
    *@return string
    */
	public function getLastTransactionTime()
	{
		Adapter::setAdapter(self::adapter);

		return Adapter::get("QueueLastTransactionTime.".self::queKey);

	}

	/**
    *@param string
    *@param int
    *@return bool
    */
	private static function changeStatus(queKey,status)
	{

		Adapter::setAdapter(self::adapter);

		if Adapter::set("QueueStatus.".queKey,status,60*60*24)
		{

			return true;

		}


		return false;

	}


	/**
    *@param string
    *@return string
    */
	private static function getStatus(queKey)
	{
		Adapter::setAdapter(self::adapter);

		return Adapter::get("QueueStatus.".queKey);

	}

	/**
    *@return array
    */
	public function status()
	{

		var arr=[
			0:"Uninitialized",
			1:"Working",
			2:"Not Working",
			3:"Sleep"
		];

		var reArr=[], que, status, statusInt;
		int onPointTime;
		int onlineMin;
		let onlineMin=60*5;

		let status=self::getStatus(self::queKey);

		let statusInt=substr(status,0,1);

		if !empty(status)
		{

			let que=statusInt;


		}else{

			let que=0;
		}
		

		if statusInt==1
		{

			let onPointTime=(int)self::getOnPoint(self::queKey);
			
			if (onPointTime+onlineMin)<time()
			{

				let que=2;

			}
		}

		let reArr=["status":que,"msg":arr[que]];
		
		return reArr;

	}


	/**
    *
    *@return false|array
    */
    public static function getAll()
    {

        if QueueAdapter::isAdapter()==true
        {

            return QueueAdapter::get(self::queKey);

        }

        return false;

    }

}