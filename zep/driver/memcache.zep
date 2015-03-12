/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */
namespace Smce\Driver;

class Memcache
{
    /**
     * @var array memcache config
     */
    private config = [];

    /**
     * @var memcache instance
     */
    private memcache;
  
    
     /*
     * @return memcache connect
     */
    public function getMemcache()
    {
        
        return this->memcache;
    }
    
    /*
     * @return array
     */
    public function setConfig(config)
    {
        
        let this->config = config;

    }


    /*
     * @return memcache getconfig
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
        
        if !isset this->config {
            throw new Exception("MemCache server configuration must have \"host\" and \"port\" values in array.");
        }
        
        if empty(this->config["host"]) && !empty(this->config["port"]) 
        {
            
            throw new Exception("MemCache server configuration must have \"host\" and \"port\" not empty");

        }


        let this->memcache = new \Memcache;

         if(!this->memcache->connect(this->config["host"], $this->config["port"])){

             throw new Exception("Failed on connecting to memcache server at " .this->config["host"] . ":" . this->config["port"]);

        }
    }


    
    /**
     * @param string
     *
     * @return string
     */
    public function get(string key)
    {
        
        return this->memcache->get(key);
    }
    
    /**
     * @param string
     * @param string
     * @param bool
     * @param int
     *
     * @return set
     */
    public function set(string key, string value,bool bolen,int duration)
    {
        
        return this->memcache->set(key, value, bolen, duration);
    }
    
    /**
     * @param string
     * @param string
     * @param bool
     * @param int
     *
     * @return add
     */
    public function add(string key,string value,bool bolen,int duration = 10)
    {
        
        return this->memcache->add(key, value, bolen, duration);
    }
    
   /**
     * @param string
     * @param string
     *
     * @return addServer
     */
    public function addServer(host, port)
    {
        
        return this->memcache->addServer(host, port);
    }
    
    /**
     * 
     *
     * @return  $get
     *
     */
    public function close()
    {
        
        return this->memcache->close();
    }
    
     /**
     * @return  close
     *
     */
    public function decrement(string key,int item)
    {
        
        return this->memcache->decrement(key, item);
    }
    
    /**
     * @param string
     *
     * @return delete
     */
    public function delete(string key)
    {
        
        return this->memcache->delete(key);
    }
    
    /**
     *
     * @return flush
     */
    public function flush()
    {
        
        return this->memcache->flush();
    }
    
    /**
     * 
     * @return getExtendedStats
     */
    public function getExtendedStats()
    {
        
        return this->memcache->getExtendedStats();
    }
    
    /**
     * @param string
     * @param string
     *
     * @return getServerStatus
     */
    public function getServerStatus(string host, port)
    {
        
        return this->memcache->getServerStatus(host, port);
    }
    
    /**
     *
     * @return getStats
     */
    public function getStats()
    {
        
        return this->memcache->getStats();
    }
    
    /**
     * 
     *
     * @return getVersion
     */
    public function getVersion()
    {
        
        return this->memcache->getVersion();
    }

     /**
     * @param string
     * @param int
     *
     * @return increment
     */
    public function increment(string key,int item)
    {
        
        return this->memcache->increment(key, item);
    }
    
    /**
     * @param string
     * @param string
     *
     * @return pconnect
     */
    public function pconnect(string host, port)
    {
        
        return this->memcache->pconnect(host, port);
    }
    
    /**
     * @param string
     * @param string
     * @param bool
     * @param int
     *
     * @return replace
     */
    public function replace(string key,string value,bool bol,int duration)
    {
        
        return this->memcache->replace(key, value, bol, duration);
    }
    
     /**
     * @param int
     * @param float
     *
     * @return setCompressThreshold
     */
    public function setCompressThreshold(int i,float d)
    {
        
        return this->memcache->setCompressThreshold(i, d);
    }

}