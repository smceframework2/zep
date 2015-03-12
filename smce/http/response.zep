
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework2
 */


namespace Smce\Http;


use Smce\Http\HttpException;


class Response extends HttpException
{
	
	
    public function __construct(int httpCode,string msg) -> void
    {

       throw new HttpException(httpCode,msg);

    }

}