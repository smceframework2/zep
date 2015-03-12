namespace Smce;

class Sm
{

    private static app = null;

    public static function app()
    {
        
        if self::$app === null {
            let self::$app =  new App();
        }
        
        return self::$app;
    }

}