import { Component, OnInit } from '@angular/core';
import { AuthService, User } from '../auth/auth.service';
import { DatabaseService } from '../database.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.page.html',
  styleUrls: ['./profile.page.scss'],
})
export class ProfilePage implements OnInit {

  user: User;
  constructor(
    private authSRV: AuthService,
    private dbSRV: DatabaseService) { }

  ngOnInit() {
    this.user = this.authSRV.user;
    this.dbSRV.getDatabaseState().subscribe(arg => this.dbSRV.select());

  }

}
