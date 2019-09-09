import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', loadChildren: () => import('./home/home.module').then( m => m.HomePageModule)},
  { path: 'observable-hello-world', loadChildren: './observable-hello-world/observable-hello-world.module#ObservableHelloWorldPageModule' },
  { path: 'dummy', loadChildren: './dummy/dummy.module#DummyPageModule' },
  { path: 'reactive-form', loadChildren: './reactive-form/reactive-form.module#ReactiveFormPageModule' },
  { path: 'input-form', loadChildren: './input-form/input-form.module#InputFormPageModule' },
  { path: 'distinct-until-change', loadChildren: './distinct-until-change/distinct-until-change.module#DistinctUntilChangePageModule' },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
