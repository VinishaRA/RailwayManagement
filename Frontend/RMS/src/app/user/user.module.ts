import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HomeComponent } from './home/home.component';
import { MaterialModule } from '../material/material.module';
import { FlexLayoutModule } from '@angular/flex-layout';
import { TrainDetailsComponent } from './train-details/train-details.component';
import { RouterModule } from '@angular/router';
import { TrainStopsDialogComponent } from './train-stops-dialog/train-stops-dialog.component';
import { BookingComponent } from './booking/booking.component';
import { PaymentDialogComponent } from './payment-dialog/payment-dialog.component';
import { UserHistoryComponent } from './user-history/user-history.component';



@NgModule({
  declarations: [
    HomeComponent,
    TrainDetailsComponent,
    TrainStopsDialogComponent,
    BookingComponent,
    PaymentDialogComponent,
    UserHistoryComponent
  ],
  imports: [
    CommonModule,
    MaterialModule,
    FlexLayoutModule,
    RouterModule
  ],
  exports: [
    HomeComponent
  ]
})
export class UserModule { }
