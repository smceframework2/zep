/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */

namespace Smce\Core;

use Smce\Core\Di\DiSingleton;
use Smce\Core\Di\DiCache;
use Smce\Core\Di\DiAdapter;

class Di 
{

    /**
     * @var dis
     */
	private  static dis;


    /**
    *@param adapter
    *@return void
    */
    public function __construct(adapter=NULL)
    {

        if adapter!=NULL
        {

            DiAdapter::setAdapter(adapter);

        }

    }

    /**
    *@param string
    *@param Closure
    *
    *@return void|DiCache
    */
    public static function bind(string key,<\Closure> $class)
    {

     
        let self::dis[ strtolower(key) ] = {$class}();

        if DiAdapter::isAdapter()==true
        {

            return new DiCache(key);

        }

    }
    
    /**
    *@param string
    *@return value|false
    */
    public static function resolve(string key)
    {


        if DiAdapter::isAdapter()==true
        {

            var diCache, get;

            let diCache = new DiCache(key);
            let get=diCache->get();
           
            if !empty(get) 
            {

                return get;

            }
            

        }

        if isset self::dis[ strtolower( key )] {
            
            return self::dis[ strtolower(key) ];

        }

            
        return false;
       
    }


    /**
    *@param string
    *@param Closure
    *
    *@return new Di\Singleton
    */

    public static function singleton(string key,<\Closure> $class)
    {   

        let self::dis[ strtolower(key) ] = {$class}();

        return new Di\DiSingleton(key,{$class}());

    }


    /**
    *@param string
    *
    *@return bool
    */
    public static function remove(string key="") -> bool
    {

        bool bl=false;

        if isset self::dis[ strtolower(key) ]
        {
            unset self::dis[ strtolower(key) ];
            
            let bl=true;
        }

        if DiAdapter::isAdapter()==true
        {

            var diCache, remove;

            let diCache = new DiCache(key);
            if diCache->remove()
            {

               let bl=true;    
                
            }
            
        }


        if bl==true
        {

            return true;

        }

        return false;

    }


    /**
    *@param string
    *
    *@return bool
    */
    public static function has(string key="")
    {

        if DiAdapter::isAdapter()==true
        {

            var diCache, get;

            let diCache = new DiCache(key);
            let get=diCache->get();
           
            if !empty(get) 
            {
                
                return true;

            }
             

        }

        if isset self::dis[ strtolower(key) ]
        {

            return true;

        }


        return false;

    }


    /**
    *
    *@return void
    */
    public static function reset()
    {
        var key, value;

        for key,value in self::dis
        {
            unset self::dis[key];

            if DiAdapter::isAdapter()==true
            {

                var diCache;

                let diCache = new DiCache(key);
                diCache->remove();

            }

        } 


    }

    /**
    *
    *@return array
    */
    public static function  getKeys() -> array
    {
        var arr=[], key, value;
        int i=0;

        for key,value in self::dis
        {

            let arr[i]=key;
            let i++;
        }

        return arr;
    }

    /**
    *
    *@return array
    */
    public static function  getAll() -> array
    {

        return self::dis;
        
    }

    /**
    *
    *@return int
    */
    public static function getCount() -> int
    {
    
        if is_array(self::dis){

            return count(self::dis);

        }else{

            return 0;
        }
        
    }


}




    
    
