import { Component } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {

  myForm!: FormGroup;
  error: any;
  formdata: any;
  hidePassword: boolean = true;

  constructor(
    private authService: AuthService,
    private snackBar: MatSnackBar,
    private router: Router
  ) { }


  userSignIn() {
      if (this.myForm.valid) {
      this.formdata = this.myForm.value; 
        this.authService.checkUserDetails(this.formdata).subscribe(
          (response: any) => {
            console.log('Sign-in successful:', response);
            if (response.id) {
              localStorage.setItem('userId', response.id);
              this.authService.userId = response.id;
              if (response.role == "Admin") {
                this.router.navigate(['/adminHome']);
              }
              else {
                this.router.navigate(['/home']);
              }
            }
          },
          error => {
            this.error = error;
            console.error('Sign-in error:', error);
            this.openSnackBar("Please enter a valid email, password, and role.");
          }
        );
      }
  };
  
    openSnackBar(message: string) {
      this.snackBar.open(message, 'Close', {
        duration: 3000, // Duration in milliseconds
      });
  };
  
  formInitial() {
    this.myForm = new FormGroup({
      email: new FormControl('', Validators.required),
      password: new FormControl('', Validators.required),
      role: new FormControl('', Validators.required),
    });
  };

  ngOnInit() {
    this.formInitial();
  };

  navigateToSignUp() {
    this.router.navigate(['/signup']); 
  };

  togglePasswordVisibility() {
    this.hidePassword = !this.hidePassword; 
  };
  }

