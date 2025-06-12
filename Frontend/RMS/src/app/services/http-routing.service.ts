import { Injectable } from '@angular/core';
import { environment } from '../environments/emvironment';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class HttpRoutingService {

  API_URL = environment.apiUrl;

  constructor(private http: HttpClient) { }
  
  getMethod(url: string, params?: any) {
    console.log('params',params); 
    return this.http.get(this.API_URL + url, { params });
  };
  postMethod<T>(url: string, data: any) {
    console.log('data',data);
    return this.http.post(this.API_URL + url,data)
  };
}
