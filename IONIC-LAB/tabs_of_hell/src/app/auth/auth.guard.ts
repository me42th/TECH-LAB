import { Injectable } from "@angular/core";
import {
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  UrlTree,
  CanLoad,
  UrlSegment,
  Router
} from "@angular/router";
import { Observable } from "rxjs";
import { Route } from '@angular/compiler/src/core';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: "root"
})
export class AuthGuard implements CanLoad {
  constructor(
    private authSRV: AuthService,
    private router: Router){}
  canLoad(
    route: Route,
    segments: UrlSegment[]
  ): Observable<boolean> | Promise<boolean> | boolean {
    if(!this.authSRV.userIsAuthenticated)
    {
      console.log('auth');
      this.router.navigateByUrl('/auth');
    }
    return this.authSRV.userIsAuthenticated;
  }
}
