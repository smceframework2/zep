/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */
namespace Smce\Core;

use Smce\Http\HttpException;
use Smce\Mvc\Acl;
use Smce\Sm;
use Smce\Core\Di\DiSingleton;

class Smceframework
{

    /**
     * @var controller
     */
    public static controller;

    /**
     * @var action
     */
    public static action;

    /**
     * @return void
     */
    public function make() -> void
    {
        ob_start();
        this->router();
        this->command();
        ob_end_flush();
    }

    /**
     * @return HttpException|void
     */
    private function router() -> void
    {
        var router, requestArray;

        let router =  Di::resolve("router");

        if router!=false
        {
             
             
             let self::controller = ucfirst(Di::resolve("router")->getControllerName()) . "Controller";
             let self::action =  "action" . ucfirst(Di::resolve("router")->getActionName());

        }else{

           throw new HttpException(404, "Set DI 'router'");
        }
       
    }

    /**
     * 
     * @return HttpException|void
     */
    private function command() -> void
    {
        var controller, paramerter,istance;
    
        if !this->isController() 
        {

            throw new HttpException(404, "Controller Not Found");

        }

         this->controllerAction();
    }

    

    /**
     * 
     * @return bool
     */
    private function isController()
    {
        
        if class_exists(self::controller) {
            
            return true;

        } else {
            
            return false;
        }
    }

    /**
     * 
     * @return HttpException|void
     */
    public function controllerAction() -> void
    {

        if method_exists(self::controller, self::action) {

            this->runAction();
           
        } else {

            throw new HttpException(404, "Page Not Found");

        }
    }

  

    /**
     * 
     * @return void
     */
    private function runAction()
    {

        DiSingleton::make(self::controller,self::action);

    }

    
  


}