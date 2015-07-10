/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework
 * @github https://github.com/smceframework2
 */
namespace Smce\Driver;

class Redis
{
    /**
     * @var array redis config
     */
    private config = [];
 
    /**
     * @var redis instance
     */
    private redis;
   
    
    /*
     * @return redis connect
     */
    public function getRedis()
    {
        
        return this->redis;
    }
    
    /*
     * @return void
     */
    public function setConfig(config)
    {
        let this->config = config;
    }

     /*
     * @return array
     */
    public function getConfig()
    {

        return this->config;
        
    }
    
    /**
     * @return void
     */
    public function connect()
    {
        
        if !isset this->config 
        {
            throw new \Exception("redis server configuration must have \"host\" and \"port\" values in array.");
        }
        
        if empty(this->config["host"]) && !empty(this->config["port"])
        {

            throw new \Exception("redis server configuration must have \"host\" and \"port\" not empty");

        }

        let this->redis =  new \Redis;

        if(!this->redis->connect(this->config["host"], this->config["port"]))
        {

             throw new \Exception("Failed on connecting to redis server at " . $this->config["host"] . ":" . this->config["port"]);

        }

    }
    
    /**
     * @param string
     *
     * @return mixed
     */
    public function get(string key)
    {
        
        return this->redis->get(key);
    }
    
     /**
     * @param string
     * @param mixed
     * @param int
     *
     * @return set
     */
    public function set(string key,string value,int duration)
    {
        
        return this->redis->set(key, value, duration);
    }


     /**
     * @param string
     * @param mixed
     * @param int
     *
     * @return delete
     */
    public function delete(string key)
    {
        
        return this->redis->delete(key);
    }
    
    /**
     * @param string
     * @param mixed
     *
     * @return lpush
     */
    public function lpush(string key,string value)
    {
        
        return this->redis->lpush(key, value);
    }
    
    /**
     * @param string
     * @param long
     * @param long
     *
     * @return lrange
     */
    public function lrange(string key, x, y)
    {
        
        return this->redis->lrange(key, x, y);
    }

    /**
     * @param string
     * @param string
     *
     * @return hdel
     */
    public function hdel(string key,string key2)
    {
        
        return this->redis->hdel(key,key2);
    }

}