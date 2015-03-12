/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework
 */
namespace Smce\Core;


class EventManager
{

    private  static evts;
    

    public static function __callStatic(string key,array params)
    {

        var es;

        if substr(key,0,3)=="get"
        {
            let es =   strtolower(substr(key,3,strlen(key)));

        }else{

            let es =  strtolower(key);

        }
        

        if !isset self::evts[es] || !is_callable(self::evts[es])
        {

            throw new \Exception("Method Not Found Exception");
            
        }

      

        return call_user_func_array(self::evts[es], params);
    }


    public  function __call(string key,array params)
    {

        var es;

        if substr(key,0,3)=="get"
        {
            let es =   strtolower(substr(key,3,strlen(key)));

        }else{

            let es =  strtolower(key);

        }

        if !isset self::evts[es] || !is_callable(self::evts[es])
        {

            throw new \Exception("Method Not Found Exception");
            
        }

      

        return call_user_func_array(self::evts[es], params);
    }


      
    public static function push(key,<\Closure> $class) -> void
    {
       
         let self::evts[ strtolower(key) ] = $class;

    }



    public static function pull(string key)
    {
        
        if isset self::evts[strtolower(key)] 
        {
            
            return self::evts[strtolower(key)];

        } else {
            
            return false;
        }
    }





    public static function bind(string key,<\Closure> $class) -> void
    {

        let self::evts[ strtolower(key) ] = {$class}();

    }
    



    public static function remove(string key="") -> bool
    {

        if isset self::evts[ strtolower(key) ]
        {
            unset self::evts[ strtolower(key) ];
            return true;

        }

        return false;

    }


    public static function has(string key="") -> bool
    {

        if isset self::evts[ strtolower(key) ]
        {

            return true;

        }

         return false;

    }



    public static function reset()
    {
        var key, value;

        for key,value in self::evts
        {
            unset self::evts[key];

        } 

    }

    public static function  getKeys() -> array
    {
        var arr=[], key, value;
        int i=0;

        for key,value in self::evts
        {

            let arr[i]=key;
            let i++;
        }

        return arr;
    }

    public static function  getAll() -> array
    {

        return self::evts;
        
    }



    public static function getCount() -> int
    {

        if is_array(self::evts){

            return count(self::evts);

        }else{

            return 0;
        }
        
    }



}