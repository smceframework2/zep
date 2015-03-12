

/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework
 */


namespace Smce\Mvc;

use Smce\Core\EventManager;
use Smce\Components\Session;
use Smce\Sm;
use Smce\Http\HttpException;

class Acl
{
    private rules=[];

    /**
     * @param $accessRules
     * @param $view
     *
     * @return bool
     */

   public function setRule(array rule)
   {

        let this->rules[count(this->rules)]=rule;
        
   }

   public function getRules()
   {

        return this->rules;

   }
    
    public function run()
    {
       
        var value,  ip;
    
        let ip=Sm::app()->ip;
        
        for value in this->rules
        {

            if in_array(Sm::app()->action,value["actions"] )
            {

                   
                if isset value["ip"] && in_array(ip, value["ip"]) == true 
                {

                    throw new HttpException(404, "You do not have authority to allow");

                }
                 
               

                if this->loginControl(value["users"])==false
                {

                    if isset value["redirect"]
                    {

                        this->redirect(value["redirect"]);
                    }
                   
                     throw new HttpException(404, "You do not have authority to allow");
                }

               
                if isset value["expression"] && this->expressionControl(value["expression"]) != true 
                {
                     
                     throw new HttpException(404, "You do not have authority to allow");

                }
                       
                    

            }

        }
        
        
        return true;

    }


    private function redirect(string url)
    {

        if !empty(url)
        {

            header("Location:" . url);
            exit();

        }
    }

    
    /**
     * @param $users
     * @param $redirect
     *
     * @redirect url
     */
    private function loginControl(string users="")
    {
        var session;
    
        let session =  EventManager::pull("session");

        if users == "@" && (session==false || !session->getLoginState())
        {
        
            return false;

        }else
        {

            return true;
        }


    }
    
    /**
     * @param $expression
     *
     * @return bool
     */
    private function expressionControl(bool expression)
    {
        
        if expression === true {
            
            return true;
        }
    }

}