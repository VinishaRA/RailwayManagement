import { Component } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.scss']
})
export class SignUpComponent {
  myForm !: FormGroup
  hidePassword: boolean = true; 

  constructor(
    private AuthService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar,
  ) { }

  ngOnInit() {
    this.formInitial();
  }

  formInitial() {
    this.myForm = new FormGroup({
      name: new FormControl('', Validators.required), 
      email: new FormControl('', [Validators.required, Validators.email]),
      password: new FormControl('', [Validators.required, Validators.minLength(6)]),
      role: new FormControl('', Validators.required),
      phoneNumber: new FormControl('', [Validators.required, Validators.pattern('^[0-9]*$')]), 
      address: new FormControl('', Validators.required),
    });
  }

  createUser() {
    if (this.myForm.valid) {
      const formData = this.myForm.value;
      this.AuthService.createUser(formData).subscribe(
        response => {
          console.log('User created successfully', response);
          this.openSnackBar("Congratulations! Your account has been set up successfully.");
          this.router.navigate(['login']);
        },
        error => {
          console.error('Error creating user', error);
        }
      );
    }
  }

  openSnackBar(message: string) {
    this.snackBar.open(message, 'Close', {
      duration: 5000, // Duration in milliseconds
    });
  }
  
  togglePasswordVisibility() {
    this.hidePassword = !this.hidePassword;
  }

  backToLogin() {
    this.router.navigate(['login']);
  }
}
