
/**
 *
 * @author Samed Ceylan
 * @link http://www.samedceylan.com/
 * @copyright 2015 SmceFramework 2
 * @github https://github.com/smceframework
 */


namespace Smce\Http;

class HttpException extends \Exception
{
    private httpCode;

    private msg;

    public function __construct(int httpCode,string msg) -> void
    {
        let this->msg = msg;
        let this->httpCode = httpCode;

        this->http_response_code(this->httpCode);
    }
    
    public function getMsg()
    {
        
        return this->msg;
    }
    
    public function getHttpCode()
    {
        
        return this->httpCode;
    }
    
    public function htppError()
    {
        var httpError;

       
        let httpError = ["code" : this->httpCode, "msg" : this->msg];

        return httpError;
    }
    
    private function http_response_code(int code = NULL)
    {
        var text,protocol;

        switch (code) {
            case 100: let text = "Continue"; break;
            case 101: let text = "Switching Protocols"; break;
            case 200: let text = "OK"; break;
            case 201: let text = "Created"; break;
            case 202: let text = "Accepted"; break;
            case 203: let text = "Non-Authoritative Information"; break;
            case 204: let text = "No Content"; break;
            case 205: let text = "Reset Content"; break;
            case 206: let text = "Partial Content"; break;
            case 300: let text = "Multiple Choices"; break;
            case 301: let text = "Moved Permanently"; break;
            case 302: let text = "Moved Temporarily"; break;
            case 303: let text = "See Other"; break;
            case 304: let text = "Not Modified"; break;
            case 305: let text = "Use Proxy"; break;
            case 400: let text = "Bad Request"; break;
            case 401: let text = "Unauthorized"; break;
            case 402: let text = "Payment Required"; break;
            case 403: let text = "Forbidden"; break;
            case 404: let text = "Not Found"; break;
            case 405: let text = "Method Not Allowed"; break;
            case 406: let text = "Not Acceptable"; break;
            case 407: let text = "Proxy Authentication Required"; break;
            case 408: let text = "Request Time-out"; break;
            case 409: let text = "Conflict"; break;
            case 410: let text = "Gone"; break;
            case 411: let text = "Length Required"; break;
            case 412: let text = "Precondition Failed"; break;
            case 413: let text = "Request Entity Too Large"; break;
            case 414: let text = "Request-URI Too Large"; break;
            case 415: let text = "Unsupported Media Type"; break;
            case 500: let text = "Internal Server Error"; break;
            case 501: let text = "Not Implemented"; break;
            case 502: let text = "Bad Gateway"; break;
            case 503: let text = "Service Unavailable"; break;
            case 504: let text = "Gateway Time-out"; break;
            case 505: let text = "HTTP Version not supported"; break;
            default:
                trigger_error("Unknown http status code " . $code, E_USER_ERROR);
        }

        let protocol =  isset _SERVER["SERVER_PROTOCOL"] ? _SERVER["SERVER_PROTOCOL"] : "HTTP/1.0";
        header(protocol . " " . code . " " . text);
    }

}