import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { PlacesPage } from './places.page';

const routes: Routes = [
    {
        path: '',
        redirectTo: '/places/tabs/discovery',
        pathMatch: 'full'
    },
    {
        path: 'tabs',
        component: PlacesPage,
        children: [
            {
                path: 'discovery',
                children: [
                    {
                        path: '',
                        loadChildren: './discovery/discovery.module#DiscoveryPageModule'
                    },
                    {
                        path: ':placeid',
                        loadChildren: './discovery/detail/detail.module#DetailPageModule'
                    }
                ]
            },
            {
                path: 'offers',
                children: [
                    {
                        path: '',
                        loadChildren: './offers/offers.module#OffersPageModule'
                    },
                    {
                        path: 'new',
                        loadChildren: './offers/new/new.module#NewPageModule'
                    },
                    {
                        path: 'edit/:placeid',
                        loadChildren: './offers/edit/edit.module#EditPageModule'
                    },
                    {
                        path: ':placeid',
                        loadChildren: './offers/bookings/bookings.module#BookingsPageModule'
                    }
                ]
            },
            {
                path: '',
                redirectTo: '/places/tabs/discovery',
                pathMatch: 'full'
            }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PlacesRoutingModule{

}