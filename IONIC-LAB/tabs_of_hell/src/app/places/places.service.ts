import { Injectable, OnInit } from "@angular/core";
import { Places } from "./places.model";

@Injectable({
  providedIn: "root"
})
export class PlacesService implements OnInit {
  private _places: Places[] = [
    new Places(
      "p1",
      "Primeiro Lugar",
      "Um Lugar Legal",
      "https://picsum.photos/501/201",
      9
    ),
    new Places(
      "p2",
      "Segundo Lugar",
      "Outro Lugar Legal",
      "https://picsum.photos/502/202",
      18
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    ),
    new Places(
      "p3",
      "Terceiro Lugar",
      "Mais Um Lugar Legal",
      "https://picsum.photos/500/200",
      27
    )
  ];
  constructor() {}
  get places() {
    return [...this._places];
  }
  getPlace(id: string) {
    return { ...this._places.find(p => p.id === id) };
  }
  ngOnInit() {}
}
