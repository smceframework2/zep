
namespace Smce\Components;


class Collection
{
   

    protected items = [];
 
    public function __construct(items = [])
    {

        let this->items =  items;

    }
    

    public function each(<\Closure> callback)
    {
        array_map(callback, this->items);
        
        return this;
    }

    public function $fetch(string key)
    {
        
        return new $static(array_fetch(this->items, key));
    }
    

    public function map(<\Closure> callback)
    {
        
        return new $static(array_map(callback, this->items, array_keys(this->items)));

    }


    public function filter(<\Closure> callback)
    {
        
        return new $static(array_filter(this->items, callback));

    }

   

    public function pull(key, dt = null)
    {
        
        return array_pull(this->items, key, dt);

    }



    public function pop()
    {
        
        return array_pop(this->items);
    }

    public function diff(array items)
    {
        
        return new $static(array_diff(this->items, items));

    }
    
    
    public function getAll() -> array
    {
        
        return this->items;
    }


    public function first(<\Closure> callback = null, dt = null)
    {
        
        if is_null(callback) {
            
            return 
            count(this->items) > 0 ? reset(this->items) : null;
        }
        
        return array_first(this->items, callback, dt);
    }


    public function flatten()
    {
        
        return new $static(array_flatten(this->items));
    }

    public function get(key, dt = null)
    {
        
        if this->offsetExists(key) {
            
            return this->items[key];
        }
        
        return value(dt);
    }

    public function flip()
    {
        
        return new $static(array_flip(this->items));
    }

    public function has(key) -> bool
    {
        
        return this->offsetExists(key);
    }

    public function isEmpty() -> bool
    {
        
        return empty(this->items);
    }

    public function keys()
    {
        
        return new $static(array_keys(this->items));
    }

    public function lists(string value, string key = null) -> array
    {
        
        return array_pluck(this->items, value, key);
    }

    public function merge(array items)
    {
        
        return new $static(array_merge(this->items, items));
    }
    

    public function last()
    {
        
        return 
        count(this->items) > 0 ? end(this->items) : null;
    }
    
    public function offsetExists(key) -> bool
    {
        
        return array_key_exists(key, this->items);
    }

    public function prepend(value)
    {

        array_unshift(this->items, value);

    }

    public function reduce(callback, initial = null)
    {
        
        return array_reduce(this->items, callback, initial);

    }
    

    public function $reverse()
    {
        
        return new $static(array_reverse(this->items));
    }

    public function search(value, bool strict = false)
    {
        
        return array_search(value, this->items, strict);
    }

    public function shift()
    {
        
        return array_shift(this->items);
    }

    public function sort(<\Closure> callback)
    {
        uasort(this->items, callback);
        
        return this;
    }

    public function splice(int offset, int length = 0, replacement = [])
    {
        
        return new $static(array_splice(this->items, offset, length, replacement));
    }

 

    public function transform(<\Closure> callback)
    {
        let this->items =  array_map(callback, this->items);
        
        return this;
    }

    public function values()
    {
        
        return new $static(array_values(this->items));
    }


    public function unique()
    {

        return new $static(array_unique(this->items));

    }

    public function shuffle()
    {
        shuffle(this->items);
        
        return this;
    }

    public function count() -> int
    {
        
        return count(this->items);
    }
    

    public function push(value)
    {

        this->offsetSet(null, value);

    }



    public function offsetSet(key, value)
    {
        
        if is_null(key) {
            let this->items[] = value;
        } else {
            let this->items[key] = value;
        }

    }

    
}