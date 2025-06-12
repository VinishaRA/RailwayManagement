import { Component, OnInit } from '@angular/core';
import { FormArray, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { TicketBookingService } from 'src/app/services/ticket-booking.service';
import { TrainDetailsService } from 'src/app/services/train-details.service';
import { PaymentDialogComponent } from '../payment-dialog/payment-dialog.component';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-booking',
  templateUrl: './booking.component.html',
  styleUrls: ['./booking.component.scss']
})
export class BookingComponent implements OnInit {
  
  myForm1!: FormGroup;  // For train details
  myForm2!: FormGroup;  // For persons
  myForm3!: FormGroup;  // Account details
  myForm4!: FormGroup;  // Payment details
  trainDetails: any;
  trainId: number | null = null;
  scheduleDate: string | null = '';
  srcName: string = '';
  desName: string = '';
  selectedPrice: number = 0; 
  totalPersons: number = 0; 
  totalPrice: number = 0;
  scheduleId: any;
  constructor(
    private route: ActivatedRoute,
    private trainDetailsService: TrainDetailsService,
    private ticketBookingService: TicketBookingService,
    private authService: AuthService,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {
    // Initialize forms
    this.initializeForms();
    
    // Get route parameters
    this.route.queryParams.subscribe(params => {
      this.trainId = params['trainId'];
      this.scheduleDate = params['scheduleDate'];
      this.scheduleId = params['scheduleId'];
      this.srcName = params['srcName'];
      this.desName = params['desName'];
      
      if (this.trainId && this.scheduleDate) {
        this.getTrainDetailsById();
      }
    });
  }

  initializeForms(): void {
    this.formInitial1();
    this.myForm2 = new FormGroup({
      persons: new FormArray([this.createPersonForm()]) // Start with one person form
    });
    this.formInitial3();
    this.formInitial4();
  }

  getTrainDetailsById() {
    this.trainDetailsService.getTrainDetailsById({ trainId: this.trainId, scheduleDate: this.scheduleDate })
      .subscribe(
        (response: any) => {
          this.trainDetails = response;
          
          // Patch values into form after receiving the data
          this.myForm1.patchValue({
            trainNumber: this.trainDetails.trainNumber || '',
            trainName: this.trainDetails.name || '',
            classType: this.trainDetails.classType || '',
            scheduleDate: this.scheduleDate || '',
            srcName: this.srcName || '',
            desName: this.desName || '',
            price:  ''
          });
        },
        (err: any) => {
          console.error('Error fetching train details:', err);
        }
      );
  }

  formInitial1() {
    this.myForm1 = new FormGroup({
      trainNumber: new FormControl(''),
      trainName: new FormControl(''),
      classType: new FormControl('',Validators.required),
      price: new FormControl(''),
      srcName: new FormControl(''),
      desName: new FormControl(''),
      scheduleDate: new FormControl(''),
    });
  }

  formInitial3() {
    this.myForm3 = new FormGroup({
      accountNumber: new FormControl('',Validators.required),
      bankName: new FormControl('',Validators.required),
      accountHolderName: new FormControl('',Validators.required),
      ifscCode: new FormControl('',Validators.required),
      phoneNumber: new FormControl('',Validators.required),
      email: new FormControl('',Validators.required),
    });
  }

  formInitial4() {
    this.myForm4 = new FormGroup({
      personsCount: new FormControl(''),
      classType: new FormControl(''),
      price: new FormControl(''),
      additionalCharge: new FormControl(50),
      totalFare: new FormControl(''),
    });
  }

  createPersonForm(): FormGroup {
    return new FormGroup({
      personName: new FormControl('',Validators.required),
      personAge: new FormControl('',Validators.required),
      gender: new FormControl('',Validators.required),
      berthChoice: new FormControl('',Validators.required),
    });
  }

  onClassTypeChange(selectedPriceObj: any): void {
    this.selectedPrice = selectedPriceObj.price;
    this.myForm1.patchValue({ price: this.selectedPrice });
    this.calculateTotal();
  }

  // Add a new person form to the FormArray
  addPerson(): void {
    const personsArray = this.persons();
    personsArray.push(this.createPersonForm()); // Push a new form instance for the new person
    this.calculateTotal();
  }

  // Get the FormArray from the form
  persons(): FormArray {
    return this.myForm2.get('persons') as FormArray;
  }

  // Submit form data for all persons and train details
  submitForm(): void {
    if (this.myForm2.valid && this.myForm1.valid && this.myForm3.valid && this.myForm4.valid && this.authService.userId) {
      const formData = {
        trainDetails: this.myForm1.value,
        persons: this.myForm2.value.persons,
        account: this.myForm3.value, 
        payment: this.myForm4.value,
        trainId: this.trainId,
        userId: this.authService.userId,
        scheduleId : this.scheduleId
      };
      console.log('Submitted Form Data:', formData);
      this.ticketBookingService.createBooking(formData).subscribe(
        (response: any) => {
          console.log('User created successfully', response);
          this.dialog.open(PaymentDialogComponent, {
            width:'500px',
            data: { amount: response?.bookingData?.totalFare, bookingId: response?.bookingData?.id },          });
        },
        error => {
          console.error('Error creating user', error);
        }
      );
     
    } else {
      window.alert('The form is invalid. Please ensure all required fields are completed!');
    }
  }
// Calculate total price based on selected class type and number of persons
calculateTotal(): void {
  this.totalPersons = this.persons().length; // Get the total number of persons
  this.totalPrice = (this.selectedPrice * this.totalPersons) + this.myForm4.get('additionalCharge')?.value; // Calculate total price

  // Patch calculated values into the payment form
  this.myForm4.patchValue({
    personsCount: this.totalPersons,
    classType: this.myForm1.get('classType')?.value?.classType,
    price: this.selectedPrice,
    totalFare: this.totalPrice
  });
}
  removePerson(index: number): void {
    const personsArray = this.persons();
    if (index > 0) {
      personsArray.removeAt(index); // Remove the form group at the specified index
      this.calculateTotal();
    } else {
      alert("At least one person's details must be provided.");
    }
  }
}
