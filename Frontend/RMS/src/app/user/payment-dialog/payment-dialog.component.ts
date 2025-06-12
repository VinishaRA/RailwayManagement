import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { Router, RouterLink } from '@angular/router';
import { TicketBookingService } from 'src/app/services/ticket-booking.service';

@Component({
  selector: 'app-payment-dialog',
  templateUrl: './payment-dialog.component.html',
  styleUrls: ['./payment-dialog.component.scss']
})
  
export class PaymentDialogComponent {
  todayDate!: string;
  constructor(
    public dialogRef: MatDialogRef<PaymentDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: { amount: number, bookingId: string },
    private BookingService: TicketBookingService,
    private router: Router,

  ) { 
    this.todayDate = new Date().toISOString().slice(0, 10);
  }
  closeDialog(): void {
    this.dialogRef.close();
    this.router.navigate(['/home']);
  }
  
    createPayment(): void {
      const paymentData = {
        amount: this.data.amount,
        bookingId: this.data.bookingId,
        // paymentDate : this.todayDate
      }
      this.BookingService.createPayment(paymentData).subscribe(
        (response: any) => {
          console.log('Payment created successfully', response);
          this.dialogRef.close();
          this.router.navigate(['/history']);
        }
        )
      }
}
