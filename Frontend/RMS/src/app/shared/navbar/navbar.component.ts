import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { MenuData } from 'src/app/models/user.model';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent {

  constructor(private router: Router) {}

  // It used for data that show in navbar.
  menuData: MenuData[] = [
    { label: 'Home', path: 'home', routerlink: '/home' },
    { label: 'History', path: 'about-us',routerlink: '/history' },
    { label: 'Logout', path: 'login' ,routerlink: '/login'},
    { label: 'About Us', path: 'about-us',routerlink: '/about-us' },
  ];

    // Function that returns true if the current route is '/login' or '/signup'
  isLoginPage(): boolean {
    return this.router.url === '/login' || this.router.url === '/signup';
  }
}
