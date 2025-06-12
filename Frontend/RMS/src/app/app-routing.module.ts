import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './user/home/home.component';
import { TrainDetailsComponent } from './user/train-details/train-details.component';
import { LoginComponent } from './shared/login/login.component';
import { SignUpComponent } from './shared/sign-up/sign-up.component';
import { AboutUsComponent } from './shared/about-us/about-us.component';
import { BookingComponent } from './user/booking/booking.component';
import { UserHistoryComponent } from './user/user-history/user-history.component';
import { AdminHomeComponent } from './admin/admin-home/admin-home.component';

const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  {path:'home',component: HomeComponent},
  {path:'login',component: LoginComponent},
  {path:'about-us',component: AboutUsComponent},
  { path: 'train-details', component: TrainDetailsComponent },
  { path: 'signup', component: SignUpComponent },
  { path: 'booking', component: BookingComponent },
  { path: 'history', component: UserHistoryComponent },
  { path: 'adminHome', component: AdminHomeComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
