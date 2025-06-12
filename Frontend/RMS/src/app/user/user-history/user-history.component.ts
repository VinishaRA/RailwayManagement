import { Component } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { TicketBookingService } from 'src/app/services/ticket-booking.service';

@Component({
  selector: 'app-user-history',
  templateUrl: './user-history.component.html',
  styleUrls: ['./user-history.component.scss'],
})
  


export class UserHistoryComponent {
  trainDetails: any;
  displayedColumns: string[] = ['position', 'personName', 'personAge', 'gender', 'berthChoice'];
  srcName!: string;
  desName!: string;
  constructor(
    private ticketBookingService: TicketBookingService,
    private authService : AuthService
)
  { }


  ngOnInit() {
    this.getBookingDetails(this.authService.userId);
    this.srcName = this.authService.srcName;
    this.desName = this.authService.desName;
  }
  getBookingDetails(id: number) {
    this.ticketBookingService.getBookingDetails(id).subscribe((response : any) => {
      console.log('response', response);
      this.trainDetails = response.map((detail: any) => ({
        ...detail,
        formattedBookingDate: new Date(detail.bookingDate).toLocaleDateString()
      }));
    })
  }



}
