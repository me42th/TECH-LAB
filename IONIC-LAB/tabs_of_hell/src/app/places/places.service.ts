import { Injectable, OnInit } from "@angular/core";
import { Places } from "./places.model";
import { AuthService } from '../auth/auth.service';
import { BehaviorSubject } from 'rxjs';
import { take, map, filter } from 'rxjs/operators';

@Injectable({
  providedIn: "root"
})
export class PlacesService implements OnInit {
  cont1 = 500;
  cont2 = 200;
  cont = 3;

  private _places: Places[] = [
    new Places(
      "p1",
      "Primeiro Lugar",
      "Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      9,
      new Date('2019-05-02'),
      new Date('2019-12-13') , 'u1'
      
      ),
      new Places(
        "p2",
        "Segundo Lugar",
        "Outro Lugar Legal",
        "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
        18,
        new Date('2019-05-02'),
        new Date('2019-12-13') , 'u1'
        )
      ];
  private _behaviorPlaces = new BehaviorSubject<Places[]>([new Places(
    "p1",
    "Primeiro Lugar Behavior",
    "Um Lugar Animado",
    "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
    9,
    new Date('2019-05-02'),
    new Date('2019-12-13') , 'u1'
    
    ),
    new Places(
      "p2",
      "Segundo Lugar Behavior",
      "Um Lugar Animal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      18,
      new Date('2019-05-02'),
      new Date('2019-12-13') , 'u1'
      )
    ]);
      constructor(private authSRV: AuthService) {}
  
  get places() {
    return [...this._places];
  } 

  

  addPlace(title: string, description: string, price: number, dateFrom: Date, dateTo: Date){
    console.log('Im here beach');
    const newPlace = new Places(
      "p"+(Math.random()*1000+100).toString(),
      title,
      description,
      "https://picsum.photos/"+400+"/"+100,
      price,
      dateFrom,
      dateTo, this.authSRV.userId
    );
    console.log(newPlace);
    //this._places.push(newPlace);
    this.behaviorPlaces.pipe(take(1)).subscribe(
      plc => {
        this._behaviorPlaces.next(plc.concat(newPlace));
        console.log('Im here bitch');
      }
    );
    //this._places = [newPlace, newPlace, newPlace, newPlace, newPlace, newPlace, newPlace];
  }
  
  get behaviorPlaces(){
    return this._behaviorPlaces.asObservable();
  }

  getBehaviorPlace(id: string){
    return this.behaviorPlaces.pipe(take(1), map(
      plc => {
        return { ...plc.find(p => p.id === id)};
      }));
  }

  getPlace(id: string) {
    return { ...this._places.find(p => p.id === id) };
  }

  ngOnInit() {}
  
 
}/*,
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27,
      new Date('2019-05-02'),
      new Date('2019-12-13') , 'u1'
    ) , // /*
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    ),
    new Places(
      "p"+this.cont++,
      "Terceiro Lugar "+this.cont,
      "Mais Um Lugar Legal",
      "https://picsum.photos/"+this.cont1+++"/"+this.cont2++,
      27+this.cont,       new Date('2019-05-02'),       new Date('2019-12-13') , 'u1'
    )/* */
 // ];
 
//}
