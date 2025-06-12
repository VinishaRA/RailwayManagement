import { Injectable } from '@angular/core';
import { HttpRoutingService } from './http-routing.service';
import { API } from '../constants/api-routes.constant';

@Injectable({
  providedIn: 'root'
})
export class TicketBookingService {

  constructor(private httpService: HttpRoutingService) { }

  createBooking(data : any) {
    return this.httpService.postMethod(API.CREATE_BOOKING, data);
  }
  createPayment(data : any) {
    return this.httpService.postMethod(API.CREATE_PAYMENT, data);
  }
  getBookingDetails(id: number) {
    const url = `${API.GET_BOOKING_DETAILS}/${id}`; 
    return this.httpService.getMethod(url);
  }
  
}
