import { Component } from '@angular/core';
import { FormControl, FormGroup, UntypedFormControl, Validators } from '@angular/forms';
import { DatePipe } from '@angular/common';
import { Router } from '@angular/router';
import { TrainDetailsService } from 'src/app/services/train-details.service';
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
  providers:[DatePipe]
})
export class HomeComponent {
  sourceStation: UntypedFormControl = new UntypedFormControl(null);
  destinationStation: UntypedFormControl = new UntypedFormControl(null);

  source: any;
  destination: any;
  dateFilter: any;

  constructor(
    private datePipe: DatePipe,
    private router: Router,
    private trainDetailsService: TrainDetailsService
  ) { }
  // Quotes about journey
  quotes: string = `A train journey is often a delightful experience,
    offering a unique blend of adventure and relaxation. 
    As the train glides along the tracks, passengers can enjoy 
    the scenic landscapes that unfold outside their windows, from lush gree
    n fields and rolling hills to bustling towns and serene rivers. The rhythmic 
    sound of the train’s wheels creates a soothing backdrop, perfect for reading 
    a book, having a conversation, or simply daydreaming. 
    Whether it’s a short commute or a long-distance trip, 
    a train journey provides a chance to unwind and appreciate 
    the journey itself, making it a memorable part of any travel
     experience. 🚂🌄`;
  

  myForm!: FormGroup;
  sourceArray: any;
  destinationArray : any;
  
  ngOnInit() {
    this.formInitial();
    this.getStationDetails();
    this.dateFilter = (d: Date | null): boolean => {
      const today = new Date();
      today.setHours(0, 0, 0, 0); // Set to start of the day to exclude past dates
      return (d || new Date()) >= today; // Allow only today and future dates
    };
}
formInitial() {
  this.myForm = new FormGroup({
    srcName: new FormControl('', Validators.required),
    desName: new FormControl('', Validators.required),
    scheduleDate: new FormControl('', Validators.required),
  });
}

  getTrainDetails() {
    console.log('productDetails', this.myForm.valid);
    if (this.myForm.valid) {
      const trainDetails = this.myForm.value;
      localStorage.setItem('srcName',trainDetails.srcName);
      localStorage.setItem('desName',trainDetails.desName);
      localStorage.setItem('scheduleDate',trainDetails.scheduleDate);
      // Format the date to 'YYYY-MM-DD'
      const formattedDate = this.datePipe.transform(trainDetails.scheduleDate, 'yyyy-MM-dd');
      this.router.navigate(['/train-details'], {
        queryParams: {
          srcName: trainDetails.srcName,
          desName: trainDetails.desName,
          scheduleDate: formattedDate
        }
      });
    }
  }
  
getStationDetails() {
  this.trainDetailsService.getAllStations().subscribe((res: any) => {
    this.source = res;
    // this.stationsArray = res.map((station: any) => station.stationName);
    this.sourceArray = res;
    console.log(this.sourceArray,this.sourceArray[0].stationName); 
   })
  };

};


