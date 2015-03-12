/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Core;

use Smce\Core\Queue\QueueAdapter;
use Smce\Core\Queue\QueueModel;

class Queue
{

    /**
    *@var MAX
    */
    const MAX = 2592000;

    /**
    *@param adapter
    *@return void
    */
    public function __construct(adapter=NULL)
    {

        if adapter!=NULL
        {

            QueueAdapter::setAdapter(adapter);

        }else{

        	throw new \Exception("Adapter is not empty");

        }

    }

    /**
    *@param string
    *@param Closure
    *
    *@return false|DiCache
    */
    public static function bind(string queKey,string key,<\Closure> $class)
    {

        if QueueAdapter::isAdapter()==true
        {

            return new QueueModel(queKey,key,{$class}());

        }

        return false;

    }

    /**
    *@param string
    *
    *@return false|array
    */
    public static function resolve(string queKey)
    {

        if QueueAdapter::isAdapter()==true
        {

            return QueueAdapter::get(queKey);

        }

        return false;

    }


    /**
    *@param string
    *@param string
    *
    *@return bool
    */
    public static function remove(string queKey,string key)
    {

        if QueueAdapter::isAdapter()==true
        {

            return QueueAdapter::remove(queKey,key);

        }

        return false;

    }

    /**
    *@param string
    *@param string
    *
    *@return bool
    */
    public static function removeQue(string queKey)
    {

        if QueueAdapter::isAdapter()==true
        {

            return QueueAdapter::removeQue(queKey);

        }

        return false;

    }

}
