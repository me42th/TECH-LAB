import { Injectable, OnInit } from '@angular/core';
import { Places } from './places.model';

@Injectable({
  providedIn: 'root'
})
export class PlacesService implements OnInit {
  private _places: Places[];
  constructor() { }
  get places(){
    return [... this._places];
  }
  ngOnInit(){
    this._places = [
      new Places(
        'p1',
        'Primeiro Lugar',
        'Um Lugar Legal',
        'https://picsum.photos/500/500',
        9
      ),
      new Places(
        'p2',
        'Segundo Lugar',
        'Outro Lugar Legal',
        'https://picsum.photos/500/500',
        18
      ),
      new Places(
        'p3',
        'Terceiro Lugar',
        'Mais Um Lugar Legal',
        'https://picsum.photos/500/500',
        27
      )
    ];
  }
}
