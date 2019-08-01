import { NgModule } from "@angular/core";
import { RouterModule,Routes } from '@angular/router';
import { PlacesPage } from './places.page';

const routes: Routes =
[
    { path: 'tabs', component: PlacesPage, children: [
            // normal load
            { path: '', redirectTo: '/places/tabs/discover', pathMatch: 'full'},
            { path: 'discover', children: [
                {   // places/tabs/discover
                    path: '', 
                    loadChildren: './discover/discover.module#DiscoverPageModule'
                },
                {   // places/tabs/discover/{id}
                    path: ':placeid',
                    loadChildren: './discover/details/details.module#DetailsPageModule'
                }
             ]
            },
            { path: 'offers', children: [
                {   // places/tabs/offers  
                    path: '',
                    loadChildren: './offers/offers.module#OffersPageModule'
                },
                {   // places/tabs/offers/new
                    path: 'new',
                    loadChildren: './offers/new/new.module#NewPageModule'
                },
                {   // places/tabs/offers/edit/{id}
                    path: 'edit/:placeid',
                    loadChildren: './offers/edit/edit.module#EditPageModule'
                },
                {   // places/tabs/{id}
                    path: ':placeid',
                    loadChildren: './offers/booking/booking.module#BookingPageModule'
                }
             ]
            }
        ]
    },
  { path: 'booking', loadChildren: './offers/booking/booking.module#BookingPageModule' },
  // normal load
  { path: '', redirectTo: '/places/tabs/discover', pathMatch: 'full'}
    
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})

export class PlacesRoutingModule{}