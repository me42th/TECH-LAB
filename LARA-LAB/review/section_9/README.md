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
$brands = Brand::orderBy('name','desc')->desc();
$brands = Brand::whereNotIn('id',[2,4])->orderBy('name','desc')->get();
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

**[Collections](https://laravel.com/docs/7.x/collections)**
```
$brands = Brand::all()->last();
$brands = Brand::all()->first();
$brands = Brand::all()->toJson();
$brands = Brand::all()->pluck('name')->reverse();
$brands = Brand::all()->toArray();
$brands = Brand::all()->random();
$brands = Brand::all()->avg();
$brands = Brand::all()->max('id');
$brands = Brand::all()->min('id');
$brands = Brand::all()->sum('id');
$brands = Brand::all()->chunk(2)->random();
```