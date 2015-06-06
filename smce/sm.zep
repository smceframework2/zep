namespace Smce;

use Smce\Components\I18n;

class Sm
{

    private static app = null;

    private static t = null;


    public static function app()
    {
        
        if self::app === null {
            let self::app =  new App();
        }
        
        return self::app;
    }


    public static function t(string str)
    {
        
        return I18n::t(str);

    }

}