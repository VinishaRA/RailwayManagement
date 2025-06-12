import { Injectable } from '@angular/core';
import { HttpRoutingService } from './http-routing.service';
import { API } from '../constants/api-routes.constant';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  userId!: number;
  srcName!: string;
  desName!: string;
  scheduleDate!: string;
  constructor(private httpService: HttpRoutingService) {

    const storedUserId = localStorage.getItem('userId');
    const srcName = localStorage.getItem('srcName');
    const desName = localStorage.getItem('desName');
    const scheduleDate = localStorage.getItem('scheduleDate');

    if (storedUserId) {
      this.userId = +storedUserId;  // Retrieve and assign to userId, cast to number
    }
  this.srcName = srcName ?? '';   // If null, assign empty string
  this.desName = desName ?? '';
  this.scheduleDate = scheduleDate ?? '';
  }
  
  checkUserDetails(data:any) {
    return this.httpService.getMethod(API.CHECK_USER,data);
  }
  createUser(data : any) {
    return this.httpService.postMethod(API.CREATE_USER, data);
  }
}
