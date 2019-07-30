import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', loadChildren: () => import('./home/home.module').then( m => m.HomePageModule)},
  { path: 'auth', loadChildren: './auth/auth.module#AuthPageModule' },
  { path: 'places', loadChildren: './places/places.module#PlacesPageModule' },
  { path: 'offers', loadChildren: './places/offers/offers.module#OffersPageModule' },
  { path: 'new', loadChildren: './places/offers/new/new.module#NewPageModule' },
  { path: 'edit', loadChildren: './places/offers/edit/edit.module#EditPageModule' },
  { path: 'discovery', loadChildren: './places/discovery/discovery.module#DiscoveryPageModule' },
  { path: 'detail', loadChildren: './places/discovery/detail/detail.module#DetailPageModule' },
  { path: 'bookings', loadChildren: './places/offers/bookings/bookings.module#BookingsPageModule' },
  { path: 'bookings', loadChildren: './bookings/bookings.module#BookingsPageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
