namespace Smce;

use Smce\Core\EventManager;

use Smce\Core\Smceframework;

class App
{

    private data = [];

    public function __construct() -> void
    {
        var config, key, value;
    
        let this->data["baseurl"] = self::baseUrl();
        let this->data["ip"] = this->getIP();
        let this->data["controller"] = str_replace("controller","",strtolower(Smceframework::controller)) ;
        let this->data["action"] = str_replace("action","",strtolower(Smceframework::action)) ;

        let config =  EventManager::pull("config");
        
        if config != false{
            for key, value in config {
                let this->data[key] = value;
            }
        }
    }
    
    public function __get(name)
    {
        if isset this->data[strtolower(name)]
        {

            return this->data[strtolower(name)];

        }   
        
    }
    
    /**
     *
     * @return ip addres
     */
    private function getIP()
    {
        var ip, tmp;
    
        
        if getenv("HTTP_CLIENT_IP") {
            let ip =  getenv("HTTP_CLIENT_IP");
        } else { 
        
        if getenv("HTTP_X_FORWARDED_FOR") {
            let ip =  getenv("HTTP_X_FORWARDED_FOR");
            
            if strstr(ip, ",") {
                let tmp =  explode(",", ip);
                let ip =  trim(tmp[0]);
            }
        }
         else {
            let ip =  getenv("REMOTE_ADDR");
        }}
        
        return ip;
    }
    
    
    
    public static function baseUrl()
    {
        
        return str_replace("/index.php", "", _SERVER["SCRIPT_NAME"]);
    }




}