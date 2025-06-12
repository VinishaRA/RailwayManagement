import { Injectable } from '@angular/core';
import { HttpRoutingService } from './http-routing.service';
import { API } from '../constants/api-routes.constant';

@Injectable({
  providedIn: 'root'
})
export class TrainDetailsService {

  constructor(private httpService: HttpRoutingService) { }
  
  getTrainDetails(data : any) {
    return this.httpService.getMethod(API.GET_TRAIN_DETAILS,data);
  }
  getAllStations() {
    return this.httpService.getMethod(API.GET_ALL_STATIONS);
  }

  getTrainStops(data : any) {
    return this.httpService.getMethod(API.GET_ALL_STOPS,data);
  }

  getTrainDetailsById(data: any) {
    const url = `${API.GET_TRAIN_DETAILS_BY_ID.replace('{trainId}', data.trainId)}`;
    return this.httpService.getMethod(url,data);
  }

 
}
