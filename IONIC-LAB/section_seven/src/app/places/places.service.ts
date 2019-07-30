import { Injectable, OnInit } from '@angular/core';
import { Place } from './place.model';

@Injectable({
  providedIn: 'root'
})
export class PlacesService implements OnInit{
  constructor(private _places: Place[]) { }

  ngOnInit(){
    this._places = [
      {
        id: 'pl1',
        title: 'new yorque',
        description: 'new yorque city',
        imageUrl: 'https://picsum.photos/200/300',
        price: 1500
      },
      {
        id: 'pl2',
        title: 'salvador',
        description: 'salvador city',
        imageUrl: 'https://picsum.photos/200/300',
        price: 5500
      },
      {
        id: 'pl3',
        title: 'juazeiro',
        description: 'juazeiro city',
        imageUrl: 'https://picsum.photos/200/300',
        price: 4500
      },
      {
        id: 'pl4',
        title: 'petrolina',
        description: 'petrolina city',
        imageUrl: 'https://picsum.photos/200/300',
        price: 3500
      },
      new Place('pl5','terra nova','terra nova city','https://picsum.photos/200/300',8000)
    ];
  }

  get places(){
    return [...this._places];
  }
}
