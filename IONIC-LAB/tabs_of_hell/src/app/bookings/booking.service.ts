import { Injectable } from "@angular/core";
import { Booking } from "./booking.model";

@Injectable({providedIn: 'root'})
export class BookingService{
    private _bookings: Booking[] = [
        { 
            id: 'b1',
            placeId: 'p1',
            userId: 'u1',
            placeTitle: 'Primeiro Lugar',
            guestNumber: 5
        },
        { 
            id: 'b2',
            placeId: 'p2',
            userId: 'u1',
            placeTitle: 'Segundo Lugar',
            guestNumber: 10
        },
        { 
            id: 'b3',
            placeId: 'p3',
            userId: 'u3',
            placeTitle: 'Terceiro Lugar',
            guestNumber: 15
        }
    ];

    get bookings(){
        return [...this._bookings];
    }
}