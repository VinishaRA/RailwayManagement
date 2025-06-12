import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

export interface PeriodicElement {
  sequenceNumber: number;
  departureTime: string;
  arrivalTime: string;
  station: string;
}

@Component({
  selector: 'app-train-stops-dialog',
  templateUrl: './train-stops-dialog.component.html',
  styleUrls: ['./train-stops-dialog.component.scss']
})
  

export class TrainStopsDialogComponent {
  displayedColumns: string[] = ['sequenceNumber',  'arrivalTime', 'departureTime', 'station'];

  constructor(@Inject(MAT_DIALOG_DATA) public dataSource: PeriodicElement[]) {}

}
