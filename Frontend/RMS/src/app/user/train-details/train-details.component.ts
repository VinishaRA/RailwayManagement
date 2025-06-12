import { Component } from '@angular/core';
import { TrainDetailsService } from 'src/app/services/train-details.service';
import { ActivatedRoute, Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { TrainStopsDialogComponent } from '../train-stops-dialog/train-stops-dialog.component';
import { AuthService } from 'src/app/services/auth.service';
@Component({
  selector: 'app-train-details',
  templateUrl: './train-details.component.html',
  styleUrls: ['./train-details.component.scss']
})
export class TrainDetailsComponent {

  constructor(
    private route: ActivatedRoute,
    private trainDetailsService: TrainDetailsService,
    private dialog: MatDialog,
    private authService : AuthService
  ) { }
 
  errorMessage: string = '';
  trainDetails: any[] = [];
  srcName: string | null = '';
  desName: string | null = '';
  scheduleDate: string | null = '';

  ngOnInit(): void {
    this.route.queryParams.subscribe(params => {
      this.srcName =  params['srcName'];
      this.desName = params['desName'];
      this.scheduleDate = params['scheduleDate'];
      if (this.srcName && this.desName && this.scheduleDate) {
        this.fetchTrainDetails();
      }
    });
  }

  fetchTrainDetails() {
      this.trainDetailsService.getTrainDetails({
        srcName: this.srcName,
        desName: this.desName,
        scheduleDate: this.scheduleDate
      })
        .subscribe((response: any) => {
          console.log('Train details:', response.TrainDetails);
          this.trainDetails = response.TrainDetails;
        },
          (err) => {
          console.log('err,',err);
          this.errorMessage = err.error.error;
        });
  }

  getStationStops(trainId: string) {
    this.trainDetailsService.getTrainStops({ trainID: trainId }).subscribe(
      (response: any) => {
        this.openTrainStopsDialog(response);
      },
      (err) => {
        console.log(err);
      }
    );
  }

  openTrainStopsDialog(data: any): void {
    this.dialog.open(TrainStopsDialogComponent, {
      width: '800px',
      data: data
    });
  }
}
  
