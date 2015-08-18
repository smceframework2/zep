namespace Smce;

use Smce\Components\I18n;
use Smce\Mvc\Layout;

class Sm
{

    private static app = null;

    private static theme = null;

    private static t = null;


    public static function app()
    {
        
        if self::app === null {
            let self::app =  new App();
        }
        
        return self::app;
    }


    public static function theme()
    {
        
        if self::theme === null {
            let self::theme =  new Layout();
        }
        
        return self::theme;
    }


    public static function t(string str,array arr=[])
    {
        
        return I18n::t(str,arr);

    }



}