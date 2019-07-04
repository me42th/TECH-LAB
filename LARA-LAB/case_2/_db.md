# MIGRATIONS

## ARTISAN 

## FILE

## CODE

**DB::table('cat')->get()**
**DB::table('cat')->pluck('nome')** retorna campo especificado
**DB::table('cat')->where('nome','like','%p%')->get()**
**DB::table('cat')->where('id',1)->orWhere('id',2)->get()**
**DB::table('cat')->whereBetween('id',[1,2])->get()**
**DB::table('cat')->whereNotBetween('id',[1,2])->get()**

<hr>
