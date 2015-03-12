/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework
 */
namespace Smce\Core;

class Loader

{
    private static dirs;

    private _registered = false;

    public function setDir(array dir) -> void
    {

        if is_array(self::dirs)
        {

            let self::dirs = array_merge(self::dirs , dir);

        }else
        {

             let self::dirs = dir;

        }
        
        
    }
    

    public function register() -> <Loader>
    {
        
        if this->_registered === false {

            spl_autoload_register([this, "autoLoad"]);
            let this->_registered = true;
        }
        
        return this;
    }


    public function autoLoad(string className) -> void
    {


        var parts, fileName="", namespa="", lastNsPos, value;

        let className = ltrim(className, '\\');
        let lastNsPos = strrpos(className, '\\');
        if lastNsPos 
        {
            let namespa = substr(className, 0, lastNsPos);
            let className = substr(className, lastNsPos + 1);
            let fileName  = str_replace('\\', DIRECTORY_SEPARATOR, namespa) . DIRECTORY_SEPARATOR;
        }

        let fileName .= str_replace('_', DIRECTORY_SEPARATOR, className) . ".php";

        for value in self::dirs     
        {
            int len, i=1;

            let len=strlen(value);

            if substr(value,len-i,len)!="/"
            {

               let value=value.DIRECTORY_SEPARATOR;

            }
            
            if is_file(value.fileName)
            {
                require(value.fileName);
                break;

            }
        }
    }
    
    
    

}