# BASIC OF THIS SHIT

## ARROW FUNCTION

###

## ARRAY 

### SEARCH ONE ITEM 

'''
var_array.find( item => { return item.var === value_to_equals; })
'''

### ADD ITEM

```
 array: string[] = ['Max','Anna','David'];
 array.push('name');

```

### DELETE ITEM
```
this.array.filter( item => {
      return item.id !== otherId;
    });
```

## PASS WITH REFERENCE

### ARRAY

```
return [... XXX];
```

### PRIVATE WITH MAGIC
```
 private _XXX: XXX[];
 [...] 
 get XXX(){
    return [...this._XXX];
  }
```

### OBJECT

```
return {... XXX};
```