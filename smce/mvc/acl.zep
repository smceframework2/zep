

/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
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
       
        var value,  ip, control=false;
    
        let ip=Sm::app()->ip;

             

        for value in this->rules
        {

            if in_array(Sm::app()->action,value["actions"] )
            {
                let control=true;

                if isset value["ip"] && !in_array(ip, value["ip"]) == true 
                {

                    throw new HttpException(403, "You do not have authority to allow");

                }
                 
               
               
                if isset value["expression"] && this->expressionControl(value["expression"]) != true 
                {
                    this->redirect(value["redirect"]);

                }
                       
                  

            }

        }

        if control==false
        {
            this->redirect(value["redirect"]);
           
        }
        
        
        return true;

    }



    private function redirect(string url)
    {

         header("refresh:4;url=".Sm::app()->baseUrl."/".url);
         throw new HttpException(404, "You do not have authority to allow");
         exit();

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