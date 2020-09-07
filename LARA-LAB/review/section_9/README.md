# MODEL


## TINKER
**Insert**
```
use App\Brand;
Brand::all();
$brand = Brand::create(['name' => Samsung]);
```

**Select**
``` 
use App\Brand;
$brands = Brand::find([1,2]);
$brands = Brand::where('id','1')->get();
$brands = Brand::where('id','>','1')->get();
$brands = Brand::whereBetween('id',[1,2])->get();
$brands = Brand::whereNotBetween('id',[1,2])->get();
$brands = Brand::whereNotIn('id',[2,4])->get();
$brands = Brand::whereIn('id',[1,4])->get();
$brands = Brand::where('name','like','%e%')->get();
$brands = Brand::where('id','>',2)->where('name','like','%e%')->get();
$brands = Brand::where('id',1)->orWhere('id',3)->get();
``` 

**Select: (id>1 and id<4) and (name='lg' or name='apple')**
```
Brand::where(
        function($query){
            $query->where('id','>',1)->where('id','<',4);
        }
    )
    ->where(
        function($query){
            $query->where('name','lg')->orWhere('name','apple');
        }
    )->get();
```
